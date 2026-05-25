package com.mycompany.incident.managment.service;

import com.mycompany.incident.managment.model.Incidencia;
import com.mycompany.incident.managment.repository.IncidenciaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class IncidenciaService {

    private final IncidenciaRepository incidenciaRepository;

    public IncidenciaService(IncidenciaRepository incidenciaRepository) {
        this.incidenciaRepository = incidenciaRepository;
    }

    // LISTAR TODAS
    public List<Incidencia> listarTodas() {
        return incidenciaRepository.findAllByOrderByIdDesc();
    }

    // OBTENER POR ID
    public Optional<Incidencia> obtenerPorId(Long id) {
        return incidenciaRepository.findById(id);
    }

    // CREAR O ACTUALIZAR
    public Incidencia guardar(Incidencia incidencia) {
        return incidenciaRepository.save(incidencia);
    }

    // ELIMINAR
    public void eliminar(Long id) {
        incidenciaRepository.deleteById(id);
    }

    // CONTADORES
    public long contarPendientes() {
        return incidenciaRepository.countByStatus("Pendiente");
    }

    public long contarEnProceso() {
        return incidenciaRepository.countByStatus("En Proceso");
    }

    // BÚSQUEDA PREDICTIVA
    public List<Incidencia> buscarPorTitulo(String query) {
        return incidenciaRepository.findByTitleContainingIgnoreCase(query);
    }
}