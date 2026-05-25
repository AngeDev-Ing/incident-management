package com.mycompany.incident.managment.repository;

import com.mycompany.incident.managment.model.Incidencia;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface IncidenciaRepository extends JpaRepository<Incidencia, Long> {
    long countByStatus(String status);
    long countByStatusIn(List<String> statuses);
    long countByType(String type);
    List<Incidencia> findTop3ByOrderByIdDesc();
    List<Incidencia> findAllByOrderByIdDesc();
    List<Incidencia> findByTitleContainingIgnoreCase(String query);
}
