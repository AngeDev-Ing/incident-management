package com.mycompany.incident.managment.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Registro inmutable de cada acción realizada en el sistema.
 * Permite rastrear quién hizo qué y cuándo. No se debe editar ni borrar.
 */
@Entity
@Table(name = "auditoria")
public class Auditoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Usuario que realizó la acción */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    /**
     * Acción realizada: LOGIN, LOGOUT, CREAR_INCIDENCIA,
     * ACTUALIZAR_INCIDENCIA, RESOLVER_INCIDENCIA, CREAR_USUARIO, etc.
     */
    @Column(nullable = false)
    private String accion;

    /** Entidad afectada: Incidencia, Camara, Usuario, etc. */
    private String entidad;

    /** ID del registro afectado */
    @Column(name = "entidad_id")
    private String entidadId;

    /** Descripción legible de lo ocurrido */
    @Column(columnDefinition = "TEXT")
    private String detalle;

    /** Dirección IP desde donde se realizó la acción */
    @Column(name = "ip_origen")
    private String ipOrigen;

    /** Fecha y hora exacta de la acción */
    @Column(name = "realizado_en", nullable = false)
    private LocalDateTime realizadoEn;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Auditoria() {}

    public Auditoria(Usuario usuario, String accion, String entidad,
                     String entidadId, String detalle, String ipOrigen) {
        this.usuario = usuario;
        this.accion = accion;
        this.entidad = entidad;
        this.entidadId = entidadId;
        this.detalle = detalle;
        this.ipOrigen = ipOrigen;
        this.realizadoEn = LocalDateTime.now();
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public String getAccion() { return accion; }
    public void setAccion(String accion) { this.accion = accion; }

    public String getEntidad() { return entidad; }
    public void setEntidad(String entidad) { this.entidad = entidad; }

    public String getEntidadId() { return entidadId; }
    public void setEntidadId(String entidadId) { this.entidadId = entidadId; }

    public String getDetalle() { return detalle; }
    public void setDetalle(String detalle) { this.detalle = detalle; }

    public String getIpOrigen() { return ipOrigen; }
    public void setIpOrigen(String ipOrigen) { this.ipOrigen = ipOrigen; }

    public LocalDateTime getRealizadoEn() { return realizadoEn; }
    public void setRealizadoEn(LocalDateTime realizadoEn) { this.realizadoEn = realizadoEn; }
}
