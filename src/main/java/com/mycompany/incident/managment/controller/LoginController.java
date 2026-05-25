package com.mycompany.incident.managment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import com.mycompany.incident.managment.repository.IncidenciaRepository;
import com.mycompany.incident.managment.repository.CamaraRepository;
import com.mycompany.incident.managment.repository.TurnoRepository;
import com.mycompany.incident.managment.repository.ZonaRepository;
import java.util.List;

@Controller
public class LoginController {

    private final IncidenciaRepository incidenciaRepo;
    private final CamaraRepository camaraRepo;
    private final TurnoRepository turnoRepo;
    private final ZonaRepository zonaRepo;

    public LoginController(IncidenciaRepository incidenciaRepo,
                           CamaraRepository camaraRepo,
                           TurnoRepository turnoRepo,
                           ZonaRepository zonaRepo) {
        this.incidenciaRepo = incidenciaRepo;
        this.camaraRepo = camaraRepo;
        this.turnoRepo = turnoRepo;
        this.zonaRepo = zonaRepo;
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
        
        List<com.mycompany.incident.managment.model.Camara> todasLasCamaras = camaraRepo.findAll();
        long totalCamaras = todasLasCamaras.size();
        long totalCamarasActivas = todasLasCamaras.stream().filter(c -> "Operativa".equalsIgnoreCase(c.getStatus())).count();
        
        double porcentajeUptime = 0.0;
        if (totalCamaras > 0) {
            porcentajeUptime = ((double) totalCamarasActivas / totalCamaras) * 100.0;
        }
        String uptimeFormat = String.format(java.util.Locale.US, "%.1f%%", porcentajeUptime);
        
        long totalZonas = zonaRepo.count();
        
        // Calcular tiempo promedio de respuesta y tendencia semanal
        List<com.mycompany.incident.managment.model.Incidencia> resueltas = incidenciaRepo.findAll().stream()
                .filter(i -> i.getCreadoEn() != null && i.getResueltoEn() != null)
                .toList();
                
        long totalMinutos = 0;
        for (com.mycompany.incident.managment.model.Incidencia i : resueltas) {
            totalMinutos += java.time.Duration.between(i.getCreadoEn(), i.getResueltoEn()).toMinutes();
        }
        
        String tiempoPromedio = "0m";
        if (!resueltas.isEmpty()) {
            long promedio = totalMinutos / resueltas.size();
            tiempoPromedio = promedio + "m";
        }
        
        // Calcular la tendencia (Últimos 7 días vs 7 días previos)
        java.time.LocalDateTime ahora = java.time.LocalDateTime.now();
        java.time.LocalDateTime hace7Dias = ahora.minusDays(7);
        java.time.LocalDateTime hace14Dias = ahora.minusDays(14);

        long sumSegundosUltimos7 = 0;
        int countUltimos7 = 0;
        long sumSegundosPrevios7 = 0;
        int countPrevios7 = 0;

        for (com.mycompany.incident.managment.model.Incidencia i : resueltas) {
            long segs = java.time.Duration.between(i.getCreadoEn(), i.getResueltoEn()).getSeconds();
            if (i.getResueltoEn().isAfter(hace7Dias)) {
                sumSegundosUltimos7 += segs;
                countUltimos7++;
            } else if (i.getResueltoEn().isAfter(hace14Dias)) {
                sumSegundosPrevios7 += segs;
                countPrevios7++;
            }
        }

        String tendencia = "0s";
        String tendenciaColor = "text-secondary";
        
        if (countUltimos7 > 0 && countPrevios7 > 0) {
            long promUltimos7 = sumSegundosUltimos7 / countUltimos7;
            long promPrevios7 = sumSegundosPrevios7 / countPrevios7;
            long diferencia = promUltimos7 - promPrevios7;
            
            if (diferencia > 0) {
                tendencia = "+" + diferencia + "s";
                tendenciaColor = "text-danger"; // Más lento = malo
            } else if (diferencia < 0) {
                tendencia = diferencia + "s";
                tendenciaColor = "text-success"; // Más rápido = bueno
            }
        }
        
        model.addAttribute("activeIncidentsCount", activeIncidents);
        model.addAttribute("incidencias", incidenciaRepo.findTop3ByOrderByIdDesc());
        model.addAttribute("totalIncidentsCount", incidenciaRepo.count());
        model.addAttribute("camarasActivasCount", totalCamarasActivas);
        model.addAttribute("zonasCount", totalZonas);
        model.addAttribute("uptimePercentage", uptimeFormat);
        model.addAttribute("tiempoPromedio", tiempoPromedio);
        model.addAttribute("tendenciaRespuesta", tendencia);
        model.addAttribute("tendenciaColor", tendenciaColor);
        
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
}
