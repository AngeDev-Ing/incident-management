package com.mycompany.incident.managment.repository;

import com.mycompany.incident.managment.model.Camara;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CamaraRepository extends JpaRepository<Camara, String> {
}
