package com.mycompany.incident.managment.repository;

import com.mycompany.incident.managment.model.Notificacion;
import com.mycompany.incident.managment.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface NotificacionRepository extends JpaRepository<Notificacion, Long> {
    /** Todas las notificaciones de un usuario ordenadas por fecha descendente */
    List<Notificacion> findByUsuarioOrderByCreadaEnDesc(Usuario usuario);

    /** Solo las no leídas de un usuario */
    List<Notificacion> findByUsuarioAndLeidaFalse(Usuario usuario);

    /** Conteo de no leídas (para el badge del header) */
    long countByUsuarioAndLeidaFalse(Usuario usuario);
}
