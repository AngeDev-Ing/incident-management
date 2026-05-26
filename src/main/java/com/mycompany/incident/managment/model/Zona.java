package com.mycompany.incident.managment.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.util.List;

/**
 * Representa una zona o sector geográfico de vigilancia.
 * Una zona agrupa varias cámaras y puede tener varios turnos asignados.
 */
@Entity
@Table(name = "zonas")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Zona {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Nombre descriptivo: "Sector Norte", "Perímetro Puerto", etc. */
    @Column(nullable = false, unique = true)
    private String nombre;

    /** Descripción adicional de la zona */
    @Column(columnDefinition = "TEXT")
    private String descripcion;

    /** Estado operativo de la zona */
    private String status; // Activa, Inactiva, En revisión

    /** Cámaras que pertenecen a esta zona */
    @OneToMany(mappedBy = "zona", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Camara> camaras;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Zona() {}

    public Zona(String nombre, String descripcion, String status) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.status = status;
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<Camara> getCamaras() { return camaras; }
    public void setCamaras(List<Camara> camaras) { this.camaras = camaras; }
}

