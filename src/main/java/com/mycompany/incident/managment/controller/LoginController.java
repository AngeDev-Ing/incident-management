package com.mycompany.incident.managment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import com.mycompany.incident.managment.repository.UsuarioRepository;
import com.mycompany.incident.managment.repository.IncidenciaRepository;
import com.mycompany.incident.managment.repository.CamaraRepository;
import com.mycompany.incident.managment.repository.TurnoRepository;
import java.util.List;

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

    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/app")
    public String app() {
        return "app";
    }

    @GetMapping("/fragment/dashboard")
    public String fragmentDashboard(Model model) {
        long activeIncidents = incidenciaRepo.countByStatusIn(List.of("Pendiente", "En Proceso"));
        model.addAttribute("activeIncidentsCount", activeIncidents);
        model.addAttribute("incidencias", incidenciaRepo.findTop3ByOrderByIdDesc());
        model.addAttribute("totalIncidentsCount", incidenciaRepo.count());
        return "dashboard-content";
    }

    @GetMapping("/fragment/incidencias")
    public String fragmentIncidencias(Model model) {
        long pendientes = incidenciaRepo.countByStatus("Pendiente");
        long enProceso = incidenciaRepo.countByStatus("En Proceso");
        model.addAttribute("pendientesCount", pendientes);
        model.addAttribute("enProcesoCount", enProceso);
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

        model.addAttribute("totalCount", total);
        model.addAttribute("roboCount", robo);
        model.addAttribute("sospechosoCount", sospechoso);
        model.addAttribute("accidenteCount", accidente);
        model.addAttribute("infraestructuraCount", infraestructura);
        model.addAttribute("mantenimientoCount", mantenimiento);

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
