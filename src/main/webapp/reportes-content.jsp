<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- MAIN CONTENT -->
<main class="main-content p-4 w-100">
    <div class="container-fluid max-w-7xl">
        
        <!-- Page Header & Filters -->
        <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-end gap-3 mb-4">
            <div>
                <h2 class="font-headline fw-bold text-dark mb-1">Análisis de Operaciones</h2>
                <p class="text-secondary mb-0">Visión analítica del rendimiento de vigilancia y patrones de incidentes.</p>
            </div>
            <div class="d-flex flex-wrap align-items-center gap-2 bg-light p-2 rounded-4 border">
                <div class="d-flex align-items-center bg-white rounded-3 px-3 py-2 shadow-sm border border-light">
                    <span class="material-symbols-outlined text-primary me-2 fs-5">calendar_today</span>
                    <select class="form-select form-select-sm border-0 p-0 fw-bold bg-transparent text-secondary cursor-pointer" style="font-size: 0.75rem; width: 140px; box-shadow: none;">
                        <option>ÚLTIMOS 30 DÍAS</option>
                        <option>ESTE TRIMESTRE</option>
                        <option>AÑO ACTUAL</option>
                    </select>
                </div>
                <div class="d-flex align-items-center bg-white rounded-3 px-3 py-2 shadow-sm border border-light">
                    <span class="material-symbols-outlined text-primary me-2 fs-5">filter_list</span>
                    <select class="form-select form-select-sm border-0 p-0 fw-bold bg-transparent text-secondary cursor-pointer" style="font-size: 0.75rem; width: 160px; box-shadow: none;">
                        <option>TODAS LAS CATEGORÍAS</option>
                        <option>SEGURIDAD CRÍTICA</option>
                        <option>MANTENIMIENTO</option>
                    </select>
                </div>
                <button class="btn btn-dark btn-sm primary-gradient border-0 fw-bold px-4 py-2.5 rounded-3 text-uppercase tracking-wider" style="font-size: 0.7rem;">
                    Exportar PDF
                </button>
            </div>
        </div>

        <!-- Bento Grid Content -->
        <div class="row g-4 mb-4">
            <!-- Main Chart: Incidencias por Fecha -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                    <div class="d-flex justify-content-between align-items-start mb-4">
                        <div>
                            <h5 class="fw-bold text-dark font-headline mb-0">Incidencias por Fecha</h5>
                            <small class="text-secondary">Tendencia histórica de actividad detectada</small>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="badge bg-info rounded-circle p-1 me-2" style="width: 8px; height: 8px;">&nbsp;</span>
                            <span class="text-secondary fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">VOLUMEN</span>
                        </div>
                    </div>
                    
                    <!-- Simulated Line Chart -->
                    <div class="position-relative flex-grow-1" style="min-height: 250px;">
                        <svg class="w-100 h-100" viewBox="0 0 1000 300" preserveAspectRatio="none">
                            <defs>
                                <linearGradient id="lineGrad" x1="0" x2="0" y1="0" y2="1">
                                    <stop offset="0%" stop-color="#0ea5e9" stop-opacity="0.3"></stop>
                                    <stop offset="100%" stop-color="#0ea5e9" stop-opacity="0"></stop>
                                </linearGradient>
                            </defs>
                            <!-- Grid Lines -->
                            <line stroke="#e4e9ed" stroke-width="1" x1="0" x2="1000" y1="50" y2="50"></line>
                            <line stroke="#e4e9ed" stroke-width="1" x1="0" x2="1000" y1="150" y2="150"></line>
                            <line stroke="#e4e9ed" stroke-width="1" x1="0" x2="1000" y1="250" y2="250"></line>
                            <!-- Area -->
                            <path d="M0,250 L100,200 L200,220 L300,100 L400,120 L500,60 L600,180 L700,90 L800,110 L900,40 L1000,70 L1000,300 L0,300 Z" fill="url(#lineGrad)"></path>
                            <!-- Line -->
                            <path class="line-chart-path" d="M0,250 L100,200 L200,220 L300,100 L400,120 L500,60 L600,180 L700,90 L800,110 L900,40 L1000,70" fill="none" stroke="#0ea5e9" stroke-linecap="round" stroke-width="4"></path>
                        </svg>
                        <div class="d-flex justify-content-between mt-3 text-secondary fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">
                            <span>01 SEP</span>
                            <span>08 SEP</span>
                            <span>15 SEP</span>
                            <span>22 SEP</span>
                            <span>29 SEP</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Side Stat: Summary -->
            <div class="col-lg-4">
                <div class="d-flex flex-column gap-4 h-100">
                    <!-- Total Mes Card -->
                    <div class="card border-0 shadow rounded-4 bg-dark text-white p-4 flex-grow-1 position-relative overflow-hidden primary-gradient">
                        <div class="position-relative z-3 d-flex flex-column justify-content-between h-100">
                            <div>
                                <span class="text-info fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">Total Mes</span>
                                <span class="display-3 fw-bold font-headline">1,284</span>
                            </div>
                            <div class="mt-4 d-flex align-items-center text-info gap-2" style="font-size: 0.85rem;">
                                <span class="material-symbols-outlined fs-6">trending_up</span>
                                <span class="fw-bold">+12.5% vs mes anterior</span>
                            </div>
                        </div>
                        <!-- Background icon -->
                        <span class="material-symbols-outlined position-absolute bottom-0 end-0 opacity-10 m-0" style="font-size: 10rem; transform: translate(15%, 15%); pointer-events: none;">security</span>
                    </div>
                    
                    <!-- Response time card -->
                    <div class="card border-0 shadow-sm rounded-4 p-4">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <span class="text-secondary fw-bold text-uppercase d-block" style="font-size: 0.65rem; letter-spacing: 1px;">Tiempo de Respuesta</span>
                                <span class="fs-1 fw-bold text-dark mt-1">4.2m</span>
                            </div>
                            <div class="w-12 h-12 rounded-circle bg-info bg-opacity-10 text-info d-flex align-items-center justify-content-center" style="width: 48px; height: 48px;">
                                <span class="material-symbols-outlined fs-4">bolt</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bar Chart: Incidencias por Tipo -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                        <div>
                            <h5 class="fw-bold text-dark font-headline mb-0">Incidencias por Tipo</h5>
                            <small class="text-secondary">Distribución porcentual por categoría operativa</small>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-light btn-sm text-secondary border fw-bold px-3">VISTA SEMANAL</button>
                            <button class="btn btn-dark btn-sm primary-gradient border-0 fw-bold px-3">VISTA MENSUAL</button>
                        </div>
                    </div>
                    
                    <div class="row g-4 align-items-end pt-3">
                        <!-- Bar 1 -->
                        <div class="col">
                            <div class="d-flex flex-column align-items-center group">
                                <div class="w-100 bg-light rounded-top-3 position-relative d-flex align-items-end overflow-hidden" style="height: 250px;">
                                    <div class="w-100 bg-dark primary-gradient opacity-75 group-hover-opacity-100" style="height: 75% !important; transition: height 0.5s ease;"></div>
                                    <span class="position-absolute top-0 start-50 translate-middle-x mt-2 text-secondary fw-bold" style="font-size: 0.75rem;">75%</span>
                                </div>
                                <div class="mt-3 text-center">
                                    <div class="fw-bold text-dark text-uppercase" style="font-size: 0.7rem; letter-spacing: 1px;">Acceso No Aut.</div>
                                    <small class="text-secondary" style="font-size: 0.65rem;">963 EVENTOS</small>
                                </div>
                            </div>
                        </div>
                        <!-- Bar 2 -->
                        <div class="col">
                            <div class="d-flex flex-column align-items-center group">
                                <div class="w-100 bg-light rounded-top-3 position-relative d-flex align-items-end overflow-hidden" style="height: 250px;">
                                    <div class="w-100 bg-info opacity-75 group-hover-opacity-100" style="height: 42% !important; transition: height 0.5s ease;"></div>
                                    <span class="position-absolute top-0 start-50 translate-middle-x mt-2 text-secondary fw-bold" style="font-size: 0.75rem;">42%</span>
                                </div>
                                <div class="mt-3 text-center">
                                    <div class="fw-bold text-dark text-uppercase" style="font-size: 0.7rem; letter-spacing: 1px;">Vandalismo</div>
                                    <small class="text-secondary" style="font-size: 0.65rem;">540 EVENTOS</small>
                                </div>
                            </div>
                        </div>
                        <!-- Bar 3 -->
                        <div class="col">
                            <div class="d-flex flex-column align-items-center group">
                                <div class="w-100 bg-light rounded-top-3 position-relative d-flex align-items-end overflow-hidden" style="height: 250px;">
                                    <div class="w-100 bg-dark primary-gradient opacity-75 group-hover-opacity-100" style="height: 88% !important; transition: height 0.5s ease;"></div>
                                    <span class="position-absolute top-0 start-50 translate-middle-x mt-2 text-secondary fw-bold" style="font-size: 0.75rem;">88%</span>
                                </div>
                                <div class="mt-3 text-center">
                                    <div class="fw-bold text-dark text-uppercase" style="font-size: 0.7rem; letter-spacing: 1px;">Falla Técnica</div>
                                    <small class="text-secondary" style="font-size: 0.65rem;">1,130 EVENTOS</small>
                                </div>
                            </div>
                        </div>
                        <!-- Bar 4 -->
                        <div class="col">
                            <div class="d-flex flex-column align-items-center group">
                                <div class="w-100 bg-light rounded-top-3 position-relative d-flex align-items-end overflow-hidden" style="height: 250px;">
                                    <div class="w-100 bg-info bg-opacity-50 opacity-75 group-hover-opacity-100" style="height: 15% !important; transition: height 0.5s ease;"></div>
                                    <span class="position-absolute top-0 start-50 translate-middle-x mt-2 text-secondary fw-bold" style="font-size: 0.75rem;">15%</span>
                                </div>
                                <div class="mt-3 text-center">
                                    <div class="fw-bold text-dark text-uppercase" style="font-size: 0.7rem; letter-spacing: 1px;">Mantenimiento</div>
                                    <small class="text-secondary" style="font-size: 0.65rem;">192 EVENTOS</small>
                                </div>
                            </div>
                        </div>
                        <!-- Bar 5 -->
                        <div class="col">
                            <div class="d-flex flex-column align-items-center group">
                                <div class="w-100 bg-light rounded-top-3 position-relative d-flex align-items-end overflow-hidden" style="height: 250px;">
                                    <div class="w-100 bg-secondary opacity-75 group-hover-opacity-100" style="height: 28% !important; transition: height 0.5s ease;"></div>
                                    <span class="position-absolute top-0 start-50 translate-middle-x mt-2 text-secondary fw-bold" style="font-size: 0.75rem;">28%</span>
                                </div>
                                <div class="mt-3 text-center">
                                    <div class="fw-bold text-dark text-uppercase" style="font-size: 0.7rem; letter-spacing: 1px;">Otros</div>
                                    <small class="text-secondary" style="font-size: 0.65rem;">359 EVENTOS</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Featured Report Card -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="row g-0">
                        <div class="col-md-4 position-relative" style="min-height: 250px;">
                            <img class="position-absolute w-100 h-100 object-fit-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCgP3lKa220-eZoXqeD8P07NgOILuxFbuRt_k4zAcgRoM1hfdpyi2C_jrCvnCSM7Vzk8m4Zruh6LHnLroQPNGWXMKVMXDq6_8fnExdTyzpUsBHC5vof1T-Krmg00igzkRDz-kVQsPaf7ghRUdLfHrLSPwP3WJ5KKc9615sfdJCmop87_dpHD4MbHfwtFoemY1OAlhMhJCEqshmMntAOtGcLyN7FUrQ6Z2SF7rRFJZXTgRrdavv8OZwnoOb9tJo-bMyE-z72ZVevmqjQ" alt="Control Room">
                        </div>
                        <div class="col-md-8 p-5 d-flex flex-column justify-content-center">
                            <span class="text-info fw-bold text-uppercase d-block mb-2" style="font-size: 0.7rem; letter-spacing: 2px;">Reporte Destacado del Mes</span>
                            <h3 class="fw-bold text-dark font-headline mb-3 leading-tight">Optimización de Respuesta en el Sector Noroeste</h3>
                            <p class="text-secondary leading-relaxed mb-4">
                                El despliegue de la nueva unidad táctica ha reducido los tiempos de respuesta en un 24%. Este reporte detalla los puntos de calor detectados y la efectividad del patrullaje automatizado.
                            </p>
                            <div class="d-flex align-items-center gap-4">
                                <button class="btn btn-link text-dark fw-bold text-uppercase p-0 text-decoration-none d-flex align-items-center gap-2 hover-translate-right" style="font-size: 0.75rem; letter-spacing: 1px;">
                                    Leer Reporte Completo
                                    <span class="material-symbols-outlined fs-5">arrow_forward</span>
                                </button>
                                <span class="text-muted" style="font-size: 0.8rem;">PDF (12.4 MB)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>
