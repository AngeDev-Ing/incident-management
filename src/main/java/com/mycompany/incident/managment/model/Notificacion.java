package com.mycompany.incident.managment.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Notificación generada automáticamente por el sistema
 * cuando ocurre un evento relevante (nueva incidencia, cambio de estado, etc.).
 */
@Entity
@Table(name = "notificaciones")
public class Notificacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Usuario destinatario de esta notificación */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    /** Incidencia relacionada (opcional) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "incidencia_id")
    private Incidencia incidencia;

    /** Tipo: ALERTA, INFO, ADVERTENCIA */
    @Column(nullable = false)
    private String tipo;

    /** Mensaje breve de la notificación */
    @Column(nullable = false)
    private String mensaje;

    /** Si el usuario ya leyó la notificación */
    @Column(nullable = false)
    private boolean leida = false;

    /** Cuándo se creó */
    @Column(name = "creada_en", nullable = false)
    private LocalDateTime creadaEn;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Notificacion() {}

    public Notificacion(Usuario usuario, Incidencia incidencia,
                        String tipo, String mensaje) {
        this.usuario = usuario;
        this.incidencia = incidencia;
        this.tipo = tipo;
        this.mensaje = mensaje;
        this.leida = false;
        this.creadaEn = LocalDateTime.now();
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public Incidencia getIncidencia() { return incidencia; }
    public void setIncidencia(Incidencia incidencia) { this.incidencia = incidencia; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }

    public boolean isLeida() { return leida; }
    public void setLeida(boolean leida) { this.leida = leida; }

    public LocalDateTime getCreadaEn() { return creadaEn; }
    public void setCreadaEn(LocalDateTime creadaEn) { this.creadaEn = creadaEn; }
}
