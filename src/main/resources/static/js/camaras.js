// ═══════════════════════════════════════════════════════════════════
// SISTEMA DE ACTUALIZACIONES OPTIMISTAS - MÓDULO CÁMARAS
// ═══════════════════════════════════════════════════════════════════

// ─── Toast / Alerta de error ────────────────────────────────────────────
function mostrarAlertaError(mensaje) {
    let contenedor = document.getElementById('toastContainer');
    if (!contenedor) {
        contenedor = document.createElement('div');
        contenedor.id = 'toastContainer';
        contenedor.style.cssText = 'position:fixed;top:1.2rem;right:1.2rem;z-index:9999;display:flex;flex-direction:column;gap:0.5rem;max-width:360px;';
        document.body.appendChild(contenedor);
    }
    const toast = document.createElement('div');
    toast.style.cssText = 'background:#1a1a2e;color:#fff;border-left:4px solid #ef4444;border-radius:10px;padding:1rem 1.2rem;box-shadow:0 8px 32px rgba(0,0,0,0.35);display:flex;align-items:flex-start;gap:0.75rem;animation:slideInRight 0.3s ease;font-size:0.85rem;';
    toast.innerHTML = `
        <span class="material-symbols-outlined" style="color:#ef4444;font-size:1.3rem;margin-top:2px;flex-shrink:0;">cloud_off</span>
        <div style="flex:1;">
            <div style="font-weight:700;margin-bottom:2px;font-size:0.8rem;text-transform:uppercase;letter-spacing:0.5px;color:#ef4444;">Error de Base de Datos</div>
            <div style="color:#ccc;line-height:1.4;">${mensaje}</div>
            <div style="color:#888;font-size:0.72rem;margin-top:4px;">El cambio fue revertido en pantalla.</div>
        </div>
        <button onclick="this.closest('[id]').remove()" style="background:none;border:none;color:#888;cursor:pointer;padding:0;font-size:1.1rem;line-height:1;margin-left:4px;">✕</button>
    `;
    contenedor.appendChild(toast);
    setTimeout(() => toast.style.animation = 'fadeOutRight 0.4s ease forwards', 6000);
    setTimeout(() => toast.remove(), 6400);
}

// Inyectar keyframes de animación una sola vez
if (!document.getElementById('optimisticStyles')) {
    const s = document.createElement('style');
    s.id = 'optimisticStyles';
    s.textContent = `
        @keyframes slideInRight { from { opacity:0; transform:translateX(60px); } to { opacity:1; transform:translateX(0); } }
        @keyframes fadeOutRight { from { opacity:1; transform:translateX(0); } to { opacity:0; transform:translateX(60px); } }
        @keyframes fadeInRow    { from { opacity:0; transform:translateY(-8px); } to { opacity:1; transform:translateY(0); } }
        .cam-row-saving { opacity: 0.55; pointer-events: none; }
        .cam-row-saving td::after { content:''; }
    `;
    document.head.appendChild(s);
}

// ─── Helpers para el badge de estado ────────────────────────────────────
function getBadgeEstado(status) {
    if (status === 'Operativa')      return '<span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3 py-2">Operativa</span>';
    if (status === 'Mantenimiento')  return '<span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 rounded-pill px-3 py-2">Mantenimiento</span>';
    return `<span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 rounded-pill px-3 py-2">${status}</span>`;
}

function getZonaNombre(zonaId) {
    const sel = document.getElementById('camZona');
    if (!sel || !zonaId) return 'No asignada';
    const opt = sel.querySelector(`option[value="${zonaId}"]`);
    return opt ? opt.textContent : 'No asignada';
}

