<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<main class="main-content p-4 w-100">
    <div class="container-fluid max-w-7xl">
        
        <!-- Encabezado -->
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h4 class="fw-bolder text-dark mb-1">Módulo de Cámaras</h4>
                <p class="text-muted mb-0" style="font-size: 0.85rem;">Gestión e inventario de dispositivos CCTV de la red</p>
            </div>
            <button class="btn btn-dark fw-bold rounded-3 px-4 py-2" onclick="abrirModalAñadir()">
                <span class="material-symbols-outlined fs-5 align-middle me-1">add_circle</span> Añadir Cámara
            </button>
        </div>

        <!-- Estadísticas -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4 bg-primary text-white">
                    <div class="card-body">
                        <span class="text-white opacity-75 fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Total Instaladas</span>
                        <h2 class="fw-black mt-2 mb-0" id="statTotal">${totalCount}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="text-success fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Operativas</span>
                        <h2 class="fw-black mt-2 mb-0 text-dark" id="statOperativas">${operativasCount}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="text-warning fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">En Mantenimiento</span>
                        <h2 class="fw-black mt-2 mb-0 text-dark" id="statMantenimiento">${mantenimientoCount}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="text-danger fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Inoperativas / Fallo</span>
                        <h2 class="fw-black mt-2 mb-0 text-dark" id="statInoperativas">${inoperativasCount}</h2>
                    </div>
                </div>
            </div>
        </div>

        <!-- ─── GRID DE VISUALIZACIÓN EN VIVO ─── -->
        <div class="card border-0 shadow-sm rounded-4 mb-4 overflow-hidden">
            <div class="card-header bg-dark text-white border-0 py-3 d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <span class="spinner-grow spinner-grow-sm text-success" role="status"></span>
                    <span class="fw-bold text-uppercase" style="font-size: 0.7rem; letter-spacing: 1px;">Centro de Visualización — EN VIVO</span>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-sm btn-primary rounded-pill d-flex align-items-center gap-1 shadow-sm" onclick="openSurveillanceMode('grid', 0)" style="font-size: 0.75rem;">
                        <span class="material-symbols-outlined" style="font-size: 1rem;">grid_view</span> Central CCTV
                    </button>
                    <span id="liveTime" class="text-secondary d-flex align-items-center" style="font-size: 0.7rem; font-family: monospace;"></span>
                </div>
            </div>
            <div class="p-3 bg-dark">
                <div id="cctvWorkspace" class="bg-dark position-relative w-100" style="transition: all 0.3s ease;">
                    <!-- Controles de cabecera solo visibles en Fullscreen -->
                    <div id="fsControls" class="d-none justify-content-between align-items-center p-3 position-absolute top-0 w-100 z-3" style="background: linear-gradient(rgba(0,0,0,0.9), transparent);">
                        <div class="text-white fw-bold d-flex align-items-center gap-2">
                            <span class="status-indicator bg-danger"></span>
                            CENTRAL DE VIDEOVIGILANCIA
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-sm btn-dark border-secondary d-flex align-items-center gap-1" onclick="setLayout('grid')">
                                <span class="material-symbols-outlined" style="font-size:1rem;">grid_view</span> 4x4
                            </button>
                            <button class="btn btn-sm btn-dark border-secondary d-flex align-items-center gap-1" onclick="setLayout('single')">
                                <span class="material-symbols-outlined" style="font-size:1rem;">fullscreen</span> Enfoque
                            </button>
                            <button class="btn btn-sm btn-danger d-flex align-items-center gap-1 ms-3" onclick="exitSurveillanceMode()">
                                <span class="material-symbols-outlined" style="font-size:1rem;">close</span> Cerrar
                            </button>
                        </div>
                    </div>
                    
                    <!-- Flechas de navegación (modo enfoque) -->
                    <button id="prevCamBtn" class="d-none position-absolute start-0 top-50 translate-middle-y btn btn-dark bg-opacity-75 z-3 p-2 border-0 rounded-end ms-1" onclick="prevCam()">
                        <span class="material-symbols-outlined text-white" style="font-size:2rem;">chevron_left</span>
                    </button>
                    <button id="nextCamBtn" class="d-none position-absolute end-0 top-50 translate-middle-y btn btn-dark bg-opacity-75 z-3 p-2 border-0 rounded-start me-1" onclick="nextCam()">
                        <span class="material-symbols-outlined text-white" style="font-size:2rem;">chevron_right</span>
                    </button>

                    <div class="row g-2 h-100" id="cameraGrid">

                    <c:choose>
                        <c:when test="${empty camaras}">
                            <div class="col-12 text-center py-5">
                                <span class="material-symbols-outlined text-secondary mb-2" style="font-size: 3rem;">videocam_off</span>
                                <h6 class="text-white fw-bold">Sin cámaras registradas</h6>
                                <p class="text-secondary small mb-0">Agrega una cámara para visualizar el feed.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cam" items="${camaras}" varStatus="loop">
                                <div class="col-md-6 col-lg-3">
                                    <div id="camFeed${loop.index}" class="cam-feed-wrapper position-relative rounded-3 overflow-hidden bg-black" style="aspect-ratio: 16/9;">
                                        
                                        <!-- Video / Feed -->
                                        <c:choose>
                                            <c:when test="${cam.status == 'Operativa'}">
                                                <iframe src="https://www.youtube.com/embed/We1sryKsHm8?autoplay=1&mute=1&controls=0&modestbranding=1&loop=1&playlist=We1sryKsHm8&start=${132 + loop.index * 125}&disablekb=1"
                                                    frameborder="0" allow="autoplay; encrypted-media" allowfullscreen
                                                    class="w-100 h-100 position-absolute top-0 start-0" style="border:none; pointer-events:none; filter: grayscale(100%) contrast(1.3) brightness(0.8); transform: scale(1.3);"></iframe>
                                            </c:when>
                                            <c:otherwise>
                                                <canvas class="noSignalCanvas w-100 h-100 position-absolute top-0 start-0"></canvas>
                                                <div class="text-center position-relative z-1 d-flex flex-column align-items-center justify-content-center h-100" style="pointer-events:none;">
                                                    <span class="material-symbols-outlined text-secondary" style="font-size: 2rem;">videocam_off</span>
                                                    <div class="text-secondary fw-bold mt-1" style="font-size: 0.7rem;">SIN SEÑAL</div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Overlay de info -->
                                        <div class="cam-overlay position-absolute bottom-0 start-0 w-100 p-2" style="background: linear-gradient(transparent, rgba(0,0,0,0.85)); pointer-events:none;">
                                            <div class="d-flex justify-content-between align-items-end">
                                                <div>
                                                    <div class="text-white fw-bold" style="font-size: 0.7rem;">${cam.id} · ${cam.name}</div>
                                                    <div class="text-secondary" style="font-size: 0.6rem;">${cam.location}</div>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${cam.status == 'Operativa'}">
                                                        <span class="badge bg-success rounded-pill px-2" style="font-size: 0.55rem;">OPERATIVA</span>
                                                    </c:when>
                                                    <c:when test="${cam.status == 'Mantenimiento'}">
                                                        <span class="badge bg-warning text-dark rounded-pill px-2" style="font-size: 0.55rem;">MANT.</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger rounded-pill px-2" style="font-size: 0.55rem;">FALLO</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <!-- Botones top right -->
                                        <div class="position-absolute top-0 end-0 p-1 d-flex gap-1">
                                            <c:if test="${cam.status == 'Operativa'}">
                                                <span class="badge bg-danger" style="font-size: 0.55rem; pointer-events:none;">● REC</span>
                                            </c:if>
                                            <button class="btn btn-sm btn-dark bg-opacity-50 p-0 px-1 border-0" onclick="openSurveillanceMode('single', parseInt('${loop.index}', 10))" title="Pantalla Completa">
                                                <span class="material-symbols-outlined text-white" style="font-size: 0.9rem;">fullscreen</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    </div>
                </div>
            </div>
        </div>

        <!-- Tabla / Grid de Cámaras -->
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center rounded-top-4">
                <h6 class="mb-0 fw-bold text-dark">Inventario de Hardware</h6>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="tablaCamaras">
                    <thead class="table-light text-muted">
                        <tr>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3 ps-4" style="font-size: 0.65rem;">ID Equipo</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Nombre / IP</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Ubicación</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Estado</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3 text-end pe-4" style="font-size: 0.65rem;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cam" items="${camaras}">
                            <tr data-cam-id="${cam.id}" data-cam-status="${cam.status}">
                                <td class="ps-4 py-3">
                                    <div class="fw-black text-dark" style="font-size: 0.85rem;">${cam.id}</div>
                                </td>
                                <td class="py-3">
                                    <div class="fw-bold text-dark" style="font-size: 0.9rem;">${cam.name}</div>
                                    <div class="text-secondary" style="font-size: 0.75rem;">${cam.ipAddress != null ? cam.ipAddress : 'Sin IP Asignada'}</div>
                                </td>
                                <td class="py-3">
                                    <div style="font-size: 0.85rem;" class="text-secondary">${cam.location}</div>
                                    <div class="text-muted" style="font-size: 0.7rem;">Zona: ${cam.zona != null ? cam.zona.nombre : 'No asignada'}</div>
                                </td>
                                <td class="py-3">
                                    <c:choose>
                                        <c:when test="${cam.status == 'Operativa'}">
                                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3 py-2">Operativa</span>
                                        </c:when>
                                        <c:when test="${cam.status == 'Mantenimiento'}">
                                            <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 rounded-pill px-3 py-2">Mantenimiento</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 rounded-pill px-3 py-2">${cam.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4 py-3">
                                    <c:set var="zonaIdValue" value="${cam.zona != null ? cam.zona.id : ''}" />
                                    <c:set var="safeName" value="${cam.name.replace(\"'\", \"\\\\'\").replace('\"', '&quot;')}" />
                                    <c:set var="safeLoc" value="${cam.location.replace(\"'\", \"\\\\'\").replace('\"', '&quot;')}" />
                                    <button class="btn btn-sm btn-light text-primary fw-bold me-1" onclick="editarCamara('${cam.id}', '${safeName}', '${safeLoc}', '${cam.status}', '${cam.ipAddress}', '${zonaIdValue}')">
                                        Editar
                                    </button>
                                    <button class="btn btn-sm btn-light text-danger fw-bold" onclick="eliminarCamara('${cam.id}')">
                                        Borrar
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty camaras}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <span class="material-symbols-outlined fs-1 opacity-50 mb-2">videocam_off</span>
                                    <p class="mb-0">No hay cámaras registradas.</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</main>

