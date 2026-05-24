package com.mycompany.incident.managment.repository;

import com.mycompany.incident.managment.model.Turno;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TurnoRepository extends JpaRepository<Turno, Long> {
}
