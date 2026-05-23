<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Ingreso al Sistema - Digital Sentinel</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@700;800;900&family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/styles.css"/>
</head>
<body class="bg-light font-body text-dark d-flex align-items-center justify-content-center min-vh-100 position-relative overflow-hidden">

<!-- Background Decoration -->
<div class="position-absolute top-0 start-0 w-100 h-100 z-0 pointer-events-none">
    <div class="position-absolute top-0 end-0 translate-middle rounded-circle bg-primary opacity-5" style="width: 50vw; height: 50vw; filter: blur(120px);"></div>
    <div class="position-absolute bottom-0 start-0 translate-middle rounded-circle bg-secondary opacity-5" style="width: 40vw; height: 40vw; filter: blur(100px);"></div>
</div>

<!-- Login Container -->
<main class="position-relative z-3 w-100 px-3 py-5" style="max-width: 450px;">
    <!-- Brand Identity -->
    <div class="d-flex flex-column align-items-center mb-4">
        <div class="signature-gradient d-flex align-items-center justify-content-center rounded-4 shadow mb-3" style="width: 64px; height: 64px;">
            <span class="material-symbols-outlined text-white fs-3" style="font-variation-settings: 'FILL' 1;">security</span>
        </div>
        <h1 class="font-headline fs-3 fw-bolder text-dark uppercase mb-1">
            Digital Sentinel
        </h1>
        <p class="text-secondary text-uppercase tracking-wider fw-semibold" style="font-size: 0.7rem; letter-spacing: 0.2em;">
            Operational Command Unit
        </p>
    </div>
    
    <!-- Login Card -->
    <div class="card border-0 shadow rounded-4 p-4 glass-panel">
        <h5 class="fw-bold text-dark text-center mb-4 font-headline">Ingreso al Sistema</h5>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2 rounded-3 text-center mb-3" style="font-size: 0.8rem; border: none; background-color: rgba(220, 53, 69, 0.1); color: #dc3545;">
                <span class="material-symbols-outlined fs-6 align-middle me-1">error</span>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="/login" method="POST">
            <!-- Username Field -->
            <div class="mb-3">
                <label class="form-label text-secondary fw-bold text-uppercase d-flex align-items-center gap-2" style="font-size: 0.65rem; letter-spacing: 0.05em;" for="username">
                    <span class="material-symbols-outlined fs-6">badge</span> Usuario
                </label>
                <input class="form-control form-control-sm bg-light border-0 py-2.5 rounded-3 text-dark" id="username" name="username" placeholder="Identificador de Agente" type="text" required />
            </div>
            
            <!-- Password Field -->
            <div class="mb-4">
                <label class="form-label text-secondary fw-bold text-uppercase d-flex align-items-center gap-2" style="font-size: 0.65rem; letter-spacing: 0.05em;" for="password">
                    <span class="material-symbols-outlined fs-6">lock</span> Contraseña
                </label>
                <div class="position-relative">
                    <input class="form-control form-control-sm bg-light border-0 py-2.5 rounded-3 pe-5 text-dark" id="password" name="password" placeholder="••••••••" type="password" required />
                    <button class="btn btn-link position-absolute end-0 top-50 translate-middle-y text-secondary p-2 d-flex align-items-center text-decoration-none" type="button">
                        <span class="material-symbols-outlined fs-5">visibility</span>
                    </button>
                </div>
            </div>
            
            <!-- Action Bar -->
            <button class="btn btn-dark w-100 signature-gradient border-0 py-3 rounded-3 fw-bold text-uppercase tracking-wider d-flex align-items-center justify-content-center gap-2" type="submit">
                Iniciar Sesión
                <span class="material-symbols-outlined fs-5">login</span>
            </button>
        </form>
        
        <!-- Metadata Footer -->
        <div class="mt-4 pt-2 text-center border-top border-light">
            <a class="text-secondary text-decoration-none fw-semibold uppercase tracking-wider d-block mb-3" href="#" style="font-size: 0.7rem;">
                Solicitar acceso de nivel 4
            </a>
            <div class="d-flex align-items-center justify-content-center gap-2 text-muted text-uppercase" style="font-size: 0.65rem;">
                <span>Versión 2.4.0-ST</span>
                <span class="badge bg-secondary p-0 rounded-circle" style="width: 4px; height: 4px;">&nbsp;</span>
                <span>Acceso Encriptado TLS 1.3</span>
            </div>
        </div>
    </div>
    
    <!-- Support Info -->
    <p class="text-center text-secondary mt-4 mx-auto" style="font-size: 0.7rem; max-width: 300px;">
        Este sistema es propiedad de Digital Sentinel. El acceso no autorizado está estrictamente prohibido y sujeto a acciones legales.
    </p>
</main>

<!-- Decoration Element (Asymmetric Detail) -->
<div class="position-absolute bottom-0 end-0 p-5 d-none d-lg-block opacity-25">
    <div class="d-flex flex-column align-items-end">
        <div class="bg-dark" style="width: 128px; height: 1px;"></div>
        <div class="font-headline text-dark fw-black display-2 leading-none">01</div>
        <div class="text-secondary text-uppercase tracking-wider" style="font-size: 0.6rem; letter-spacing: 0.5em;">Command_Center</div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>