<!-- Modal Guardar/Editar Cámara -->
<div class="modal fade" id="camaraModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-4">
      <div class="modal-header border-0 bg-light rounded-top-4 pb-2">
        <h6 class="modal-title fw-bold text-dark" id="modalTitle">Registrar Cámara</h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <form id="camaraForm">
            <div class="mb-3">
                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">ID de Hardware</label>
                <input type="text" class="form-control form-control-sm bg-light border-0 py-2" id="camId" name="id" placeholder="Ej: CAM-001" required>
                <small class="text-secondary" style="font-size: 0.65rem;">No puede cambiarse después de creado.</small>
            </div>
            <div class="mb-3">
                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Nombre</label>
                <input type="text" class="form-control form-control-sm bg-light border-0 py-2" id="camName" name="name" required>
            </div>
            <div class="mb-3">
                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Dirección IP</label>
                <input type="text" class="form-control form-control-sm bg-light border-0 py-2" id="camIp" name="ipAddress" placeholder="192.168.1.x">
            </div>
            <div class="mb-3">
                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Ubicación (Texto)</label>
                <input type="text" class="form-control form-control-sm bg-light border-0 py-2" id="camLocation" name="location" required>
            </div>
            <div class="row g-2 mb-4">
                <div class="col-6">
                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Zona</label>
                    <select class="form-select form-select-sm bg-light border-0 py-2" id="camZona" name="zonaId">
                        <option value="">-- Ninguna --</option>
                        <c:forEach var="z" items="${zonas}">
                            <option value="${z.id}">${z.nombre}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-6">
                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Estado</label>
                    <select class="form-select form-select-sm bg-light border-0 py-2" id="camStatus" name="status">
                        <option value="Operativa">Operativa</option>
                        <option value="Mantenimiento">Mantenimiento</option>
                        <option value="Inoperativa">Inoperativa</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-dark w-100 fw-bold rounded-3 py-2">Guardar Datos</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
