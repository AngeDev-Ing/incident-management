<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Digital Sentinel - Operational Command</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/styles.css"/>
</head>
<body class="bg-light font-body text-dark">

<!-- SIDEBAR -->
<aside class="sidebar bg-dark text-white d-flex flex-column shadow">
    <div class="p-4">
        <div class="d-flex align-items-center gap-3">
            <div class="primary-gradient d-flex align-items-center justify-content-center rounded-3 text-white" style="width: 40px; height: 40px;">
                <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">shield</span>
            </div>
            <div>
                <h6 class="fw-bold mb-0">Operational Command</h6>
                <small class="text-secondary text-uppercase fw-bold" style="letter-spacing: 1px; font-size: 0.65rem;">Level 4 Authorization</small>
            </div>
        </div>
    </div>

    <ul class="nav nav-pills flex-column mb-auto px-3 gap-1">
        <li class="nav-item">
            <a href="#" class="nav-link text-white spa-link d-flex align-items-center gap-3" data-page="dashboard">
                <span class="material-symbols-outlined">dashboard</span> Dashboard
            </a>
        </li>
        <li>
            <a href="#" class="nav-link text-white opacity-75 spa-link d-flex align-items-center gap-3" data-page="incidencias">
                <span class="material-symbols-outlined">emergency</span> Incidencias
            </a>
        </li>
        <li>
            <a href="#" class="nav-link text-white opacity-75 spa-link d-flex align-items-center gap-3" data-page="reportes">
                <span class="material-symbols-outlined">assessment</span> Reportes
            </a>
        </li>
        <li>
            <a href="#" class="nav-link text-white opacity-75 spa-link d-flex align-items-center gap-3" data-page="camaras">
                <span class="material-symbols-outlined">videocam</span> Cámaras
            </a>
        </li>
    </ul>

    <div class="p-4 mt-auto border-top border-secondary">
        <a href="#" class="text-white text-decoration-none opacity-75 d-flex align-items-center gap-2 mb-2" style="font-size: 0.9rem;">
            <span class="material-symbols-outlined fs-6">support_agent</span> Soporte
        </a>
        <a href="/logout" class="text-white text-decoration-none opacity-75 d-flex align-items-center gap-2 mb-4" style="font-size: 0.9rem;">
            <span class="material-symbols-outlined fs-6">logout</span> Cerrar Sesión
        </a>

        <div class="d-flex align-items-center gap-3 bg-secondary bg-opacity-25 p-2 rounded">
            <div class="rounded-circle primary-gradient d-flex align-items-center justify-content-center text-white fw-bold" style="width: 32px; height: 32px; font-size: 0.75rem;">AD</div>
            <div>
                <div class="fw-bold" style="font-size: 0.85rem;">Admin</div>
                <div class="text-secondary" style="font-size: 0.7rem;">admin@sentinel.hq</div>
            </div>
        </div>
    </div>
</aside>

<!-- HEADER -->
<header class="top-header border-bottom d-flex align-items-center justify-content-between px-4">
    <div class="d-flex align-items-center gap-4">
        <!-- Mobile menu toggle -->
        <button class="btn btn-link text-dark p-0 d-md-none" id="sidebarToggle">
            <span class="material-symbols-outlined">menu</span>
        </button>
        <h5 class="fw-bolder text-dark mb-0 d-none d-md-block font-headline" id="pageTitle">Digital Sentinel</h5>
        <div class="position-relative">
            <span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-2 text-muted" style="font-size: 1.1rem;">search</span>
            <input type="text" class="form-control form-control-sm ps-4 rounded-pill bg-light border-0" placeholder="Buscar..." style="width: 250px;">
        </div>
    </div>
    <div class="d-flex align-items-center gap-3">
        <button class="btn btn-link text-secondary p-0 position-relative">
            <span class="material-symbols-outlined">notifications</span>
            <span class="position-absolute top-0 start-100 translate-middle p-1 bg-primary border border-light rounded-circle" style="width: 6px; height: 6px;"></span>
        </button>
        <button class="btn btn-link text-secondary p-0"><span class="material-symbols-outlined">settings</span></button>
        <button class="btn btn-link text-secondary p-0"><span class="material-symbols-outlined">account_circle</span></button>
    </div>
</header>

<!-- SPA CONTENT AREA -->
<div id="spa-content" class="d-flex flex-grow-1">
    <!-- Content fragments are injected here by app.js -->
    <div id="content-loader" class="d-flex align-items-center justify-content-center w-100" style="min-height: 60vh;">
        <div class="text-center">
            <div class="spinner-border text-primary" role="status" style="width: 2.5rem; height: 2.5rem;"></div>
            <p class="text-muted mt-3 fw-semibold" style="font-size: 0.85rem;">Cargando módulo...</p>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- SPA Router -->
<script src="/js/app.js"></script>
</body>
</html>