// ─── Actualizar estadísticas del encabezado sin recargar ─────────────────
function recalcularEstadisticas() {
    const rows = document.querySelectorAll('#tablaCamaras tbody tr[data-cam-id]');
    let total = 0, operativas = 0, mantenimiento = 0, inoperativas = 0;
    rows.forEach(row => {
        const status = row.getAttribute('data-cam-status');
        total++;
        if (status === 'Operativa')     operativas++;
        else if (status === 'Mantenimiento') mantenimiento++;
        else inoperativas++;
    });
    // Actualizar cards de estadísticas si existen
    const elTotal = document.getElementById('statTotal');
    const elOp    = document.getElementById('statOperativas');
    const elMant  = document.getElementById('statMantenimiento');
    const elInop  = document.getElementById('statInoperativas');
    if (elTotal) elTotal.textContent = total;
    if (elOp)    elOp.textContent    = operativas;
    if (elMant)  elMant.textContent  = mantenimiento;
    if (elInop)  elInop.textContent  = inoperativas;
}

// ─── ELIMINAR (Optimista) ────────────────────────────────────────────────
window.eliminarCamara = function(id) {
    if (!confirm('¿Estás seguro de eliminar la cámara ' + id + '?')) return;

    // 1. Guardar snapshot de la fila para poder revertir
    const fila = document.querySelector(`#tablaCamaras tr[data-cam-id="${id}"]`);
    if (!fila) return;
    const snapshot = fila.cloneNode(true);
    const nextSibling = fila.nextSibling;

    // 2. Quitar la fila INMEDIATAMENTE (optimista)
    fila.style.transition = 'opacity 0.25s, transform 0.25s';
    fila.style.opacity = '0';
    fila.style.transform = 'translateX(20px)';
    setTimeout(() => fila.remove(), 250);
    recalcularEstadisticas();

    // 3. Llamar a la BD en background
    fetch('/api/camaras/' + id, {
        method: 'DELETE',
        headers: {
            'Authorization': 'Bearer ' + sessionStorage.getItem('jwt_token')
        }
    })
    .then(res => {
        if (!res.ok) throw new Error(`Error del servidor (${res.status})`);
    })
    .catch(err => {
        // 4. REVERTIR si falla: reinsertar la fila en su posición original
        const tbody = document.querySelector('#tablaCamaras tbody');
        if (nextSibling && nextSibling.parentNode === tbody) {
            tbody.insertBefore(snapshot, nextSibling);
        } else {
            tbody.appendChild(snapshot);
        }
        snapshot.style.opacity = '1';
        snapshot.style.transform = 'none';
        recalcularEstadisticas();
        mostrarAlertaError('No se pudo eliminar la cámara <strong>' + id + '</strong>. Verifica la conexión con la base de datos. <br><small style="color:#aaa">' + err.message + '</small>');
    });
};

// ─── GUARDAR / EDITAR (Optimista) ────────────────────────────────────────
window.abrirModalAñadir = function() {
    try {
        document.getElementById('modalTitle').innerText = 'Registrar Cámara';
        document.getElementById('camId').value = '';
        document.getElementById('camId').readOnly = false;
        document.getElementById('camName').value = '';
        document.getElementById('camIp').value = '';
        document.getElementById('camLocation').value = '';
        document.getElementById('camZona').value = '';
        document.getElementById('camStatus').value = 'Mantenimiento';
        
        const modalEl = document.getElementById('camaraModal');
        let modal = bootstrap.Modal.getInstance(modalEl);
        if (!modal) modal = new bootstrap.Modal(modalEl);
        modal.show();
    } catch(e) {
        console.error("Error en abrirModalAñadir:", e);
        alert("Error al abrir modal: " + e.message);
    }
};

window.editarCamara = function(id, name, location, status, ip, zonaId) {
    try {
        document.getElementById('modalTitle').innerText = 'Editar Cámara';
        document.getElementById('camId').value = id;
        document.getElementById('camId').readOnly = true;
        document.getElementById('camName').value = name;
        document.getElementById('camLocation').value = location;
        document.getElementById('camStatus').value = status;
        document.getElementById('camIp').value = (ip === 'null' || !ip) ? '' : ip;
        document.getElementById('camZona').value = (zonaId === 'null' || !zonaId) ? '' : zonaId;
        
        const modalEl = document.getElementById('camaraModal');
        let modal = bootstrap.Modal.getInstance(modalEl);
        if (!modal) modal = new bootstrap.Modal(modalEl);
        modal.show();
    } catch(e) {
        console.error("Error en editarCamara:", e);
        alert("Error al abrir modal de edición: " + e.message);
    }
};

