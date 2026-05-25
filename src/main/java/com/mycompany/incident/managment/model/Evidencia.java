package com.mycompany.incident.managment.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Evidencia multimedia (foto, video, documento) asociada a una Incidencia.
 */
@Entity
@Table(name = "evidencias")
public class Evidencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Incidencia a la que pertenece esta evidencia */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "incidencia_id", nullable = false)
    private Incidencia incidencia;

    /** Tipo de archivo: FOTO, VIDEO, DOCUMENTO */
    @Column(nullable = false)
    private String tipo;

    /** URL o ruta donde está almacenado el archivo */
    @Column(name = "url", length = 1000, nullable = false)
    private String url;

    /** Descripción de la evidencia */
    private String descripcion;

    /** Fecha y hora en que se subió la evidencia */
    @Column(name = "subido_en", nullable = false)
    private LocalDateTime subidoEn;

    /** Usuario que subió la evidencia */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subido_por_id")
    private Usuario subidoPor;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Evidencia() {}

    public Evidencia(Incidencia incidencia, String tipo, String url,
                     String descripcion, Usuario subidoPor) {
        this.incidencia = incidencia;
        this.tipo = tipo;
        this.url = url;
        this.descripcion = descripcion;
        this.subidoPor = subidoPor;
        this.subidoEn = LocalDateTime.now();
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Incidencia getIncidencia() { return incidencia; }
    public void setIncidencia(Incidencia incidencia) { this.incidencia = incidencia; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public LocalDateTime getSubidoEn() { return subidoEn; }
    public void setSubidoEn(LocalDateTime subidoEn) { this.subidoEn = subidoEn; }

    public Usuario getSubidoPor() { return subidoPor; }
    public void setSubidoPor(Usuario subidoPor) { this.subidoPor = subidoPor; }
}
