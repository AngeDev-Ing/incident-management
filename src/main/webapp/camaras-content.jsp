<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        <!-- Bento Grid Layout -->
        <div class="row g-4 mb-4">
            <!-- 1. Asignacion de Camaras (Wide Section) -->
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
                                    <th class="border-0 px-3">Base</th>
                                    <th class="border-0 px-3 text-center">Total</th>
                                    <th class="border-0 px-3 text-center">Operativas</th>
                                    <th class="border-0 px-3 text-center">Inoperativas</th>
                                    <th class="border-0 px-3 text-end">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="bg-light rounded-3 shadow-sm">
                                    <td class="py-3 px-3 border-0 rounded-start-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-primary bg-opacity-10 d-flex align-items-center justify-content-center fw-bold text-primary" style="width: 32px; height: 32px; font-size: 0.75rem;">AM</div>
                                            <span class="fw-semibold text-dark" style="font-size: 0.85rem;">Alejandro Morales</span>
                                        </div>
                                    </td>
                                    <td class="py-3 px-3 border-0" style="font-size: 0.85rem;">Sector Norte 01</td>
                                    <td class="py-3 px-3 border-0 text-center fw-bold" style="font-size: 0.85rem;">124</td>
                                    <td class="py-3 px-3 border-0 text-center">
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold px-2.5 py-1.5" style="font-size: 0.7rem;">118</span>
                                    </td>
                                    <td class="py-3 px-3 border-0 text-center">
                                        <span class="badge bg-danger bg-opacity-10 text-danger fw-bold px-2.5 py-1.5" style="font-size: 0.7rem;">6</span>
                                    </td>
                                    <td class="py-3 px-3 border-0 text-end rounded-end-3">
                                        <button class="btn btn-link btn-sm text-decoration-none fw-bold text-secondary p-0" style="font-size: 0.75rem;">Ver detalles</button>
                                    </td>
                                </tr>
                                <tr class="bg-light rounded-3 shadow-sm">
                                    <td class="py-3 px-3 border-0 rounded-start-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-secondary bg-opacity-10 d-flex align-items-center justify-content-center fw-bold text-secondary" style="width: 32px; height: 32px; font-size: 0.75rem;">EC</div>
                                            <span class="fw-semibold text-dark" style="font-size: 0.85rem;">Elena Castillo</span>
                                        </div>
                                    </td>
                                    <td class="py-3 px-3 border-0" style="font-size: 0.85rem;">Zona Céntrica A</td>
                                    <td class="py-3 px-3 border-0 text-center fw-bold" style="font-size: 0.85rem;">86</td>
                                    <td class="py-3 px-3 border-0 text-center">
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold px-2.5 py-1.5" style="font-size: 0.7rem;">84</span>
                                    </td>
                                    <td class="py-3 px-3 border-0 text-center">
                                        <span class="badge bg-danger bg-opacity-10 text-danger fw-bold px-2.5 py-1.5" style="font-size: 0.7rem;">2</span>
                                    </td>
                                    <td class="py-3 px-3 border-0 text-end rounded-end-3">
                                        <button class="btn btn-link btn-sm text-decoration-none fw-bold text-secondary p-0" style="font-size: 0.75rem;">Ver detalles</button>
                                    </td>
                                </tr>
                                <tr class="bg-light rounded-3 shadow-sm">
                                    <td class="py-3 px-3 border-0 rounded-start-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-warning bg-opacity-10 d-flex align-items-center justify-content-center fw-bold text-warning" style="width: 32px; height: 32px; font-size: 0.75rem;">RJ</div>
                                            <span class="fw-semibold text-dark" style="font-size: 0.85rem;">Ricardo Jimenez</span>
                                        </div>
                                    </td>
                                    <td class="py-3 px-3 border-0" style="font-size: 0.85rem;">Perímetro Puerto</td>
                                    <td class="py-3 px-3 border-0 text-center fw-bold" style="font-size: 0.85rem;">45</td>
                                    <td class="py-3 px-3 border-0 text-center">
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold px-2.5 py-1.5" style="font-size: 0.7rem;">40</span>
                                    </td>
                                    <td class="py-3 px-3 border-0 text-center">
                                        <span class="badge bg-danger bg-opacity-10 text-danger fw-bold px-2.5 py-1.5" style="font-size: 0.7rem;">5</span>
                                    </td>
                                    <td class="py-3 px-3 border-0 text-end rounded-end-3">
                                        <button class="btn btn-link btn-sm text-decoration-none fw-bold text-secondary p-0" style="font-size: 0.75rem;">Ver detalles</button>
                                    </td>
                                </tr>
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
                        <!-- Card Active Turn -->
                        <div class="card border-0 shadow-sm bg-white p-3 rounded-3 border-start border-primary border-4">
                            <div class="d-flex justify-content-between align-items-start">
                                <span class="fw-bold text-dark" style="font-size: 0.8rem;">Cmdr. Marcus Vance</span>
                                <span class="badge bg-primary bg-opacity-10 text-primary uppercase" style="font-size: 0.6rem;">Activo</span>
                            </div>
                            <div class="mt-2 d-flex gap-4 text-secondary" style="font-size: 0.75rem;">
                                <div class="d-flex flex-column">
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Inicio</small>
                                    <span class="fw-semibold">08:00 AM</span>
                                </div>
                                <div class="d-flex flex-column border-start ps-3">
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Fin</small>
                                    <span class="fw-semibold">16:00 PM</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Card Scheduled Turn 1 -->
                        <div class="card border-0 shadow-sm bg-white p-3 rounded-3 opacity-75">
                            <div class="d-flex justify-content-between align-items-start">
                                <span class="fw-bold text-dark" style="font-size: 0.8rem;">Sgt. Lucía Ferreyra</span>
                                <span class="badge bg-secondary bg-opacity-10 text-secondary uppercase" style="font-size: 0.6rem;">Programado</span>
                            </div>
                            <div class="mt-2 d-flex gap-4 text-secondary" style="font-size: 0.75rem;">
                                <div class="d-flex flex-column">
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Inicio</small>
                                    <span class="fw-semibold">16:00 PM</span>
                                </div>
                                <div class="d-flex flex-column border-start ps-3">
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Fin</small>
                                    <span class="fw-semibold">00:00 AM</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Card Scheduled Turn 2 -->
                        <div class="card border-0 shadow-sm bg-white p-3 rounded-3 opacity-75">
                            <div class="d-flex justify-content-between align-items-start">
                                <span class="fw-bold text-dark" style="font-size: 0.8rem;">Cpl. Daniel Ortega</span>
                                <span class="badge bg-secondary bg-opacity-10 text-secondary uppercase" style="font-size: 0.6rem;">Programado</span>
                            </div>
                            <div class="mt-2 d-flex gap-4 text-secondary" style="font-size: 0.75rem;">
                                <div class="d-flex flex-column">
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Inicio</small>
                                    <span class="fw-semibold">00:00 AM</span>
                                </div>
                                <div class="d-flex flex-column border-start ps-3">
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.6rem;">Fin</small>
                                    <span class="fw-semibold">08:00 AM</span>
                                </div>
                            </div>
                        </div>
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
                            <small class="text-secondary">Listado completo de puntos de vigilancia remota.</small>
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
                        <!-- Camera Card 1 -->
                        <div class="col">
                            <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <small class="text-secondary fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">DS-CAM-8842</small>
                                        <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">Intersección Calle Real</h6>
                                    </div>
                                    <span class="badge bg-success rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                </div>
                                <div class="position-relative overflow-hidden rounded-3 mb-3" style="height: 110px;">
                                    <img class="w-100 h-100 object-fit-cover grayscale group-hover-grayscale-0" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC7CqVIYJvwY8Mj0jS6EimLdFQkkwP5aytxwXsxZ_hCLTCmBgow6GjAucBiTJikyAX8ZVFnOO8EgQLBV4BWmM_zvLBILhXknL1mQmyvOCTGYrVfUZ3sUF9-ouXMgphBzdllcYP927UOwrC7hNfHiLtdmHNb2rQf_3yYHwDMj8rgjdyHif2dJUXJDsfVC4jlktYuK5vp0oA_YoAMn4zLu2jrr41hVAYM69qBxC9z0fPO10kW1fxuGMExJvgnpepfmEu91fzGBOZ8DgFg" alt="Real Street Camera">
                                    <div class="position-absolute inset-0 bg-dark bg-opacity-25 d-flex align-items-center justify-content-center group-hover-visible">
                                        <span class="material-symbols-outlined text-white fs-2">play_circle</span>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                    <span class="text-secondary d-flex align-items-center gap-1">
                                        <span class="material-symbols-outlined fs-6">location_on</span> Zona A-1
                                    </span>
                                    <span class="text-success fw-bold text-uppercase" style="font-size: 0.7rem;">Operativa</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Camera Card 2 -->
                        <div class="col">
                            <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <small class="text-secondary fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">DS-CAM-9011</small>
                                        <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">Entrada Principal Norte</h6>
                                    </div>
                                    <span class="badge bg-success rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                </div>
                                <div class="position-relative overflow-hidden rounded-3 mb-3" style="height: 110px;">
                                    <img class="w-100 h-100 object-fit-cover grayscale group-hover-grayscale-0" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA2tyNRpa2xgFuByo8bVPPHg8vwbVnlEd7SqsbLqC-s3iKWu29hEL1DKuRl7CgT_iEzZiUIUt3xQOIToIn5Vwmo3WgCd0HzbwUUeAZbdfG5nzFNV4RYLd81qmQ-l93gqa6EXJtQL_w08KkjfbGx3d4UJYw9oD6Qu0ZG-a7FdZcmAlmzhml_WyT05eqtnJqSUfMq_IHy0lc2TkJFoHXAPmE06F13eq0zh5KUpUYaq-wi2cOJeOmgkmqWiKJA298Fut1LjsKQeegXZdwn" alt="Building Entrance">
                                    <div class="position-absolute inset-0 bg-dark bg-opacity-25 d-flex align-items-center justify-content-center group-hover-visible">
                                        <span class="material-symbols-outlined text-white fs-2">play_circle</span>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                    <span class="text-secondary d-flex align-items-center gap-1">
                                        <span class="material-symbols-outlined fs-6">location_on</span> Perímetro
                                    </span>
                                    <span class="text-success fw-bold text-uppercase" style="font-size: 0.7rem;">Operativa</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Camera Card 3 (Inoperative) -->
                        <div class="col">
                            <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group border border-danger border-opacity-10">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <small class="text-danger fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">DS-CAM-4421</small>
                                        <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">Callejón 4 - Sector C</h6>
                                    </div>
                                    <span class="badge bg-danger rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                </div>
                                <div class="position-relative overflow-hidden rounded-3 mb-3 d-flex align-items-center justify-content-center bg-white" style="height: 110px;">
                                    <span class="material-symbols-outlined text-danger text-opacity-50 fs-1">videocam_off</span>
                                    <div class="position-absolute top-0 start-0 m-2 bg-danger text-white px-2 py-0.5 rounded fw-bold" style="font-size: 0.6rem; letter-spacing: 0.5px;">NO SIGNAL</div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                    <span class="text-secondary d-flex align-items-center gap-1">
                                        <span class="material-symbols-outlined fs-6">location_on</span> Zona C-4
                                    </span>
                                    <span class="text-danger fw-bold text-uppercase" style="font-size: 0.7rem;">Inoperativa</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Camera Card 4 (Maintenance) -->
                        <div class="col">
                            <div class="card border-0 shadow-sm bg-light rounded-3 p-3 h-100 group">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <small class="text-secondary fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">DS-CAM-1102</small>
                                        <h6 class="fw-bold text-dark mb-0" style="font-size: 0.8rem;">Plaza de Armas S.</h6>
                                    </div>
                                    <span class="badge bg-warning rounded-circle p-1" style="width: 8px; height: 8px;">&nbsp;</span>
                                </div>
                                <div class="position-relative overflow-hidden rounded-3 mb-3" style="height: 110px;">
                                    <img class="w-100 h-100 object-fit-cover grayscale" style="filter: grayscale(100%) blur(1px);" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA3jenfROXDYkWlwpEZQ4pXYFJxi8nj6B_jOcZilV4DvN2tr77YaSNBnKOmKxtWxCqlK3OWcnifbJBwRcEi11RyUAMX4EvrTHCvVHQlycTd3h6v8v1pl1W7jM0q2k7hcIqa2Yck4syIxyQSn0gbQ00l79zhPre2ZaDgDqcdwaj_9eQkiIzFEUHPmqjEGl9vxr14F4vYDjZxq9NYSD3_Cp8VqvBu_4J52F8PM972LWc9gFe7E46kp_AsnzI2lzq5coL4ne2X_di-gPTk" alt="Plaza Camera">
                                    <div class="position-absolute inset-0 bg-warning bg-opacity-10 d-flex align-items-center justify-content-center">
                                        <span class="material-symbols-outlined text-white fs-2">construction</span>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-auto" style="font-size: 0.75rem;">
                                    <span class="text-secondary d-flex align-items-center gap-1">
                                        <span class="material-symbols-outlined fs-6">location_on</span> Zona B-2
                                    </span>
                                    <span class="text-warning fw-bold text-uppercase" style="font-size: 0.7rem;">Mantenimiento</span>
                                </div>
                            </div>
                        </div>
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
