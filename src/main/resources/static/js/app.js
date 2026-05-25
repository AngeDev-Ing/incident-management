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

    async navigate(page, pushState = true) {
        if (page === this.currentPage) return;

        const route = this.routes[page];
        if (!route) {
            console.error(`[SPA] Unknown route: ${page}`);
            return;
        }

        this.setLoading(true);
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

            if (!response.ok) {
                throw new Error(`HTTP ${response.status}`);
            }

            const html = await response.text();
            this.contentArea.innerHTML = html;
            this.currentPage = page;

            if (pushState) {
                history.pushState({ page }, route.title, `#${page}`);
            }

            const titleEl = document.getElementById('pageTitle');
            if (titleEl) titleEl.textContent = route.title;

            document.title = `${route.title} — Digital Sentinel`;

            this.contentArea.scrollTo(0, 0);
            window.scrollTo(0, 0);

        } catch (err) {
            console.error('[SPA] Failed to load fragment:', err);
            this.contentArea.innerHTML = `
                <div class="d-flex flex-column align-items-center justify-content-center w-100 text-center p-5" style="min-height:60vh;">
                    <span class="material-symbols-outlined text-danger mb-3" style="font-size: 3rem;">error</span>
                    <h5 class="fw-bold text-dark">Error al cargar el módulo</h5>
                    <p class="text-secondary">No se pudo conectar con el servidor. Intenta de nuevo.</p>
                    <button class="btn btn-dark btn-sm mt-3" onclick="SPA.navigate('${page}')">Reintentar</button>
                </div>`;
        }
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
    }
};

document.addEventListener('DOMContentLoaded', () => SPA.init());
