package com.mycompany.incident.managment.controller;

import com.mycompany.incident.managment.dto.CamaraDTO;
import com.mycompany.incident.managment.model.Camara;
import com.mycompany.incident.managment.service.CamaraService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/camaras")
public class CamaraRestController {

    private final CamaraService camaraService;

    public CamaraRestController(CamaraService camaraService) {
        this.camaraService = camaraService;
    }

    @GetMapping
    public List<Camara> listarTodas() {
        return camaraService.obtenerTodas();
    }

    @PostMapping
    public ResponseEntity<?> crear(@RequestBody CamaraDTO dto) {
        System.out.println("===> [POST] /api/camaras - Registrando camara: " + dto.getId() + " - " + dto.getName());
        try {
            camaraService.guardarCamara(dto);
            System.out.println("===> Camara guardada con exito en BD");
            return ResponseEntity.ok("ok");
        } catch (Exception e) {
            System.out.println("===> ERROR guardando camara: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(@PathVariable String id, @RequestBody CamaraDTO dto) {
        System.out.println("===> [PUT] /api/camaras/" + id + " - Actualizando camara");
        try {
            dto.setId(id);
            camaraService.guardarCamara(dto);
            System.out.println("===> Camara actualizada con exito en BD");
            return ResponseEntity.ok("ok");
        } catch (Exception e) {
            System.out.println("===> ERROR actualizando camara: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable String id) {
        try {
            camaraService.eliminarCamara(id);
            return ResponseEntity.ok("ok");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
}