// Usar delegación de eventos para el formulario, ya que el DOM se reemplaza dinámicamente
document.addEventListener('submit', function(e) {
    if (e.target && e.target.id === 'camaraForm') {
        e.preventDefault();

        const id       = document.getElementById('camId').value.trim();
        const name     = document.getElementById('camName').value.trim();
        const location = document.getElementById('camLocation').value.trim();
        const status   = document.getElementById('camStatus').value;
        const ip       = document.getElementById('camIp').value.trim();
        const zonaId   = document.getElementById('camZona').value;
        const esEdicion = document.getElementById('camId').readOnly;

        // Construir params para el fetch
        const payload = {
            id: id,
            name: name,
            location: location,
            status: status,
            ipAddress: ip || null,
            zonaId: zonaId || null
        };

        const modalEl = document.getElementById('camaraModal');
        if (modalEl) {
            let modalObj = bootstrap.Modal.getInstance(modalEl);
            if (modalObj) modalObj.hide();
        }
        // Fallback forzoso para quitar el backdrop
        setTimeout(() => {
            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
            document.body.classList.remove('modal-open');
            document.body.style.overflow = '';
            document.body.style.paddingRight = '';
        }, 150);

        const tbody = document.querySelector('#tablaCamaras tbody');

        if (esEdicion) {
            // ── EDICIÓN OPTIMISTA ──────────────────────────────────────────
            const fila = document.querySelector(`#tablaCamaras tr[data-cam-id="${id}"]`);
            if (!fila) { if(window.SPA) SPA.reload(); return; }

            // Guardar snapshot de la fila original
            const snapshotHTML = fila.innerHTML;
            const snapshotStatus = fila.getAttribute('data-cam-status');

            // 1. Actualizar la fila INMEDIATAMENTE
            fila.setAttribute('data-cam-status', status);
            fila.classList.add('cam-row-saving');
            fila.innerHTML = `
                <td class="ps-4 py-3"><div class="fw-black text-dark" style="font-size:0.85rem;">${id}</div></td>
                <td class="py-3">
                    <div class="fw-bold text-dark" style="font-size:0.9rem;">${name}</div>
                    <div class="text-secondary" style="font-size:0.75rem;">${ip || 'Sin IP Asignada'}</div>
                </td>
                <td class="py-3">
                    <div style="font-size:0.85rem;" class="text-secondary">${location}</div>
                    <div class="text-muted" style="font-size:0.7rem;">Zona: ${getZonaNombre(zonaId)}</div>
                </td>
                <td class="py-3">${getBadgeEstado(status)}</td>
                <td class="text-end pe-4 py-3">
                    <button class="btn btn-sm btn-light text-primary fw-bold me-1" onclick="editarCamara('${id}', '${name.replace(/'/g,"\\'")}', '${location.replace(/'/g,"\\'")}', '${status}', '${ip}', '${zonaId}')">Editar</button>
                    <button class="btn btn-sm btn-light text-danger fw-bold" onclick="eliminarCamara('${id}')">Borrar</button>
                </td>
            `;
            recalcularEstadisticas();

            // 2. Sincronizar con BD en background
            fetch('/api/camaras/' + id, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + sessionStorage.getItem('jwt_token') },
                body: JSON.stringify(payload)
            })
            .then(res => res.text().then(txt => { if (!res.ok) throw new Error(txt || `Error ${res.status}`); }))
            .then(() => {
                fila.classList.remove('cam-row-saving'); // éxito: quitar indicador
            })
            .catch(err => {
                // REVERTIR
                fila.innerHTML = snapshotHTML;
                fila.setAttribute('data-cam-status', snapshotStatus);
                fila.classList.remove('cam-row-saving');
                recalcularEstadisticas();
                mostrarAlertaError('No se pudo guardar la cámara <strong>' + id + '</strong>. <br><small style="color:#aaa">' + err.message + '</small>');
            });

        } else {
            // ── INSERCIÓN OPTIMISTA ────────────────────────────────────────
            // 1. Quitar fila vacía si existe
            const filaVacia = tbody.querySelector('tr td[colspan]');
            if (filaVacia) filaVacia.closest('tr').remove();

            // 2. Crear fila nueva INMEDIATAMENTE
            const nuevaFila = document.createElement('tr');
            nuevaFila.setAttribute('data-cam-id', id);
            nuevaFila.setAttribute('data-cam-status', status);
            nuevaFila.style.animation = 'fadeInRow 0.3s ease';
            nuevaFila.classList.add('cam-row-saving');
            nuevaFila.innerHTML = `
                <td class="ps-4 py-3"><div class="fw-black text-dark" style="font-size:0.85rem;">${id}</div></td>
                <td class="py-3">
                    <div class="fw-bold text-dark" style="font-size:0.9rem;">${name}</div>
                    <div class="text-secondary" style="font-size:0.75rem;">${ip || 'Sin IP Asignada'}</div>
                </td>
                <td class="py-3">
                    <div style="font-size:0.85rem;" class="text-secondary">${location}</div>
                    <div class="text-muted" style="font-size:0.7rem;">Zona: ${getZonaNombre(zonaId)}</div>
                </td>
                <td class="py-3">${getBadgeEstado(status)}</td>
                <td class="text-end pe-4 py-3">
                    <button class="btn btn-sm btn-light text-primary fw-bold me-1" onclick="editarCamara('${id}', '${name.replace(/'/g,"\\'")}', '${location.replace(/'/g,"\\'")}', '${status}', '${ip}', '${zonaId}')">Editar</button>
                    <button class="btn btn-sm btn-light text-danger fw-bold" onclick="eliminarCamara('${id}')">Borrar</button>
                </td>
            `;
            tbody.appendChild(nuevaFila);
            recalcularEstadisticas();

            // 3. Sincronizar con BD en background
            fetch('/api/camaras', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + sessionStorage.getItem('jwt_token') },
                body: JSON.stringify(payload)
            })
            .then(res => res.text().then(txt => { if (!res.ok) throw new Error(txt || `Error ${res.status}`); }))
            .then(() => {
                nuevaFila.classList.remove('cam-row-saving'); // éxito
            })
            .catch(err => {
                // REVERTIR: quitar la fila insertada
                nuevaFila.style.transition = 'opacity 0.25s';
                nuevaFila.style.opacity = '0';
                setTimeout(() => {
                    nuevaFila.remove();
                    // Si el tbody quedó vacío, mostrar fila de "sin cámaras"
                    if (!tbody.querySelector('tr')) {
                        tbody.innerHTML = `<tr><td colspan="5" class="text-center py-5 text-muted">
                            <span class="material-symbols-outlined fs-1 opacity-50 mb-2">videocam_off</span>
                            <p class="mb-0">No hay cámaras registradas.</p>
                        </td></tr>`;
                    }
                    recalcularEstadisticas();
                }, 260);
                mostrarAlertaError('No se pudo registrar la cámara <strong>' + id + '</strong>. <br><small style="color:#aaa">' + err.message + '</small>');
            });
        }
    }
});

