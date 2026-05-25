<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!-- MAIN CONTENT -->
<main class="main-content p-4 w-100">
    <div class="container-fluid max-w-7xl">
        
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h2 class="font-headline fw-bold text-dark mb-1">Gestión de Cámaras</h2>
                <p class="text-secondary mb-0" style="font-size: 0.85rem;">Panel operativo de monitoreo y asignación técnica.</p>
            </div>
            <button class="btn btn-dark btn-sm signature-gradient border-0 fw-semibold rounded-3 px-3 py-2.5 d-flex align-items-center gap-2">
                <span class="material-symbols-outlined fs-6" style="font-variation-settings: 'FILL' 1;">add_circle</span> Registrar inicio de turno
            </button>
        </div>

        <!-- Stats strip -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center">
                    <div class="fw-bold text-dark fs-2">${totalCamaras}</div>
                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem; letter-spacing: 1px;">Total</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center">
                    <div class="fw-bold text-success fs-2">${operativasCamaras}</div>
                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem; letter-spacing: 1px;">Operativas</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center">
                    <div class="fw-bold text-danger fs-2">${inoperativasCamaras}</div>
                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem; letter-spacing: 1px;">Inoperativas</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center">
                    <div class="fw-bold text-warning fs-2">${mantenimientoCamaras}</div>
                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem; letter-spacing: 1px;">Mantenimiento</small>
                </div>
            </div>
        </div>

        <!-- Bento Grid Layout -->
        <div class="row g-4 mb-4">
            <!-- 1. Asignacion de Camaras (Wide Section) - Stats globales de la BD -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="d-flex align-items-center gap-2">
                            <span class="bg-primary rounded-pill d-inline-block" style="width: 4px; height: 20px;"></span>
                            <h6 class="fw-bold text-dark text-uppercase tracking-wider mb-0" style="font-size: 0.8rem;">Asignación de Cámaras</h6>
                        </div>
                        <span class="text-secondary fw-bold text-uppercase px-2.5 py-1 rounded bg-light" style="font-size: 0.6rem; letter-spacing: 1px;">Actualizado ahora</span>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0" style="border-collapse: separate; border-spacing: 0 12px;">
                            <thead class="text-secondary text-uppercase fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">
                                <tr>
                                    <th class="border-0 px-3">Operador</th>
                                    <th class="border-0 px-3">Turno</th>
                                    <th class="border-0 px-3 text-center">Inicio</th>
                                    <th class="border-0 px-3 text-center">Fin</th>
                                    <th class="border-0 px-3 text-center">Estado</th>
                                    <th class="border-0 px-3 text-end">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="turno" items="${turnos}" varStatus="loop">
                                    <tr class="bg-light rounded-3 shadow-sm">
                                        <td class="py-3 px-3 border-0 rounded-start-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="rounded-circle <c:choose><c:when test="${loop.index == 0}">bg-primary bg-opacity-10 text-primary</c:when><c:when test="${loop.index == 1}">bg-secondary bg-opacity-10 text-secondary</c:when><c:otherwise>bg-warning bg-opacity-10 text-warning</c:otherwise></c:choose> d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 0.75rem;">
                                                    ${fn:toUpperCase(fn:substring(turno.operator, 0, 2))}
                                                </div>
                                                <span class="fw-semibold text-dark" style="font-size: 0.85rem;">${turno.operator}</span>
                                            </div>
                                        </td>
                                        <td class="py-3 px-3 border-0" style="font-size: 0.85rem;">Turno ${loop.index + 1}</td>
                                        <td class="py-3 px-3 border-0 text-center fw-bold" style="font-size: 0.85rem;">${turno.startTime}</td>
                                        <td class="py-3 px-3 border-0 text-center" style="font-size: 0.85rem;">${turno.endTime}</td>
                                        <td class="py-3 px-3 border-0 text-center">
                                            <span class="badge <c:choose><c:when test="${turno.status == 'Activo'}">bg-success bg-opacity-10 text-success</c:when><c:otherwise>bg-secondary bg-opacity-10 text-secondary</c:otherwise></c:choose> fw-bold px-2" style="font-size: 0.7rem;">${turno.status}</span>
                                        </td>
                                        <td class="py-3 px-3 border-0 text-end rounded-end-3">
                                            <button class="btn btn-link btn-sm text-decoration-none fw-bold text-secondary p-0" style="font-size: 0.75rem;">Ver detalles</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- 2. Turnos (Right Sidebar) -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-light h-100">
                    <div class="d-flex align-items-center gap-2 mb-4">
                        <span class="material-symbols-outlined text-secondary">schedule</span>
                        <h6 class="fw-bold text-dark text-uppercase tracking-wider mb-0" style="font-size: 0.8rem;">Turnos Activos</h6>
                    </div>
                    
                    <div class="d-flex flex-column gap-3">
                        <c:forEach var="turno" items="${turnos}">
                            <div class="card border-0 shadow-sm bg-white p-3 rounded-3 <c:if test="${turno.status == 'Activo'}">border-start border-primary border-4</c:if> <c:if test="${turno.status != 'Activo'}">opacity-75</c:if>">
                                <div class="d-flex justify-content-between align-items-start">
                                    <span class="fw-bold text-dark" style="font-size: 0.8rem;">${turno.operator}</span>
                                    <span class="badge <c:choose><c:when test="${turno.status == 'Activo'}">bg-primary bg-opacity-10 text-primary</c:when><c:otherwise>bg-secondary bg-opacity-10 text-secondary</c:otherwise></c:choose> uppercase" style="font-size: 0.6rem;">${turno.status}</span>
                                </div>
                                <div class="mt-2 d-flex gap-4 text-secondary" style="font-size: 0.75rem;">
                                    <div class="d-flex flex-column">
                                        <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Inicio</small>
                                        <span class="fw-semibold">${turno.startTime}</span>
                                    </div>
                                    <div class="d-flex flex-column border-start ps-3">
                                        <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Fin</small>
                                        <span class="fw-semibold">${turno.endTime}</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <button class="btn btn-outline-secondary btn-sm w-100 mt-4 py-2.5 fw-bold" style="font-size: 0.75rem;">
                        Gestionar Horarios Completos
                    </button>
                </div>
            </div>
        </div>

        <!-- 3. Listado de Camaras (Full Width Bottom) -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                        <div>
                            <h5 class="fw-bold text-dark font-headline mb-0">Inventario de Dispositivos</h5>
                            <small class="text-secondary">Listado completo de puntos de vigilancia remota — ${totalCamaras} cámaras registradas en Supabase.</small>
                        </div>
                        <div class="d-flex gap-2 align-self-stretch align-self-md-auto">
                            <select class="form-select form-select-sm bg-light border-0 py-2.5 px-3 rounded-3 text-dark fw-bold" style="font-size: 0.75rem; width: 160px; box-shadow: none;">
                                <option>Filtrar por Estado</option>
                                <option>Operativas</option>
                                <option>En Mantenimiento</option>
                                <option>Inoperativas</option>
                            </select>
                            <button class="btn btn-light bg-light border-0 p-2.5 rounded-3 d-flex align-items-center justify-content-center"><span class="material-symbols-outlined fs-5">filter_list</span></button>
                        </div>
                    </div>
                    
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:forEach var="cam" items="${camaras}">
                            <div class="col">
                                <c:choose>
                                    <c:when test="${cam.status == 'Inoperativa'}">
                                        <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group border border-danger border-opacity-10">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <small class="text-danger fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">${cam.id}</small>
                                                    <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">${cam.name}</h6>
                                                </div>
                                                <span class="badge bg-danger rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                            </div>
                                            <div class="position-relative overflow-hidden rounded-3 mb-3 d-flex align-items-center justify-content-center bg-white" style="height: 110px;">
                                                <span class="material-symbols-outlined text-danger text-opacity-50 fs-1">videocam_off</span>
                                                <div class="position-absolute top-0 start-0 m-2 bg-danger text-white px-2 py-0.5 rounded fw-bold" style="font-size: 0.6rem; letter-spacing: 0.5px;">NO SIGNAL</div>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                                <span class="text-secondary d-flex align-items-center gap-1">
                                                    <span class="material-symbols-outlined fs-6">location_on</span> ${cam.location}
                                                </span>
                                                <span class="text-danger fw-bold text-uppercase" style="font-size: 0.7rem;">Inoperativa</span>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${cam.status == 'Mantenimiento'}">
                                        <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <small class="text-secondary fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">${cam.id}</small>
                                                    <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">${cam.name}</h6>
                                                </div>
                                                <span class="badge bg-warning rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                            </div>
                                            <div class="position-relative overflow-hidden rounded-3 mb-3" style="height: 110px;">
                                                <c:choose>
                                                    <c:when test="${not empty cam.imageUrl}">
                                                        <img class="w-100 h-100 object-fit-cover grayscale" style="filter: grayscale(100%) blur(1px);" src="${cam.imageUrl}" alt="${cam.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="w-100 h-100 bg-white d-flex align-items-center justify-content-center"><span class="material-symbols-outlined text-warning fs-1">construction</span></div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="position-absolute inset-0 bg-warning bg-opacity-10 d-flex align-items-center justify-content-center">
                                                    <span class="material-symbols-outlined text-white fs-2">construction</span>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                                <span class="text-secondary d-flex align-items-center gap-1">
                                                    <span class="material-symbols-outlined fs-6">location_on</span> ${cam.location}
                                                </span>
                                                <span class="text-warning fw-bold text-uppercase" style="font-size: 0.7rem;">Mantenimiento</span>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <small class="text-secondary fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">${cam.id}</small>
                                                    <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">${cam.name}</h6>
                                                </div>
                                                <span class="badge bg-success rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                            </div>
                                            <div class="position-relative overflow-hidden rounded-3 mb-3" style="height: 110px;">
                                                <c:choose>
                                                    <c:when test="${not empty cam.imageUrl}">
                                                        <img class="w-100 h-100 object-fit-cover grayscale group-hover-grayscale-0" src="${cam.imageUrl}" alt="${cam.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="w-100 h-100 bg-secondary bg-opacity-10 d-flex align-items-center justify-content-center"><span class="material-symbols-outlined text-success fs-1">videocam</span></div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="position-absolute inset-0 bg-dark bg-opacity-25 d-flex align-items-center justify-content-center group-hover-visible">
                                                    <span class="material-symbols-outlined text-white fs-2">play_circle</span>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                                <span class="text-secondary d-flex align-items-center gap-1">
                                                    <span class="material-symbols-outlined fs-6">location_on</span> ${cam.location}
                                                </span>
                                                <span class="text-success fw-bold text-uppercase" style="font-size: 0.7rem;">Operativa</span>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="mt-4 pt-3 border-top d-flex justify-content-center">
                        <nav class="d-flex gap-2">
                            <button class="btn btn-sm btn-dark bg-dark primary-gradient border-0 px-3 fw-bold">1</button>
                            <button class="btn btn-sm btn-light border px-3 fw-bold">2</button>
                            <button class="btn btn-sm btn-light border px-3 fw-bold">3</button>
                            <button class="btn btn-sm btn-light border px-3 d-flex align-items-center justify-content-center"><span class="material-symbols-outlined fs-6">chevron_right</span></button>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>
