package com.mycompany.incident.managment.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

/**
 * Cámara de vigilancia del sistema Digital Sentinel.
 * Pertenece a una Zona y puede estar asociada a múltiples Incidencias.
 */
@Entity
@Table(name = "camaras")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Camara {

    @Id
    private String id; // Ej: DS-CAM-8842 (código propio del hardware)

    @Column(nullable = false)
    private String name;

    /** Ubicación textual interna: "Intersección Calle Real" */
    private String location;

    /** Estado actual: Operativa | Inoperativa | Mantenimiento */
    private String status;

    /** URL de la imagen de previsualización de la cámara */
    @Column(name = "image_url", length = 1000)
    private String imageUrl;

    /** Zona geográfica a la que pertenece (FK → zonas) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "zona_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Zona zona;

    /** Modelo del dispositivo, ej: "Hikvision DS-2CD2143G2-I" */
    private String modelo;

    /** Dirección IP de la cámara en la red interna */
    @Column(name = "ip_address")
    private String ipAddress;

    /** Fecha de instalación (texto, ej: "2024-01") */
    @Column(name = "fecha_instalacion")
    private String fechaInstalacion;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Camara() {}

    /** Constructor básico para el seeder inicial */
    public Camara(String id, String name, String location,
                  String status, String imageUrl) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.status = status;
        this.imageUrl = imageUrl;
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Zona getZona() { return zona; }
    public void setZona(Zona zona) { this.zona = zona; }

    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public String getFechaInstalacion() { return fechaInstalacion; }
    public void setFechaInstalacion(String fechaInstalacion) { this.fechaInstalacion = fechaInstalacion; }
}

