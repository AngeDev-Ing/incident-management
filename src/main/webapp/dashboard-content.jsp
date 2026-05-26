<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- MAIN CONTENT -->
<main class="main-content p-4 w-100">
    <div class="container-fluid max-w-7xl">
        
        <!-- Stats Row -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <span class="text-muted fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Incidencias Activas</span>
                        <div class="mt-2 d-flex align-items-baseline gap-2">
                            <span class="fs-2 fw-black text-dark fw-bold">${activeIncidentsCount}</span>
                            <span class="text-danger fw-bold" style="font-size: 0.75rem;">Total: ${totalIncidentsCount}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <span class="text-muted fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Tiempo en Línea</span>
                        <div class="mt-2 d-flex align-items-baseline gap-2">
                            <span class="fs-2 fw-bold text-dark">${uptimePercentage}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <span class="text-muted fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">T. Prom. Respuesta</span>
                        <div class="mt-2 d-flex align-items-baseline gap-2">
                            <span class="fs-2 fw-bold text-dark">${tiempoPromedio}</span>
                            <span class="${tendenciaColor} fw-bold" style="font-size: 0.75rem;">${tendenciaRespuesta}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4 bg-dark text-white overflow-hidden position-relative">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCdIileK2RiXMQuaQ9YVAcELLqvvESsBg-EsxGMaAD571_Ivu6floGrd6cDX1WQdWXmG78jh-WXMXrkMHaQMWtG-iA_XRQsjI39gvHbsvLjDirCp2HUiQHUxDnc4cFRCMxMRQSaToxixaTal9WfoznLpeYKKw53_0oRtdnJtEwn5qw_TJ8mP0QwIJPvo_qzxhoC2Ep9UqJyz8jvrpw-AI7gvjzFICC3SY-56UeVnMPl_b0L2A550KvA-KBT1k9HoAZDDpyZQyDj2A" class="position-absolute w-100 h-100 object-fit-cover opacity-25 top-0 start-0" alt="Background">
                    <div class="card-body d-flex flex-column justify-content-between position-relative z-1">
                        <span class="text-light fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Cobertura en Vivo</span>
                        <div class="mt-2 d-flex align-items-center gap-2">
                            <c:choose>
                                <c:when test="${activeIncidentsCount > 0}">
                                    <div class="spinner-grow spinner-grow-sm text-danger" role="status"><span class="visually-hidden">Alerta</span></div>
                                    <span class="fw-bold text-danger">Alerta Activa</span>
                                </c:when>
                                <c:otherwise>
                                    <div class="spinner-grow spinner-grow-sm text-success" role="status"><span class="visually-hidden">Seguro</span></div>
                                    <span class="fw-bold">Zonas Seguras</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <!-- Form -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-light border-0 py-3 d-flex justify-content-between align-items-center rounded-top-4">
                        <h6 class="mb-0 fw-bold text-dark">Registro de Incidencia</h6>
                        <span class="material-symbols-outlined text-muted">edit_note</span>
                    </div>
                    <div class="card-body p-4">
                        <div id="quickIncidenciaForm">
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Título</label>
                                <input type="text" id="qTitle" class="form-control form-control-sm bg-light border-0 py-2" placeholder="Ingrese el título..." required>
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Fecha</label>
                                    <input type="date" id="qDate" class="form-control form-control-sm bg-light border-0 py-2" required>
                                </div>
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Tipo</label>
                                    <select id="qType" class="form-select form-select-sm bg-light border-0 py-2">
                                        <option>Robo</option>
                                        <option>Sospechoso</option>
                                        <option>Accidente</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Supervisor</label>
                                    <input type="text" id="qSupervisor" class="form-control form-control-sm bg-light border-0 py-2">
                                </div>
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Operador</label>
                                    <input type="text" id="qOperator" class="form-control form-control-sm bg-light border-0 py-2">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Cámara</label>
                                <select id="qCamera" class="form-select form-select-sm bg-light border-0 py-2">
                                    <option value="" disabled selected>Seleccione una cámara...</option>
                                    <c:forEach var="cam" items="${camaras}">
                                        <option value="Cam ${cam.id} - ${cam.name}">Cam ${cam.id} - ${cam.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Descripción</label>
                                <textarea id="qDesc" class="form-control form-control-sm bg-light border-0 py-2" rows="3" placeholder="Detalles de la incidencia..."></textarea>
                            </div>
                            <button type="button" id="btnQuickSave" class="btn btn-dark w-100 fw-bold rounded-3 py-2">Guardar Registro</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 h-100 flex-fill">
                    <div class="card-header bg-light border-0 py-3 d-flex justify-content-between align-items-center rounded-top-4">
                        <h6 class="mb-0 fw-bold text-dark">Historial de Incidencias</h6>
                        <div class="d-flex gap-2">
                            <button class="btn btn-sm btn-light text-muted"><span class="material-symbols-outlined fs-6">filter_list</span></button>
                            <button class="btn btn-sm btn-light text-muted"><span class="material-symbols-outlined fs-6">download</span></button>
                        </div>
                    </div>
                    <div class="table-responsive flex-fill" style="overflow-y: auto; min-height: 300px;">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted position-sticky top-0 z-1">
                                <tr>
                                    <th class="text-uppercase fw-bold border-bottom-0 py-3 ps-4" style="font-size: 0.65rem;">Fecha</th>
                                    <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Incidente</th>
                                    <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Tipo</th>
                                    <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Supervisor</th>
                                    <th class="border-bottom-0 py-3 pe-4"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="inc" items="${incidencias}">
                                    <tr>
                                        <td class="ps-4 py-3">
                                            <div class="fw-bold text-dark" style="font-size: 0.85rem;">${inc.date}</div>
                                            <div class="text-muted" style="font-size: 0.7rem;">${inc.time}</div>
                                        </td>
                                        <td class="py-3"><span style="font-size: 0.9rem;" class="fw-medium text-secondary">${inc.title}</span></td>
                                        <td class="py-3">
                                            <span class="badge <c:choose><c:when test="${inc.type == 'Robo'}">bg-danger</c:when><c:when test="${inc.type == 'Sospechoso'}">bg-warning text-dark</c:when><c:otherwise>bg-info text-dark</c:otherwise></c:choose> text-uppercase px-3 py-2 rounded-pill">${inc.type}</span>
                                        </td>
                                        <td class="py-3"><span style="font-size: 0.85rem;" class="text-secondary">${empty inc.supervisor ? 'N/A' : inc.supervisor}</span></td>
                                        <td class="text-end pe-4 py-3"></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer bg-white border-top-0 p-3 mt-auto d-flex justify-content-between align-items-center rounded-bottom-4">
                        <span class="text-muted" style="font-size: 0.75rem;">Mostrando todas las incidencias</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Map -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden position-relative" style="height: 250px;">
            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuBbHAvnKvERlzslKzGtgBaA-MiCjFzT20z1ix1az6NRUSSAB3wJUVm2Si5FLD4Fy__3FzkMOKeDzscX5-DGgFgs5sawBFIKAFtlF7beXYgt3TOC0IAQ42Z3d5LmgmwI5TGlyVfJ0kEMXcYtj9zMQuPx3NxyWuuKJIxAGrrDg8RaARPvHS_skyfrT56XcBl99-g8HJbiuxosKrJfaI6gdkWIz6JTmI_yk9HAnQSKVa0i_6elJAzqz0xlxnrW5Ih7T8U8L_dot3F-Cw" class="position-absolute w-100 h-100 object-fit-cover opacity-75" alt="Map">
            <div class="position-absolute w-100 h-100" style="background: linear-gradient(to right, rgba(33,37,41,0.9), transparent);"></div>
            
            <div class="position-relative z-1 p-5 text-white d-flex flex-column justify-content-center h-100">
                <span class="fw-bold text-uppercase opacity-75" style="font-size: 0.65rem; letter-spacing: 2px;">Mapa de Zonas</span>
                <h3 class="fw-black mt-1">Complejo Industrial Alpha</h3>
                <p class="opacity-75 mt-2" style="font-size: 0.85rem; max-width: 400px;">Rastreo espacial en vivo activado. ${camarasActivasCount} cámaras activas monitoreando ${zonasCount} zonas perimetrales de alta prioridad.</p>
                <button class="btn btn-outline-light btn-sm mt-3 fw-bold text-uppercase w-auto align-self-start" style="letter-spacing: 1px;">Abrir Visor de Mapa</button>
            </div>
            
            <div class="position-absolute top-0 end-0 p-4 z-1">
                <div class="bg-white rounded p-2 px-3 shadow d-flex align-items-center gap-2">
                    <span class="badge bg-danger rounded-circle p-1">&nbsp;</span>
                    <span class="fw-bold text-dark text-uppercase" style="font-size: 0.7rem;">Alerta: Sector 4</span>
                </div>
            </div>
        </div>

    </div>
</main>

<script>
(function() {
    function getToken() { return localStorage.getItem('jwt_token') || ''; }

    // Rellenar fecha con el día actual si está vacía
    var dateInput = document.getElementById('qDate');
    if (dateInput && !dateInput.value) {
        dateInput.value = new Date().toISOString().split('T')[0];
    }

    var btnSave = document.getElementById('btnQuickSave');
    if (btnSave) {
        btnSave.addEventListener('click', function(e) {
            e.preventDefault();
            var title = document.getElementById('qTitle').value.trim();
            var date = document.getElementById('qDate').value;
            var type = document.getElementById('qType').value;
            var supervisor = document.getElementById('qSupervisor').value.trim();
            var operator = document.getElementById('qOperator').value.trim();
            var camera = document.getElementById('qCamera').value;
            var desc = document.getElementById('qDesc').value.trim();

            if (!title || !date) {
                alert("El título y la fecha son obligatorios.");
                return;
            }

            // Usamos la hora local actual como default
            var time = new Date().toTimeString().substring(0, 5);

            var payload = {
                title: title,
                date: date,
                time: time,
                type: type,
                supervisor: supervisor,
                operator: operator,
                camera: camera,
                description: desc,
                status: 'Pendiente',
                priority: 'Media'
            };

            btnSave.disabled = true;
            btnSave.innerText = 'Guardando...';

            fetch('/api/incidencias', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + getToken()
                },
                body: JSON.stringify(payload)
            })
            .then(function(res) {
                if (!res.ok) throw new Error('Error ' + res.status);
                // Si guardó ok, limpiamos campos y refrescamos dashboard
                document.getElementById('qTitle').value = '';
                document.getElementById('qDesc').value = '';
                if (window.SPA) SPA.reload(); // Recarga el dashboard y la tablita historial
            })
            .catch(function(err) {
                console.error("[Dashboard] Error guardando incidencia", err);
                alert("No se pudo guardar: " + err.message);
                btnSave.disabled = false;
                btnSave.innerText = 'Guardar Registro';
            });
        });
    }
})();
</script>
