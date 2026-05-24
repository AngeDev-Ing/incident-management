package com.mycompany.incident.managment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import com.mycompany.incident.managment.repository.UsuarioRepository;
import com.mycompany.incident.managment.repository.IncidenciaRepository;
import com.mycompany.incident.managment.repository.CamaraRepository;
import com.mycompany.incident.managment.repository.TurnoRepository;
import com.mycompany.incident.managment.model.Usuario;
import java.util.List;
import java.util.Optional;

@Controller
public class LoginController {

    private final UsuarioRepository usuarioRepo;
    private final IncidenciaRepository incidenciaRepo;
    private final CamaraRepository camaraRepo;
    private final TurnoRepository turnoRepo;

    public LoginController(UsuarioRepository usuarioRepo,
                           IncidenciaRepository incidenciaRepo,
                           CamaraRepository camaraRepo,
                           TurnoRepository turnoRepo) {
        this.usuarioRepo = usuarioRepo;
        this.incidenciaRepo = incidenciaRepo;
        this.camaraRepo = camaraRepo;
        this.turnoRepo = turnoRepo;
    }

    // ─── Auth ───────────────────────────────────────────────────────────────

    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String authenticate(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            Model model) {
        
        Optional<Usuario> usuarioOpt = usuarioRepo.findByUsername(username);
        
        if (usuarioOpt.isPresent() && usuarioOpt.get().getPassword().equals(password)) {
            // Credenciales válidas → redirige al shell SPA
            return "redirect:/app";
        }
        
        model.addAttribute("error", "Credenciales incorrectas de Agente.");
        return "login";
    }

    @GetMapping("/logout")
    public String logout() {
        return "redirect:/login";
    }

    // ─── SPA Shell ──────────────────────────────────────────────────────────

    /**
     * Sirve el shell principal de la SPA. El sidebar y el header
     * permanecen aquí; el contenido de cada módulo se inyecta vía JS.
     */
    @GetMapping("/app")
    public String app() {
        return "app";
    }

    // ─── Fragment Endpoints (AJAX) ───────────────────────────────────────────

    @GetMapping("/fragment/dashboard")
    public String fragmentDashboard(Model model) {
        // Incidencias activas (Pendiente y En Proceso)
        long activeIncidents = incidenciaRepo.countByStatusIn(List.of("Pendiente", "En Proceso"));
        model.addAttribute("activeIncidentsCount", activeIncidents);

        // Historial más reciente (últimos 3)
        model.addAttribute("incidencias", incidenciaRepo.findTop3ByOrderByIdDesc());
        
        // Cantidad total de registros históricos
        model.addAttribute("totalIncidentsCount", incidenciaRepo.count());
        
        return "dashboard-content";
    }

    @GetMapping("/fragment/incidencias")
    public String fragmentIncidencias(Model model) {
        long pendientes = incidenciaRepo.countByStatus("Pendiente");
        long enProceso = incidenciaRepo.countByStatus("En Proceso");
        
        model.addAttribute("pendientesCount", pendientes);
        model.addAttribute("enProcesoCount", enProceso);
        
        // Carga todas las incidencias
        model.addAttribute("incidencias", incidenciaRepo.findAllByOrderByIdDesc());
        
        return "incidencias-content";
    }

    @GetMapping("/fragment/reportes")
    public String fragmentReportes(Model model) {
        long total = incidenciaRepo.count();
        long robo = incidenciaRepo.countByType("Robo");
        long sospechoso = incidenciaRepo.countByType("Sospechoso");
        long accidente = incidenciaRepo.countByType("Accidente");
        long infraestructura = incidenciaRepo.countByType("Infraestructura");
        long mantenimiento = incidenciaRepo.countByType("Mantenimiento");
        
        // Pasar estadísticas para gráficos
        model.addAttribute("totalCount", total);
        model.addAttribute("roboCount", robo);
        model.addAttribute("sospechosoCount", sospechoso);
        model.addAttribute("accidenteCount", accidente);
        model.addAttribute("infraestructuraCount", infraestructura);
        model.addAttribute("mantenimientoCount", mantenimiento);
        
        // Evitar divisiones por cero en gráficos
        long baseMax = Math.max(1, total);
        model.addAttribute("roboPct", (robo * 100) / baseMax);
        model.addAttribute("sospechosoPct", (sospechoso * 100) / baseMax);
        model.addAttribute("accidentePct", (accidente * 100) / baseMax);
        model.addAttribute("infraestructuraPct", (infraestructura * 100) / baseMax);
        model.addAttribute("mantenimientoPct", (mantenimiento * 100) / baseMax);
        
        return "reportes-content";
    }

    @GetMapping("/fragment/camaras")
    public String fragmentCamaras(Model model) {
        List<com.mycompany.incident.managment.model.Camara> camaras = camaraRepo.findAll();
        long operativas = camaras.stream().filter(c -> "Operativa".equalsIgnoreCase(c.getStatus())).count();
        long inoperativas = camaras.stream().filter(c -> "Inoperativa".equalsIgnoreCase(c.getStatus())).count();
        long mantenimiento = camaras.stream().filter(c -> "Mantenimiento".equalsIgnoreCase(c.getStatus())).count();

        model.addAttribute("camaras", camaras);
        model.addAttribute("totalCamaras", camaras.size());
        model.addAttribute("operativasCamaras", operativas);
        model.addAttribute("inoperativasCamaras", inoperativas);
        model.addAttribute("mantenimientoCamaras", mantenimiento);
        
        model.addAttribute("turnos", turnoRepo.findAll());
        return "camaras-content";
    }
}