(function() {
    'use strict';
    console.log("[Camaras] Script v4 inicializado - sin template literals");

    function getToken() {
        return sessionStorage.getItem('jwt_token');
    }

    function getBadgeEstado(status) {
        if (status === 'Operativa') {
            return '<span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3 py-2">Operativa</span>';
        }
        if (status === 'Mantenimiento') {
            return '<span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 rounded-pill px-3 py-2">Mantenimiento</span>';
        }
        return '<span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 rounded-pill px-3 py-2">' + status + '</span>';
    }

    function getZonaNombre(zonaId) {
        var sel = document.getElementById('camZona');
        if (!sel || !zonaId) return 'No asignada';
        var opt = sel.querySelector('option[value="' + zonaId + '"]');
        return opt ? opt.textContent.trim() : 'No asignada';
    }

    function recalcularEstadisticas() {
        var rows = document.querySelectorAll('#tablaCamaras tbody tr[data-cam-id]');
        var total = 0, operativas = 0, mantenimiento = 0, inoperativas = 0;
        rows.forEach(function(row) {
            var s = row.getAttribute('data-cam-status');
            total++;
            if (s === 'Operativa')          operativas++;
            else if (s === 'Mantenimiento') mantenimiento++;
            else                            inoperativas++;
        });
        var elTotal = document.getElementById('statTotal');
        var elOp    = document.getElementById('statOperativas');
        var elMant  = document.getElementById('statMantenimiento');
        var elInop  = document.getElementById('statInoperativas');
        if (elTotal) elTotal.textContent = total;
        if (elOp)    elOp.textContent    = operativas;
        if (elMant)  elMant.textContent  = mantenimiento;
        if (elInop)  elInop.textContent  = inoperativas;
    }

    function mostrarAlertaError(mensaje) {
        console.error("[Camaras] Error BD:", mensaje);
        var contenedor = document.getElementById('toastContainer');
        if (!contenedor) {
            contenedor = document.createElement('div');
            contenedor.id = 'toastContainer';
            contenedor.style.cssText = 'position:fixed;top:1.2rem;right:1.2rem;z-index:9999;display:flex;flex-direction:column;gap:0.5rem;max-width:360px;';
            document.body.appendChild(contenedor);
        }
        var toast = document.createElement('div');
        toast.style.cssText = 'background:#1a1a2e;color:#fff;border-left:4px solid #ef4444;border-radius:10px;padding:1rem 1.2rem;box-shadow:0 8px 32px rgba(0,0,0,0.35);display:flex;align-items:flex-start;gap:0.75rem;font-size:0.85rem;';
        toast.innerHTML = '<span class="material-symbols-outlined" style="color:#ef4444;font-size:1.3rem;flex-shrink:0;">cloud_off</span>'
            + '<div style="flex:1;"><div style="font-weight:700;font-size:0.8rem;text-transform:uppercase;color:#ef4444;">Error de Base de Datos</div>'
            + '<div style="color:#ccc;margin-top:2px;">' + mensaje + '</div></div>'
            + '<button onclick="this.parentNode.remove()" style="background:none;border:none;color:#888;cursor:pointer;font-size:1.2rem;">&times;</button>';
        contenedor.appendChild(toast);
        setTimeout(function() { if (toast.parentNode) toast.remove(); }, 7000);
    }

    if (!document.getElementById('optimisticStyles')) {
        var s = document.createElement('style');
        s.id = 'optimisticStyles';
        s.textContent = '@keyframes fadeInRow{from{opacity:0;transform:translateY(-8px)}to{opacity:1;transform:translateY(0)}}'
            + '.cam-row-saving{opacity:0.5;pointer-events:none;}';
        document.head.appendChild(s);
    }

    function buildRowHtml(id, name, ip, location, zonaId, status) {
        var ipDisplay  = (ip && ip !== 'null') ? ip : 'Sin IP Asignada';
        var zonaNombre = getZonaNombre(zonaId);
        var safeId     = id.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
        var safeName   = name.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
        var safeLoc    = location.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
        var safeStatus = status.replace(/'/g, "\\'");
        var safeIp     = (ip && ip !== 'null') ? ip.replace(/'/g, "\\'") : '';
        var safeZona   = (zonaId && zonaId !== 'null') ? String(zonaId).replace(/'/g, "\\'") : '';

        return '<td class="ps-4 py-3"><div class="fw-black text-dark" style="font-size:0.85rem;">' + id + '</div></td>'
            + '<td class="py-3">'
            + '<div class="fw-bold text-dark" style="font-size:0.9rem;">' + name + '</div>'
            + '<div class="text-secondary" style="font-size:0.75rem;">' + ipDisplay + '</div>'
            + '</td>'
            + '<td class="py-3">'
            + '<div style="font-size:0.85rem;" class="text-secondary">' + location + '</div>'
            + '<div class="text-muted" style="font-size:0.7rem;">Zona: ' + zonaNombre + '</div>'
            + '</td>'
            + '<td class="py-3">' + getBadgeEstado(status) + '</td>'
            + '<td class="text-end pe-4 py-3">'
            + '<button class="btn btn-sm btn-light text-primary fw-bold me-1"'
            + ' onclick="window.editarCamara(\'' + safeId + '\',\'' + safeName + '\',\'' + safeLoc + '\',\'' + safeStatus + '\',\'' + safeIp + '\',\'' + safeZona + '\')">'
            + 'Editar</button>'
            + '<button class="btn btn-sm btn-light text-danger fw-bold"'
            + ' onclick="window.eliminarCamara(\'' + safeId + '\')">'
            + 'Borrar</button>'
            + '</td>';
    }

    function cerrarModal() {
        var modalEl = document.getElementById('camaraModal');
        if (modalEl) {
            var m = bootstrap.Modal.getInstance(modalEl);
            if (m) m.hide();
        }
        setTimeout(function() {
            document.querySelectorAll('.modal-backdrop').forEach(function(el) { el.remove(); });
            document.body.classList.remove('modal-open');
            document.body.style.overflow = '';
            document.body.style.paddingRight = '';
        }, 250);
    }

    function abrirModal() {
        var modalEl = document.getElementById('camaraModal');
        if (!modalEl) { console.error("[Camaras] No existe #camaraModal"); return; }
        var m = bootstrap.Modal.getInstance(modalEl);
        if (!m) m = new bootstrap.Modal(modalEl, { backdrop: true, keyboard: true });
        m.show();
    }

    window.abrirModalAnadir = function() {
        console.log("[Camaras] abrirModalAnadir()");
        document.getElementById('modalTitle').innerText  = 'Registrar Camara';
        document.getElementById('camId').value           = '';
        document.getElementById('camId').readOnly        = false;
        document.getElementById('camName').value         = '';
        document.getElementById('camIp').value           = '';
        document.getElementById('camLocation').value     = '';
        document.getElementById('camZona').value         = '';
        document.getElementById('camStatus').value       = 'Operativa';
        abrirModal();
    };
    window['abrirModalAñadir'] = window.abrirModalAnadir;

    window.editarCamara = function(id, name, location, status, ip, zonaId) {
        console.log("[Camaras] editarCamara() id=" + id);
        document.getElementById('modalTitle').innerText  = 'Editar Camara';
        document.getElementById('camId').value           = id;
        document.getElementById('camId').readOnly        = true;
        document.getElementById('camName').value         = name;
        document.getElementById('camLocation').value     = location;
        document.getElementById('camStatus').value       = status;
        document.getElementById('camIp').value           = (ip === 'null' || !ip) ? '' : ip;
        document.getElementById('camZona').value         = (zonaId === 'null' || !zonaId) ? '' : zonaId;
        abrirModal();
    };

    window.eliminarCamara = function(id) {
        console.log("[Camaras] eliminarCamara() id=" + id);
        if (!confirm('Eliminar la camara ' + id + '?')) return;

        var fila = document.querySelector('#tablaCamaras tbody tr[data-cam-id="' + id + '"]');
        if (!fila) { console.error("[Camaras] Fila no encontrada id=" + id); return; }

        var snapshotHTML   = fila.innerHTML;
        var snapshotStatus = fila.getAttribute('data-cam-status');
        var nextSibling    = fila.nextSibling;
        var tbody          = fila.parentNode;

        fila.style.transition = 'opacity 0.25s,transform 0.25s';
        fila.style.opacity    = '0';
        fila.style.transform  = 'translateX(20px)';
        setTimeout(function() { if (fila.parentNode) fila.remove(); recalcularEstadisticas(); }, 260);

        var params = new URLSearchParams();
        params.append('id', id);
        fetch('/api/camaras/eliminar', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ' + getToken() },
            body: params.toString()
        })
        .then(function(res) {
            if (!res.ok) return res.text().then(function(t) { throw new Error(t || 'HTTP ' + res.status); });
            console.log("[Camaras] Eliminacion OK en BD.");
        })
        .catch(function(err) {
            console.error("[Camaras] Fallo eliminacion, revirtiendo:", err);
            var r = document.createElement('tr');
            r.setAttribute('data-cam-id', id);
            r.setAttribute('data-cam-status', snapshotStatus);
            r.innerHTML = snapshotHTML;
            r.style.opacity = '0';
            if (nextSibling && nextSibling.parentNode === tbody) tbody.insertBefore(r, nextSibling);
            else tbody.appendChild(r);
            setTimeout(function() { r.style.transition = 'opacity 0.25s'; r.style.opacity = '1'; }, 10);
            recalcularEstadisticas();
            mostrarAlertaError('No se pudo eliminar: ' + err.message);
        });
    };

    function handleSubmit(e) {
        if (!e.target || e.target.id !== 'camaraForm') return;
        e.preventDefault();
        e.stopPropagation();

        var id        = document.getElementById('camId').value.trim();
        var name      = document.getElementById('camName').value.trim();
        var location  = document.getElementById('camLocation').value.trim();
        var status    = document.getElementById('camStatus').value;
        var ip        = document.getElementById('camIp').value.trim();
        var zonaId    = document.getElementById('camZona').value;
        var esEdicion = document.getElementById('camId').readOnly;

        console.log("[Camaras] Submit: esEdicion=" + esEdicion + " id=" + id + " name=" + name);

        if (!id || !name || !location) {
            alert('Los campos ID, Nombre y Ubicacion son obligatorios.');
            return;
        }

        cerrarModal();

        var params = new URLSearchParams();
        params.append('id', id);
        params.append('name', name);
        params.append('location', location);
        params.append('status', status);
        if (ip)     params.append('ipAddress', ip);
        if (zonaId) params.append('zonaId', zonaId);

        var tbody = document.querySelector('#tablaCamaras tbody');
        if (!tbody) { console.error("[Camaras] No existe #tablaCamaras tbody"); return; }

        if (esEdicion) {
            var fila = document.querySelector('#tablaCamaras tbody tr[data-cam-id="' + id + '"]');
            if (!fila) {
                console.warn("[Camaras] Fila edicion no encontrada, recargando...");
                if (window.SPA) SPA.reload();
                return;
            }
            var snapHTML   = fila.innerHTML;
            var snapStatus = fila.getAttribute('data-cam-status');
            fila.setAttribute('data-cam-status', status);
            fila.classList.add('cam-row-saving');
            fila.innerHTML = buildRowHtml(id, name, ip, location, zonaId, status);
            recalcularEstadisticas();

            console.log("[Camaras] POST edicion /api/camaras/guardar");
            fetch('/api/camaras/guardar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ' + getToken() },
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) return res.text().then(function(t) { throw new Error(t || 'HTTP ' + res.status); });
                console.log("[Camaras] Edicion OK en BD.");
                fila.classList.remove('cam-row-saving');
            })
            .catch(function(err) {
                console.error("[Camaras] Fallo edicion, revirtiendo:", err);
                fila.innerHTML = snapHTML;
                fila.setAttribute('data-cam-status', snapStatus);
                fila.classList.remove('cam-row-saving');
                recalcularEstadisticas();
                mostrarAlertaError('No se pudo guardar: ' + err.message);
            });

        } else {
            var filaVacia = tbody.querySelector('tr td[colspan]');
            if (filaVacia) filaVacia.closest('tr').remove();

            var nuevaFila = document.createElement('tr');
            nuevaFila.setAttribute('data-cam-id', id);
            nuevaFila.setAttribute('data-cam-status', status);
            nuevaFila.style.animation = 'fadeInRow 0.3s ease';
            nuevaFila.classList.add('cam-row-saving');
            nuevaFila.innerHTML = buildRowHtml(id, name, ip, location, zonaId, status);
            tbody.appendChild(nuevaFila);
            recalcularEstadisticas();

            console.log("[Camaras] POST insercion /api/camaras/guardar");
            fetch('/api/camaras/guardar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ' + getToken() },
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) return res.text().then(function(t) { throw new Error(t || 'HTTP ' + res.status); });
                console.log("[Camaras] Insercion OK en BD.");
                nuevaFila.classList.remove('cam-row-saving');
            })
            .catch(function(err) {
                console.error("[Camaras] Fallo insercion, revirtiendo:", err);
                nuevaFila.style.transition = 'opacity 0.25s';
                nuevaFila.style.opacity = '0';
                setTimeout(function() {
                    if (nuevaFila.parentNode) nuevaFila.remove();
                    if (!tbody.querySelector('tr')) {
                        tbody.innerHTML = '<tr><td colspan="5" class="text-center py-5 text-muted">'
                            + '<span class="material-symbols-outlined fs-1 opacity-50 mb-2">videocam_off</span>'
                            + '<p class="mb-0">No hay camaras registradas.</p></td></tr>';
                    }
                    recalcularEstadisticas();
                }, 270);
                mostrarAlertaError('No se pudo registrar: ' + err.message);
            });
        }
    }

    if (window._camaraSubmitHandler) {
        document.removeEventListener('submit', window._camaraSubmitHandler, true);
    }
    window._camaraSubmitHandler = handleSubmit;
    document.addEventListener('submit', window._camaraSubmitHandler, true);
    console.log("[Camaras] Listener submit registrado.");

    window.currentCamIndex = 0;
    window.currentLayout   = 'grid';

    window.openSurveillanceMode = function(layout, index) {
        window.currentLayout   = layout || 'grid';
        window.currentCamIndex = index || 0;
        var ws = document.getElementById('cctvWorkspace');
        if (!ws) return;
        if (!document.fullscreenElement) {
            if (ws.requestFullscreen) ws.requestFullscreen();
            else if (ws.webkitRequestFullscreen) ws.webkitRequestFullscreen();
        } else { window.applyLayout(); }
    };

    if (!window._fsListenerCam) {
        window._fsListenerCam = function() {
            var ws = document.getElementById('cctvWorkspace');
            if (!ws) return;
            var controls = document.getElementById('fsControls');
            if (document.fullscreenElement === ws) {
                ws.style.padding = '4rem 1rem 1rem 1rem';
                ws.style.height  = '100vh';
                if (controls) controls.classList.replace('d-none','d-flex');
                window.applyLayout();
            } else {
                ws.style.padding = '0'; ws.style.height = 'auto';
                if (controls) controls.classList.replace('d-flex','d-none');
                window.resetLayout();
            }
        };
        document.addEventListener('fullscreenchange', window._fsListenerCam);
    }

    window.applyLayout = function() {
        var cols = document.querySelectorAll('#cameraGrid > div');
        var prevBtn = document.getElementById('prevCamBtn');
        var nextBtn = document.getElementById('nextCamBtn');
        if (window.currentLayout === 'grid') {
            if (prevBtn) prevBtn.classList.replace('d-block','d-none');
            if (nextBtn) nextBtn.classList.replace('d-block','d-none');
            cols.forEach(function(col) {
                col.className = 'col-6 p-1'; col.style.display = 'block'; col.style.height = '50%';
                var fw = col.querySelector('.cam-feed-wrapper'); if (fw) fw.style.height = '100%';
            });
        } else {
            if (prevBtn) prevBtn.classList.replace('d-none','d-block');
            if (nextBtn) nextBtn.classList.replace('d-none','d-block');
            cols.forEach(function(col, idx) {
                if (idx === window.currentCamIndex) {
                    col.className = 'col-12 p-1'; col.style.display = 'block'; col.style.height = '100%';
                    var fw = col.querySelector('.cam-feed-wrapper'); if (fw) fw.style.height = '100%';
                } else { col.style.display = 'none'; }
            });
        }
    };

    window.resetLayout = function() {
        var cols = document.querySelectorAll('#cameraGrid > div');
        var prevBtn = document.getElementById('prevCamBtn'); var nextBtn = document.getElementById('nextCamBtn');
        if (prevBtn) prevBtn.classList.replace('d-block','d-none');
        if (nextBtn) nextBtn.classList.replace('d-block','d-none');
        cols.forEach(function(col) {
            col.className = 'col-md-6 col-lg-3'; col.style.display = 'block'; col.style.height = 'auto';
            var fw = col.querySelector('.cam-feed-wrapper'); if (fw) fw.style.height = '';
        });
    };

    window.setLayout = function(l) { window.currentLayout = l; window.applyLayout(); };
    window.nextCam   = function() { var c = document.querySelectorAll('#cameraGrid > div'); window.currentCamIndex = (window.currentCamIndex + 1) % c.length; window.applyLayout(); };
    window.prevCam   = function() { var c = document.querySelectorAll('#cameraGrid > div'); window.currentCamIndex = (window.currentCamIndex - 1 + c.length) % c.length; window.applyLayout(); };
    window.exitSurveillanceMode = function() { if (document.exitFullscreen) document.exitFullscreen(); };

    if (window.liveTimeInterval) clearInterval(window.liveTimeInterval);
    window.liveTimeInterval = setInterval(function() {
        var el = document.getElementById('liveTime');
        if (el) el.textContent = new Date().toLocaleTimeString('es-MX', { hour12: false });
        else clearInterval(window.liveTimeInterval);
    }, 1000);
    (function() { var el = document.getElementById('liveTime'); if (el) el.textContent = new Date().toLocaleTimeString('es-MX',{hour12:false}); })();

    if (window.noiseInterval) clearInterval(window.noiseInterval);
    window.noiseInterval = setInterval(function() {
        document.querySelectorAll('.noSignalCanvas').forEach(function(canvas) {
            var ctx = canvas.getContext('2d');
            var w = canvas.width = 320; var h = canvas.height = 180;
            var img = ctx.createImageData(w, h);
            for (var i = 0; i < img.data.length; i += 4) {
                var v = Math.random() * 80;
                img.data[i] = img.data[i+1] = img.data[i+2] = v; img.data[i+3] = 200;
            }
            ctx.putImageData(img, 0, 0);
        });
    }, 80);

    recalcularEstadisticas();
    console.log("[Camaras] Listo.");
})();
</script>