package com.mycompany.incident.managment.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Incidencia de seguridad registrada en el sistema.
 * Relacionada con la Cámara que la detectó, el Usuario supervisor
 * y el Usuario operador que la gestiona.
 */
@Entity
@Table(name = "incidencias")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Incidencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Título breve de la incidencia */
    @Column(nullable = false)
    private String title;

    /** Descripción detallada */
    @Column(columnDefinition = "TEXT")
    private String description;

    /** Fecha en que ocurrió */
    @Column(nullable = false)
    private LocalDate date;

    /** Hora en formato HH:mm */
    private String time;

    /** Tipo: Robo | Sospechoso | Accidente | Infraestructura | Mantenimiento */
    private String type;

    /** Nivel de prioridad: Baja | Media | Alta | Crítica */
    private String priority;

    /** Estado: Pendiente | En Proceso | Resuelto | Cerrado */
    private String status;

    /** Supervisor responsable (FK → usuarios) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "supervisor_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Usuario supervisorUsuario;

    /** Operador que atiende la incidencia (FK → usuarios) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "operador_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Usuario operadorUsuario;

    /** Cámara que detectó la incidencia (FK → camaras) */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "camara_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Camara camara;

    /** Evidencias multimedia adjuntas */
    @OneToMany(mappedBy = "incidencia", fetch = FetchType.LAZY,
               cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<Evidencia> evidencias;

    /** Notificaciones generadas por esta incidencia */
    @OneToMany(mappedBy = "incidencia", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Notificacion> notificaciones;

    /** Cuándo se creó el registro en el sistema */
    @Column(name = "creado_en")
    private LocalDateTime creadoEn;

    /** Cuándo se resolvió (null si aún está abierta) */
    @Column(name = "resuelto_en")
    private LocalDateTime resueltoEn;

    // Campos legacy de texto (para compatibilidad con el seeder existente)
    @Column(name = "supervisor_nombre")
    private String supervisor;

    @Column(name = "operador_nombre")
    private String operator;

    @Column(name = "camara_nombre")
    private String camera;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Incidencia() {}

    /** Constructor del seeder inicial (texto plano) */
    public Incidencia(String title, String description, LocalDate date,
                      String time, String type, String supervisor,
                      String operator, String camera, String status) {
        this.title = title;
        this.description = description;
        this.date = date;
        this.time = time;
        this.type = type;
        this.supervisor = supervisor;
        this.operator = operator;
        this.camera = camera;
        this.status = status;
        this.priority = "Media";
        this.creadoEn = LocalDateTime.now();
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Usuario getSupervisorUsuario() { return supervisorUsuario; }
    public void setSupervisorUsuario(Usuario supervisorUsuario) { this.supervisorUsuario = supervisorUsuario; }

    public Usuario getOperadorUsuario() { return operadorUsuario; }
    public void setOperadorUsuario(Usuario operadorUsuario) { this.operadorUsuario = operadorUsuario; }

    public Camara getCamara() { return camara; }
    public void setCamara(Camara camara) { this.camara = camara; }

    public List<Evidencia> getEvidencias() { return evidencias; }
    public void setEvidencias(List<Evidencia> evidencias) { this.evidencias = evidencias; }

    public List<Notificacion> getNotificaciones() { return notificaciones; }
    public void setNotificaciones(List<Notificacion> notificaciones) { this.notificaciones = notificaciones; }

    public LocalDateTime getCreadoEn() { return creadoEn; }
    public void setCreadoEn(LocalDateTime creadoEn) { this.creadoEn = creadoEn; }

    public LocalDateTime getResueltoEn() { return resueltoEn; }
    public void setResueltoEn(LocalDateTime resueltoEn) { this.resueltoEn = resueltoEn; }

    public String getSupervisor() { return supervisor; }
    public void setSupervisor(String supervisor) { this.supervisor = supervisor; }

    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }

    public String getCamera() { return camera; }
    public void setCamera(String camera) { this.camera = camera; }
}
