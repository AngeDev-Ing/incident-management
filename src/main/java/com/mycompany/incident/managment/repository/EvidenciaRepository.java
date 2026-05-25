package com.mycompany.incident.managment.repository;

import com.mycompany.incident.managment.model.Evidencia;
import com.mycompany.incident.managment.model.Incidencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EvidenciaRepository extends JpaRepository<Evidencia, Long> {
    List<Evidencia> findByIncidencia(Incidencia incidencia);
    List<Evidencia> findByIncidenciaId(Long incidenciaId);
}
