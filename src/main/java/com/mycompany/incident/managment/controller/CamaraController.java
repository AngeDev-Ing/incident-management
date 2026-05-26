package com.mycompany.incident.managment.controller;

import com.mycompany.incident.managment.model.Camara;
import com.mycompany.incident.managment.repository.ZonaRepository;
import com.mycompany.incident.managment.service.CamaraService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CamaraController {

    private final CamaraService camaraService;
    private final ZonaRepository zonaRepo;

    public CamaraController(CamaraService camaraService, ZonaRepository zonaRepo) {
        this.camaraService = camaraService;
        this.zonaRepo = zonaRepo;
    }

    @GetMapping("/fragment/camaras")
    public String fragmentCamaras(Model model) {
        List<Camara> camaras = camaraService.obtenerTodas();
        
        long operativas = camaras.stream().filter(c -> "Operativa".equalsIgnoreCase(c.getStatus())).count();
        long mantenimiento = camaras.stream().filter(c -> "Mantenimiento".equalsIgnoreCase(c.getStatus())).count();
        long inoperativas = camaras.size() - operativas - mantenimiento;

        model.addAttribute("camaras", camaras);
        model.addAttribute("zonas", zonaRepo.findAll());
        model.addAttribute("totalCount", camaras.size());
        model.addAttribute("operativasCount", operativas);
        model.addAttribute("mantenimientoCount", mantenimiento);
        model.addAttribute("inoperativasCount", inoperativas);
        
        return "camaras-content";
    }
}
