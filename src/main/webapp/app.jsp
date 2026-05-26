<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Digital Sentinel - Centro de Control</title>
    <link rel="icon" type="image/x-icon" href="/assets/DS-FAVICON.ico"/>

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
    <div class="p-4 border-bottom border-secondary">
        <div class="d-flex flex-column gap-3">
            <img src="/assets/DS-WHITE.webp" alt="Digital Sentinel" style="width: 100%; max-height: 40px; object-fit: contain; object-position: left;"/>
            <div>
                <h6 class="fw-bold mb-1 text-white">Centro de Control</h6>
                <small class="text-secondary text-uppercase fw-bold d-block" style="letter-spacing: 1px; font-size: 0.65rem;">Autorización Nivel 4</small>
            </div>
        </div>
    </div>

    <ul class="nav nav-pills flex-column mb-auto px-3 gap-1">
        <li class="nav-item">
            <a href="#" class="nav-link text-white spa-link d-flex align-items-center gap-3" data-page="dashboard">
                <span class="material-symbols-outlined">dashboard</span> Panel Principal
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
        <a href="#" onclick="SPA.logout()" class="text-white text-decoration-none opacity-75 d-flex align-items-center gap-2 mb-4" style="font-size: 0.9rem;">
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

            <span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-2 text-muted"
                style="font-size: 1.1rem;">
                search
            </span>

            <input
                type="text"
                id="searchIncidencias"
                class="form-control form-control-sm ps-4 rounded-pill bg-light border-0"
                placeholder="Buscar incidencias..."
                style="width: 250px;">

            <div
                id="searchSuggestions"
                class="position-absolute bg-white shadow rounded-3 mt-2 d-none"
                style="
                    z-index:9999;
                    width:350px;
                    max-height:300px;
                    overflow-y:auto;
                    left:0;
                ">
            </div>
        </div>
    </div>
    <div class="d-flex align-items-center gap-3">
        <button class="btn btn-link text-secondary p-0 position-relative">
            <span class="material-symbols-outlined">notifications</span>
            <span
                id="notificationBadge"
                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger d-none"
                style="font-size: 0.6rem;">
                0
            </span>
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
<!-- WebSockets: SockJS & STOMP -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<!-- SPA Router -->
<script src="/js/app.js"></script>
<script>
document.addEventListener("click", function (e) {
    const btnVer = e.target.closest(".btn-ver-incidencia");
    if (btnVer) {
        document.getElementById("detTitle").innerText = btnVer.dataset.title || "Sin Título";
        document.getElementById("detId").innerText = "ID: INC-" + btnVer.dataset.id + "-X";
        
        let prio = btnVer.dataset.priority || "Media";
        let detPriority = document.getElementById("detPriority");
        detPriority.innerText = prio;
        detPriority.className = "badge px-3 py-2 rounded-pill text-uppercase fs-7 " + 
            (prio === 'Crítica' ? 'bg-danger' : (prio === 'Alta' ? 'bg-warning text-dark' : (prio === 'Media' ? 'bg-primary' : 'bg-secondary')));
            
        let stat = btnVer.dataset.status || "Pendiente";
        let detStatus = document.getElementById("detStatus");
        detStatus.innerText = stat;
        detStatus.className = "badge px-3 py-2 rounded-pill text-uppercase fs-7 " +
            (stat === 'Pendiente' ? 'bg-danger' : (stat === 'En Proceso' ? 'bg-info text-dark' : (stat === 'Resuelto' ? 'bg-success' : 'bg-secondary')));

        document.getElementById("detType").innerText = btnVer.dataset.type || "Desconocido";
        document.getElementById("detDate").innerText = btnVer.dataset.date || "--/--/----";
        document.getElementById("detTime").innerText = btnVer.dataset.time || "--:--";
        document.getElementById("detCamera").innerText = btnVer.dataset.camera || "Sin Cámara asignada";
        document.getElementById("detSupervisor").innerText = btnVer.dataset.supervisor || "No asignado";
        document.getElementById("detOperator").innerText = btnVer.dataset.operator || "No asignado";
        document.getElementById("detDescription").innerText = btnVer.dataset.description || "No se adjuntó descripción del evento.";
        return;
    }

    const btnEditar = e.target.closest(".btn-editar-incidencia");

    if (!btnEditar) return;

    setTimeout(function () {
        document.getElementById("modalIncidenciaTitulo").innerText = "Editar Incidencia";
        document.getElementById("textoBotonGuardarIncidencia").innerText = "Actualizar Incidencia";

        document.getElementById("incidenciaId").value = btnEditar.dataset.id || "";
        document.getElementById("title").value = btnEditar.dataset.title || "";
        document.getElementById("description").value = btnEditar.dataset.description || "";
        document.getElementById("date").value = btnEditar.dataset.date || "";
        document.getElementById("time").value = btnEditar.dataset.time || "";
        document.getElementById("type").value = btnEditar.dataset.type || "Robo";
        document.getElementById("priority").value = btnEditar.dataset.priority || "Media";
        document.getElementById("status").value = btnEditar.dataset.status || "Pendiente";
        document.getElementById("supervisor").value = btnEditar.dataset.supervisor || "";
        document.getElementById("operator").value = btnEditar.dataset.operator || "";
        document.getElementById("camera").value = btnEditar.dataset.camera || "";
    }, 500);
});

