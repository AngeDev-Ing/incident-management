package com.mycompany.incident.managment.controller;

import com.mycompany.incident.managment.model.Camara;
import com.mycompany.incident.managment.model.Zona;
import com.mycompany.incident.managment.repository.CamaraRepository;
import com.mycompany.incident.managment.repository.ZonaRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

@Controller
public class CamaraController {

    private final CamaraRepository camaraRepo;
    private final ZonaRepository zonaRepo;

    public CamaraController(CamaraRepository camaraRepo, ZonaRepository zonaRepo) {
        this.camaraRepo = camaraRepo;
        this.zonaRepo = zonaRepo;
    }

    @GetMapping("/fragment/camaras")
    public String fragmentCamaras(Model model) {
        List<Camara> camaras = camaraRepo.findAll();
        
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

    @PostMapping("/api/camaras/guardar")
    @ResponseBody
    public ResponseEntity<?> guardarCamara(@RequestParam String id,
                                           @RequestParam String name,
                                           @RequestParam String location,
                                           @RequestParam String status,
                                           @RequestParam(required = false) String zonaId,
                                           @RequestParam(required = false) String ipAddress) {
        try {
            Camara camara = camaraRepo.findById(id).orElse(new Camara());
            camara.setId(id);
            camara.setName(name);
            camara.setLocation(location);
            camara.setStatus(status);
            camara.setIpAddress((ipAddress != null && !ipAddress.isBlank()) ? ipAddress : null);

            // Parsear zonaId de forma segura: string vacío = sin zona
            if (zonaId != null && !zonaId.isBlank()) {
                try {
                    Long zonaIdLong = Long.parseLong(zonaId);
                    zonaRepo.findById(zonaIdLong).ifPresent(camara::setZona);
                } catch (NumberFormatException ignored) {
                    camara.setZona(null);
                }
            } else {
                camara.setZona(null);
            }

            if (camara.getImageUrl() == null || camara.getImageUrl().isEmpty()) {
                camara.setImageUrl("https://placehold.co/600x400/212529/FFFFFF?text=" + id);
            }

            camaraRepo.save(camara);
            return ResponseEntity.ok("ok");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @PostMapping("/api/camaras/eliminar")
    @ResponseBody
    public ResponseEntity<?> eliminarCamara(@RequestParam String id) {
        try {
            camaraRepo.deleteById(id);
            return ResponseEntity.ok("ok");
        } catch(Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
}
