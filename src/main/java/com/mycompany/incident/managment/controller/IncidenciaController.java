package com.mycompany.incident.managment.controller;

import com.mycompany.incident.managment.repository.IncidenciaRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IncidenciaController {

    private final IncidenciaRepository incidenciaRepository;

    public IncidenciaController(IncidenciaRepository incidenciaRepository) {
        this.incidenciaRepository = incidenciaRepository;
    }

    @GetMapping("/incidencias")
    public String listarIncidencias(Model model) {
        model.addAttribute("incidencias", incidenciaRepository.findAllByOrderByIdDesc());
        model.addAttribute("pendientesCount", incidenciaRepository.countByStatus("Pendiente"));
        model.addAttribute("enProcesoCount", incidenciaRepository.countByStatus("En Proceso"));

        return "incidencias-content";
    }
}
