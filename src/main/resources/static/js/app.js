const SPA = {
    routes: {
        dashboard:   { endpoint: '/fragment/dashboard',   title: 'Panel Principal' },
        incidencias: { endpoint: '/fragment/incidencias', title: 'Incidencias' },
        reportes:    { endpoint: '/fragment/reportes',    title: 'Reportes' },
        camaras:     { endpoint: '/fragment/camaras',     title: 'Cámaras' },
    },

    contentArea: null,
    currentPage: null,

    getToken() {
        return sessionStorage.getItem('jwt_token');
    },

    logout() {
        sessionStorage.removeItem('jwt_token');
        sessionStorage.removeItem('username');
        window.location.href = '/login';
    },

    init() {
        const token = this.getToken();
        if (!token) {
            window.location.href = '/login';
            return;
        }

        this.contentArea = document.getElementById('spa-content');

        document.querySelectorAll('.spa-link').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const page = link.dataset.page;
                this.navigate(page);
            });
        });

        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', () => this.logout());
        }

        window.addEventListener('popstate', (e) => {
            if (e.state && e.state.page) {
                this.navigate(e.state.page, false);
            }
        });

        const hash = window.location.hash.replace('#', '');
        const initialPage = this.routes[hash] ? hash : 'dashboard';
        this.navigate(initialPage, true);
    },

    async navigate(page, pushState = true, silent = false) {
        if (page === this.currentPage && pushState) return;

        const route = this.routes[page];
        if (!route) {
            console.error(`[SPA] Unknown route: ${page}`);
            return;
        }

        if (!silent) this.setLoading(true);
        this.updateNavActive(page);

        try {
            const response = await fetch(route.endpoint, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + this.getToken()
                }
            });

            if (response.status === 401 || response.status === 403) {
                this.logout();
                return;
            }

            if (!response.ok) throw new Error(`HTTP ${response.status}`);

            const html = await response.text();
            this.contentArea.innerHTML = html;
            
            const scripts = this.contentArea.querySelectorAll('script');
            scripts.forEach(oldScript => {
                const newScript = document.createElement('script');
                Array.from(oldScript.attributes).forEach(attr => newScript.setAttribute(attr.name, attr.value));
                newScript.appendChild(document.createTextNode(oldScript.innerHTML));
                oldScript.parentNode.replaceChild(newScript, oldScript);
            });

            this.currentPage = page;

            if (pushState) {
                history.pushState({ page }, route.title, `#${page}`);
            }

            const titleEl = document.getElementById('pageTitle');
            if (titleEl) titleEl.textContent = route.title;
            document.title = `${route.title} — Digital Sentinel`;

            if (!silent) {
                this.contentArea.scrollTo(0, 0);
                window.scrollTo(0, 0);
            }

        } catch (err) {
            console.error('[SPA] Failed to load fragment:', err);
            if (!silent) {
                this.contentArea.innerHTML = `
                    <div class="d-flex flex-column align-items-center justify-content-center w-100 text-center p-5" style="min-height:60vh;">
                        <span class="material-symbols-outlined text-danger mb-3" style="font-size: 3rem;">error</span>
                        <h5 class="fw-bold text-dark">Error al cargar el módulo</h5>
                        <p class="text-secondary">No se pudo conectar con el servidor.</p>
                        <button class="btn btn-dark btn-sm mt-3" onclick="SPA.navigate('${page}')">Reintentar</button>
                    </div>`;
            }
        }
    },

    // Recarga forzada del fragmento actual (para CRUD: guardar / eliminar)
    // Usamos silent=true para que no haya parpadeo ni se pierda el scroll
    async reload() {
        const page = this.currentPage;
        if (!page) return;
        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
        document.body.classList.remove('modal-open');
        document.body.style.removeProperty('overflow');
        document.body.style.removeProperty('padding-right');
        
        this.currentPage = null;
        await this.navigate(page, false, true); // silent=true
    },

    setLoading(show) {
        if (show) {
            this.contentArea.innerHTML = `
                <div class="d-flex align-items-center justify-content-center w-100" style="min-height: 60vh;">
                    <div class="text-center">
                        <div class="spinner-border text-primary" role="status" style="width: 2.5rem; height: 2.5rem;"></div>
                        <p class="text-muted mt-3 fw-semibold" style="font-size: 0.85rem;">Cargando módulo...</p>
                    </div>
                </div>`;
        }
    },

    updateNavActive(activePage) {
        document.querySelectorAll('.spa-link').forEach(link => {
            const isActive = link.dataset.page === activePage;
            link.classList.toggle('active', isActive);
            link.classList.toggle('bg-primary', isActive);
            link.classList.toggle('bg-opacity-25', isActive);
            link.classList.toggle('opacity-75', !isActive);
        });
    },

    connectWebSocket() {
        const socket = new SockJS('/ws');
        this.stompClient = Stomp.over(socket);
        this.stompClient.debug = null; // Ocultar logs molestos en consola
        
        this.stompClient.connect({}, (frame) => {
            console.log('[SPA] WebSocket Conectado');
            
            // Suscribirse a las notificaciones globales
            this.stompClient.subscribe('/topic/incidencias', (message) => {
                const data = JSON.parse(message.body);
                console.log('[SPA] Nueva alerta WebSocket:', data);
                
                // Si la campana existe, mostrar el puntito rojo o sumar contador
                const bellBadge = document.getElementById('notifBadge');
                if (bellBadge) {
                    bellBadge.classList.remove('d-none');
                }
                
                // Si estamos en el dashboard, tal vez recargar o mostrar un toast
                if (this.currentPage === 'dashboard') {
                    // Refrescar el dashboard sin recargar toda la página
                    this.navigate('dashboard', false); 
                }
            });
        }, (error) => {
            console.error('[SPA] Error WebSocket:', error);
            // Intentar reconectar en 5 segundos
            setTimeout(() => this.connectWebSocket(), 5000);
        });
    }
};

document.addEventListener('DOMContentLoaded', () => {
    SPA.init();
    SPA.connectWebSocket();
});
