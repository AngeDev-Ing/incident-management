package com.mycompany.incident.managment.model;

import jakarta.persistence.*;
import java.time.LocalDate;

/**
 * Turno de vigilancia asignado a un operador/usuario.
 * Relacionado con un Usuario real del sistema.
 */
@Entity
@Table(name = "turnos")
public class Turno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Usuario asignado a este turno (FK → usuarios) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    /**
     * Campo legacy de texto para el seeder inicial.
     * Usar `usuario` (FK) en implementaciones nuevas.
     */
    @Column(name = "operator_nombre")
    private String operator;

    /** Estado: Activo | Programado | Finalizado | Cancelado */
    @Column(nullable = false)
    private String status;

    /** Hora de inicio: "08:00 AM" */
    @Column(name = "start_time")
    private String startTime;

    /** Hora de fin: "16:00 PM" */
    @Column(name = "end_time")
    private String endTime;

    /** Fecha a la que aplica este turno */
    private LocalDate fecha;

    /** Zona de vigilancia asignada a este turno (FK → zonas) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "zona_id")
    private Zona zona;

    /** Notas adicionales del turno */
    @Column(columnDefinition = "TEXT")
    private String notas;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Turno() {}

    /** Constructor del seeder inicial (texto plano) */
    public Turno(String operator, String status, String startTime, String endTime) {
        this.operator = operator;
        this.status = status;
        this.startTime = startTime;
        this.endTime = endTime;
        this.fecha = LocalDate.now();
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public Zona getZona() { return zona; }
    public void setZona(Zona zona) { this.zona = zona; }

    public String getNotas() { return notas; }
    public void setNotas(String notas) { this.notas = notas; }
}