// ─── Reloj en vivo del visor ───────────────────────────────────────────
function updateLiveTime() {
    const el = document.getElementById('liveTime');
    if (el) el.textContent = new Date().toLocaleTimeString('es-MX', { hour12: false });
}
updateLiveTime();
setInterval(updateLiveTime, 1000);

// ─── Efecto ruido TV para cámara sin señal ────────────────────────────
function drawNoise() {
    document.querySelectorAll('.noSignalCanvas').forEach(canvas => {
        const ctx = canvas.getContext('2d');
        const w = canvas.width = 320;
        const h = canvas.height = 180;
        const imageData = ctx.createImageData(w, h);
        for (let i = 0; i < imageData.data.length; i += 4) {
            const v = Math.random() * 80;
            imageData.data[i]     = v;
            imageData.data[i + 1] = v;
            imageData.data[i + 2] = v;
            imageData.data[i + 3] = 200;
        }
        ctx.putImageData(imageData, 0, 0);
    });
}
setInterval(drawNoise, 80);

// ─── Lógica de Central de CCTV (Fullscreen) ─────────────────────────
window.currentCamIndex = 0;
window.currentLayout = 'grid'; // 'grid' | 'single'

window.openSurveillanceMode = function(layout = 'grid', index = 0) {
    window.currentLayout = layout;
    window.currentCamIndex = index;
    const ws = document.getElementById('cctvWorkspace');
    if (!document.fullscreenElement) {
        if (ws.requestFullscreen) ws.requestFullscreen();
        else if (ws.webkitRequestFullscreen) ws.webkitRequestFullscreen();
        else if (ws.msRequestFullscreen) ws.msRequestFullscreen();
    } else {
        applyLayout();
    }
};

