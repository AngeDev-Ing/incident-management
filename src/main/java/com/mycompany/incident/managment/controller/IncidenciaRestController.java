package com.mycompany.incident.managment.controller;

import com.mycompany.incident.managment.dto.IncidenciaDTO;
import com.mycompany.incident.managment.model.Incidencia;
import com.mycompany.incident.managment.service.IncidenciaService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@RestController
@RequestMapping("/api/incidencias")
public class IncidenciaRestController {

    private final IncidenciaService incidenciaService;
    private final SimpMessagingTemplate messagingTemplate;

    public IncidenciaRestController(
            IncidenciaService incidenciaService,
            SimpMessagingTemplate messagingTemplate
    ) {
        this.incidenciaService = incidenciaService;
        this.messagingTemplate = messagingTemplate;
    }

    // LISTAR TODAS
    @GetMapping
    public List<Incidencia> listarTodas() {
        return incidenciaService.listarTodas();
    }

    // OBTENER POR ID
    @GetMapping("/{id}")
    public ResponseEntity<Incidencia> obtenerPorId(@PathVariable Long id) {
        return incidenciaService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // CREAR
    @PostMapping
    public Incidencia crear(@RequestBody IncidenciaDTO dto) {
        Incidencia incidencia = new Incidencia();
        incidencia.setTitle(dto.getTitle());
        incidencia.setDescription(dto.getDescription());
        incidencia.setDate(dto.getDate());
        incidencia.setTime(dto.getTime());
        incidencia.setType(dto.getType());
        incidencia.setPriority(dto.getPriority());
        incidencia.setStatus(dto.getStatus());
        incidencia.setSupervisor(dto.getSupervisor());
        incidencia.setOperator(dto.getOperator());
        incidencia.setCamera(dto.getCamera());

        Incidencia nueva = incidenciaService.guardar(incidencia);

        Map<String, Object> notificacion = new HashMap<>();
        notificacion.put("titulo", "Nueva incidencia registrada");
        notificacion.put("mensaje", nueva.getTitle());
        notificacion.put("tipo", nueva.getType());
        notificacion.put("estado", nueva.getStatus());

        messagingTemplate.convertAndSend(
                "/topic/notificaciones",
                notificacion
        );

        return nueva;
    }

    // ACTUALIZAR
    @PutMapping("/{id}")
    public ResponseEntity<Incidencia> actualizar(
            @PathVariable Long id,
            @RequestBody IncidenciaDTO dto) {

        return incidenciaService.obtenerPorId(id)
                .map(incidencia -> {
                    incidencia.setTitle(dto.getTitle());
                    incidencia.setDescription(dto.getDescription());
                    incidencia.setDate(dto.getDate());
                    incidencia.setTime(dto.getTime());
                    incidencia.setType(dto.getType());
                    incidencia.setPriority(dto.getPriority());
                    incidencia.setStatus(dto.getStatus());

                    return ResponseEntity.ok(
                            incidenciaService.guardar(incidencia)
                    );
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // ELIMINAR
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        incidenciaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    // BÚSQUEDA PREDICTIVA
    @GetMapping("/search")
    public List<Incidencia> buscar(@RequestParam String query) {
        return incidenciaService.buscarPorTitulo(query);
    }
}