<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<main class="main-content p-4 w-100">
    <div class="container-fluid max-w-7xl">

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-3 mb-4">
            <div>
                <h2 class="font-headline fw-bold text-dark mb-1">Listado de Incidencias</h2>
                <p class="text-secondary mb-0" style="max-width: 600px;">
                    Gestión y monitoreo en tiempo real de brechas de seguridad y anomalías detectadas por el sistema Digital Sentinel.
                </p>
            </div>

            <div class="d-flex gap-2">
                <button class="btn btn-outline-secondary btn-sm fw-semibold rounded-3 px-3 py-2">
                    Exportar Reporte
                </button>

                <button
                    class="btn btn-dark btn-sm primary-gradient border-0 fw-semibold rounded-3 px-3 py-2 d-flex align-items-center gap-2"
                    data-bs-toggle="modal"
                    data-bs-target="#modalIncidencia">
                    <span class="material-symbols-outlined fs-6">add</span>
                    Nueva Incidencia
                </button>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <span class="text-secondary fw-bold text-uppercase d-block mb-2" style="font-size: 0.65rem; letter-spacing: 1px;">Pendientes</span>
                        <div class="d-flex justify-content-between align-items-end">
                            <span class="fs-2 fw-bold text-dark">${pendientesCount}</span>
                            <span class="text-danger fw-bold d-flex align-items-center" style="font-size: 0.8rem;">
                                <span class="material-symbols-outlined fs-6 me-1">trending_up</span> Activas
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <span class="text-secondary fw-bold text-uppercase d-block mb-2" style="font-size: 0.65rem; letter-spacing: 1px;">En Proceso</span>
                        <div class="d-flex justify-content-between align-items-end">
                            <span class="fs-2 fw-bold text-dark">${enProcesoCount}</span>
                            <span class="text-secondary fw-bold d-flex align-items-center" style="font-size: 0.8rem;">
                                <span class="material-symbols-outlined fs-6 me-1">remove</span> En Curso
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card border-0 shadow rounded-4 bg-dark text-white overflow-hidden h-100 position-relative primary-gradient">
                    <div class="card-body p-4 d-flex flex-column justify-content-between position-relative z-1">
                        <div>
                            <span class="text-light fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">
                                Tiempo Medio de Respuesta
                            </span>
                            <span class="fs-2 fw-bold">4.2 min</span>
                        </div>
                        <p class="text-light opacity-25 font-monospace mb-0 mt-3" style="font-size: 0.6rem;">
                            SENTINEL_KPI_SYSTEM_STABLE
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
            <div class="card-header bg-light border-0 py-3 d-flex justify-content-between align-items-center">
                <div class="d-flex gap-1">
                    <button class="btn btn-sm btn-white bg-white shadow-sm text-dark fw-bold px-3">Todas</button>
                    <button class="btn btn-sm btn-link text-secondary text-decoration-none fw-semibold px-3">Críticas</button>
                    <button class="btn btn-sm btn-link text-secondary text-decoration-none fw-semibold px-3">Advertencias</button>
                </div>

                <button class="btn btn-link text-secondary text-decoration-none fw-semibold d-flex align-items-center gap-1 p-0 fs-7">
                    <span class="material-symbols-outlined fs-6">filter_list</span>
                    Filtros Avanzados
                </button>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-muted">
                        <tr>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3 ps-4" style="font-size: 0.65rem;">Nombre de Incidencia</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3 text-end" style="font-size: 0.65rem;">Fecha / Hora</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3" style="font-size: 0.65rem;">Tipo</th>
                            <th class="text-uppercase fw-bold border-bottom-0 py-3 text-center" style="font-size: 0.65rem;">Estado</th>
                            <th class="border-bottom-0 py-3 pe-4"></th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="inc" items="${incidencias}">
                            <tr class="group">
                                <td class="ps-4 py-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <span class="badge 
                                            <c:choose>
                                                <c:when test="${inc.status == 'Pendiente'}">bg-danger</c:when>
                                                <c:when test="${inc.status == 'En Proceso'}">bg-info</c:when>
                                                <c:otherwise>bg-secondary</c:otherwise>
                                            </c:choose>
                                            rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>

                                        <div>
                                            <div class="fw-bold text-dark" style="font-size: 0.85rem;">${inc.title}</div>
                                            <div class="text-muted text-uppercase" style="font-size: 0.65rem;">ID: INC-${inc.id}-X</div>
                                        </div>
                                    </div>
                                </td>

                                <td class="text-end py-3">
                                    <div class="fw-medium text-dark" style="font-size: 0.85rem;">${inc.date}</div>
                                    <div class="text-muted text-uppercase" style="font-size: 0.65rem;">${inc.time}</div>
                                </td>

                                <td class="py-3">
                                    <div class="d-flex align-items-center gap-2 text-secondary" style="font-size: 0.85rem;">
                                        <span class="material-symbols-outlined fs-5 text-primary">
                                            <c:choose>
                                                <c:when test="${inc.type == 'Robo'}">security</c:when>
                                                <c:when test="${inc.type == 'Accidente'}">videocam_off</c:when>
                                                <c:when test="${inc.type == 'Sospechoso'}">person_alert</c:when>
                                                <c:otherwise>warning</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span>${inc.type}</span>
                                    </div>
                                </td>

                                <td class="text-center py-3">
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${inc.status == 'Pendiente'}">bg-danger</c:when>
                                            <c:when test="${inc.status == 'En Proceso'}">bg-info text-dark</c:when>
                                            <c:when test="${inc.status == 'Resuelto'}">bg-success</c:when>
                                            <c:otherwise>bg-secondary</c:otherwise>
                                        </c:choose>
                                        text-uppercase px-3 py-2 rounded-pill" style="font-size: 0.65rem;">
                                        ${inc.status}
                                    </span>
                                </td>

                                <td class="text-end pe-4 py-3">
                                    <div class="d-flex gap-1 justify-content-end group-hover-visible">
                                        <button class="btn btn-sm btn-light text-secondary">
                                            <span class="material-symbols-outlined fs-6">visibility</span>
                                        </button>

                                        <button
                                            type="button"
                                            class="btn btn-sm btn-light text-secondary btn-editar-incidencia"
                                            data-id="${inc.id}"
                                            data-title="${inc.title}"
                                            data-description="${inc.description}"
                                            data-date="${inc.date}"
                                            data-time="${inc.time}"
                                            data-type="${inc.type}"
                                            data-priority="${inc.priority}"
                                            data-status="${inc.status}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalIncidencia">
                                            <span class="material-symbols-outlined fs-6">edit</span>
                                        </button>
                                        
                                        <button
                                            type="button"
                                            class="btn btn-sm btn-light text-danger btn-eliminar-incidencia"
                                            data-id="${inc.id}">
                                            <span class="material-symbols-outlined fs-6">delete</span>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white border-top-0 p-3 d-flex justify-content-between align-items-center">
                <span class="text-muted text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">
                    Total de ${fn:length(incidencias)} incidencias en base de datos
                </span>

                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item"><a class="page-link text-muted border-light" href="#">&laquo;</a></li>
                    <li class="page-item active"><a class="page-link bg-dark border-dark" href="#">1</a></li>
                    <li class="page-item"><a class="page-link text-muted border-light" href="#">&raquo;</a></li>
                </ul>
            </div>
        </div>

    </div>

    <!-- MODAL NUEVA INCIDENCIA -->
    <div class="modal fade" id="modalIncidencia" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 rounded-4">

                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold" id="modalIncidenciaTitulo">
                        Registrar Nueva Incidencia
                    </h5>

                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="row g-3">

                        <input type="hidden" id="incidenciaId">

                        <div class="col-md-12">
                            <label class="form-label fw-semibold">Título</label>
                            <input type="text" id="title" class="form-control rounded-3" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-semibold">Descripción</label>
                            <textarea id="description" class="form-control rounded-3" rows="3"></textarea>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Fecha</label>
                            <input type="date" id="date" class="form-control rounded-3" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Hora</label>
                            <input type="time" id="time" class="form-control rounded-3" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Tipo</label>
                            <select id="type" class="form-select rounded-3">
                                <option>Robo</option>
                                <option>Accidente</option>
                                <option>Sospechoso</option>
                                <option>Infraestructura</option>
                                <option>Mantenimiento</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Prioridad</label>
                            <select id="priority" class="form-select rounded-3">
                                <option>Baja</option>
                                <option selected>Media</option>
                                <option>Alta</option>
                                <option>Crítica</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Estado</label>
                            <select id="status" class="form-select rounded-3">
                                <option selected>Pendiente</option>
                                <option>En Proceso</option>
                                <option>Resuelto</option>
                                <option>Cerrado</option>
                            </select>
                        </div>

                    </div>
                </div>

                <div class="modal-footer border-0">
                    <button class="btn btn-light rounded-3" data-bs-dismiss="modal">
                        Cancelar
                    </button>

                    <button type="button" class="btn btn-dark rounded-3" id="btnGuardarIncidencia">
                        <span id="textoBotonGuardarIncidencia">
                            Guardar Incidencia
                        </span>
                    </button>
                </div>

            </div>
        </div>
    </div>


</main>
