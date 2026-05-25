package com.mycompany.incident.managment.repository;

import com.mycompany.incident.managment.model.Auditoria;
import com.mycompany.incident.managment.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AuditoriaRepository extends JpaRepository<Auditoria, Long> {
    /** Últimas N acciones de un usuario */
    List<Auditoria> findByUsuarioOrderByRealizadoEnDesc(Usuario usuario);

    /** Filtrar por tipo de acción */
    List<Auditoria> findByAccionOrderByRealizadoEnDesc(String accion);

    /** Filtrar por entidad (ej: todas las acciones sobre Incidencia) */
    List<Auditoria> findByEntidadAndEntidadId(String entidad, String entidadId);
}