document.addEventListener("click", function (e) {
    const btnNuevo = e.target.closest("[data-bs-target='#modalIncidencia']:not(.btn-editar-incidencia)");

    if (!btnNuevo) return;

    document.getElementById("modalIncidenciaTitulo").innerText = "Registrar Nueva Incidencia";
    document.getElementById("textoBotonGuardarIncidencia").innerText = "Guardar Incidencia";

    document.getElementById("incidenciaId").value = "";
    document.getElementById("title").value = "";
    document.getElementById("description").value = "";
    document.getElementById("date").value = "";
    document.getElementById("time").value = "";
    document.getElementById("type").value = "Robo";
    document.getElementById("priority").value = "Media";
    document.getElementById("status").value = "Pendiente";
    document.getElementById("supervisor").value = "";
    document.getElementById("operator").value = "";
    document.getElementById("camera").value = "";
});

document.addEventListener("click", async function (e) {
    const boton = e.target.closest("#btnGuardarIncidencia");

    if (!boton) return;

    const id = document.getElementById("incidenciaId").value;

    const incidencia = {
        title: document.getElementById("title").value,
        description: document.getElementById("description").value,
        date: document.getElementById("date").value,
        time: document.getElementById("time").value,
        type: document.getElementById("type").value,
        priority: document.getElementById("priority").value,
        status: document.getElementById("status").value,
        supervisor: document.getElementById("supervisor").value,
        operator: document.getElementById("operator").value,
        camera: document.getElementById("camera").value
    };

    if (!incidencia.title || !incidencia.date || !incidencia.time) {
        alert("Completa título, fecha y hora.");
        return;
    }

    const url = id ? "/api/incidencias/" + id : "/api/incidencias";
    const method = id ? "PUT" : "POST";

    const response = await fetch(url, {
        method: method,
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(incidencia)
    });

    if (response.ok) {
        alert(id ? "Incidencia actualizada correctamente" : "Incidencia registrada correctamente");

        if (id) {
            location.reload();
        } else {
            const modal = bootstrap.Modal.getInstance(document.getElementById("modalIncidencia"));
            modal.hide();

            setTimeout(() => {
                location.reload();
            }, 2000);
        }
    } else {
        const error = await response.text();
        console.error(error);
        alert("Error al guardar incidencia");
    }
});

document.addEventListener("click", async function (e) {
    const btnEliminar = e.target.closest(".btn-eliminar-incidencia");

    if (!btnEliminar) return;

    const id = btnEliminar.dataset.id;

    const confirmar = confirm("¿Eliminar esta incidencia?");

    if (!confirmar) return;

    const response = await fetch("/api/incidencias/" + id, {
        method: "DELETE"
    });

    if (response.ok) {
        alert("Incidencia eliminada correctamente");
        location.reload();
    } else {
        const error = await response.text();
        console.error(error);
        alert("Error al eliminar incidencia");
    }
});
document.addEventListener("input", async function (e) {
    if (e.target.id !== "searchIncidencias") return;

    const query = e.target.value.trim();
    const contenedor = document.getElementById("searchSuggestions");

    if (query.length < 2) {
        contenedor.classList.add("d-none");
        contenedor.innerHTML = "";
        return;
    }

    const response = await fetch("/api/incidencias/search?query=" + encodeURIComponent(query));

    if (!response.ok) {
        contenedor.classList.add("d-none");
        return;
    }

    const resultados = await response.json();
    console.log(resultados);

    if (resultados.length === 0) {
        contenedor.innerHTML = `
            <div class="p-3 text-muted small">
                No se encontraron incidencias
            </div>
        `;
        contenedor.classList.remove("d-none");
        return;
    }

    contenedor.innerHTML = resultados.map(function(inc) {
    return '<div class="p-3 border-bottom" style="cursor:pointer;">' +
        '<strong class="text-dark">' + (inc.title || 'Sin título') + '</strong><br>' +
        '<small class="text-muted">' +
            (inc.type || 'Sin tipo') + ' - ' +
            (inc.status || 'Sin estado') + ' - ' +
            (inc.date || 'Sin fecha') +
        '</small>' +
    '</div>';
}).join("");

    contenedor.classList.remove("d-none");
});
let contadorNotificaciones = 0;

function conectarWebSocket() {

    const socket = new SockJS("/ws");
    const stompClient = Stomp.over(socket);

    stompClient.connect({}, function () {

        console.log("WebSocket conectado");

        stompClient.subscribe("/topic/notificaciones", function (message) {

            const data = JSON.parse(message.body);

            contadorNotificaciones++;

            const badge = document.getElementById("notificationBadge");

            if (badge) {
                badge.classList.remove("d-none");
                badge.innerText = contadorNotificaciones;
                mostrarToastNotificacion(data.titulo, data.mensaje);
            }

            alert(
                data.titulo + ": " + data.mensaje
            );
        });
    });
}
function mostrarToastNotificacion(titulo, mensaje) {
    const toast = document.createElement("div");

    toast.className = "position-fixed top-0 end-0 m-4 p-3 bg-dark text-white rounded-4 shadow";
    toast.style.zIndex = "99999";
    toast.innerHTML =
        "<strong>" + titulo + "</strong><br>" +
        "<small>" + mensaje + "</small>";

    document.body.appendChild(toast);

    setTimeout(function () {
        toast.remove();
    }, 4000);
}
conectarWebSocket();
</script>
</body>
</html>