document.addEventListener('fullscreenchange', (e) => {
    const ws = document.getElementById('cctvWorkspace');
    if (!ws) return;
    if (document.fullscreenElement === ws) {
        ws.style.padding = '4rem 1rem 1rem 1rem';
        ws.style.height = '100vh';
        const controls = document.getElementById('fsControls');
        if (controls) controls.classList.replace('d-none', 'd-flex');
        applyLayout();
    } else {
        ws.style.padding = '0';
        ws.style.height = 'auto';
        const controls = document.getElementById('fsControls');
        if (controls) controls.classList.replace('d-flex', 'd-none');
        resetLayout();
    }
});

function applyLayout() {
    const cols = document.querySelectorAll('#cameraGrid > div');
    const prevBtn = document.getElementById('prevCamBtn');
    const nextBtn = document.getElementById('nextCamBtn');
    
    if (window.currentLayout === 'grid') {
        if(prevBtn) prevBtn.classList.replace('d-block', 'd-none');
        if(nextBtn) nextBtn.classList.replace('d-block', 'd-none');
        cols.forEach(col => {
            col.className = 'col-6 p-1'; 
            col.style.display = 'block';
            col.style.height = '50%';
            col.querySelector('.cam-feed-wrapper').style.height = '100%';
        });
    } else {
        if(prevBtn) prevBtn.classList.replace('d-none', 'd-block');
        if(nextBtn) nextBtn.classList.replace('d-none', 'd-block');
        cols.forEach((col, index) => {
            if (index === window.currentCamIndex) {
                col.className = 'col-12 p-1';
                col.style.display = 'block';
                col.style.height = '100%';
                col.querySelector('.cam-feed-wrapper').style.height = '100%';
            } else {
                col.style.display = 'none';
            }
        });
    }
}

function resetLayout() {
    const cols = document.querySelectorAll('#cameraGrid > div');
    const prevBtn = document.getElementById('prevCamBtn');
    const nextBtn = document.getElementById('nextCamBtn');
    if(prevBtn) prevBtn.classList.replace('d-block', 'd-none');
    if(nextBtn) nextBtn.classList.replace('d-block', 'd-none');
    cols.forEach(col => {
        col.className = 'col-md-6 col-lg-3';
        col.style.display = 'block';
        col.style.height = 'auto';
        col.querySelector('.cam-feed-wrapper').style.height = '';
    });
}

window.setLayout = function(layout) {
    window.currentLayout = layout;
    applyLayout();
};

window.nextCam = function() {
    const cols = document.querySelectorAll('#cameraGrid > div');
    window.currentCamIndex = (window.currentCamIndex + 1) % cols.length;
    applyLayout();
};

window.prevCam = function() {
    const cols = document.querySelectorAll('#cameraGrid > div');
    window.currentCamIndex = (window.currentCamIndex - 1 + cols.length) % cols.length;
    applyLayout();
};

window.exitSurveillanceMode = function() {
    if (document.exitFullscreen) document.exitFullscreen();
    else if (document.webkitExitFullscreen) document.webkitExitFullscreen();
};
