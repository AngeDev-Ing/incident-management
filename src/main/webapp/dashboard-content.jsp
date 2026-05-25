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
                            <span class="fs-2 fw-bold text-dark">99.9%</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <span class="text-muted fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">T. Prom. Respuesta</span>
                        <div class="mt-2 d-flex align-items-baseline gap-2">
                            <span class="fs-2 fw-bold text-dark">4m</span>
                            <span class="text-secondary fw-bold" style="font-size: 0.75rem;">-30s</span>
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
                            <div class="spinner-grow spinner-grow-sm text-success" role="status"><span class="visually-hidden">Cargando...</span></div>
                            <span class="fw-bold">Zonas Seguras</span>
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
                        <form>
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Título</label>
                                <input type="text" class="form-control form-control-sm bg-light border-0 py-2" placeholder="Ingrese el título...">
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Fecha</label>
                                    <input type="date" class="form-control form-control-sm bg-light border-0 py-2">
                                </div>
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Tipo</label>
                                    <select class="form-select form-select-sm bg-light border-0 py-2">
                                        <option>Robo</option>
                                        <option>Sospechoso</option>
                                        <option>Accidente</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Supervisor</label>
                                    <input type="text" class="form-control form-control-sm bg-light border-0 py-2">
                                </div>
                                <div class="col-6">
                                    <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Operador</label>
                                    <input type="text" class="form-control form-control-sm bg-light border-0 py-2">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Cámara</label>
                                <select class="form-select form-select-sm bg-light border-0 py-2">
                                    <option>Cam 1 - Entrada Principal</option>
                                    <option>Cam 2 - Perímetro Norte</option>
                                </select>
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Descripción</label>
                                <textarea class="form-control form-control-sm bg-light border-0 py-2" rows="3" placeholder="Detalles de la incidencia..."></textarea>
                            </div>
                            <button class="btn btn-dark w-100 fw-bold rounded-3 py-2">Guardar Registro</button>
                        </form>
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
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted">
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
                                        <td class="py-3"><span style="font-size: 0.85rem;" class="text-secondary">${inc.supervisor}</span></td>
                                        <td class="text-end pe-4 py-3"><button class="btn btn-link text-muted p-0"><span class="material-symbols-outlined">visibility</span></button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer bg-white border-top-0 p-3 mt-auto d-flex justify-content-between align-items-center rounded-bottom-4">
                        <span class="text-muted" style="font-size: 0.75rem;">Últimos 3 registros</span>
                        <ul class="pagination pagination-sm mb-0">
                            <li class="page-item"><a class="page-link text-muted border-light" href="#">&laquo;</a></li>
                            <li class="page-item active"><a class="page-link bg-dark border-dark" href="#">1</a></li>
                            <li class="page-item"><a class="page-link text-dark border-light" href="#">2</a></li>
                            <li class="page-item"><a class="page-link text-muted border-light" href="#">&raquo;</a></li>
                        </ul>
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
                <p class="opacity-75 mt-2" style="font-size: 0.85rem; max-width: 400px;">Rastreo espacial en vivo activado. 42 cámaras activas monitoreando 12 zonas perimetrales de alta prioridad.</p>
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
