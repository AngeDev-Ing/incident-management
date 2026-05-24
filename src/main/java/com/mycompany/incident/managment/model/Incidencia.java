package com.mycompany.incident.managment.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "incidencias")
public class Incidencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private LocalDate date;

    private String time; // Guardado como String "HH:mm:ss" o "HH:mm" para simplificar formateos

    private String type; // Robo, Sospechoso, Accidente, etc.

    private String supervisor;

    private String operator;

    private String camera;

    private String status; // Pendiente, En Proceso, Resuelto

    // Constructors
    public Incidencia() {}

    public Incidencia(String title, String description, LocalDate date, String time, String type, String supervisor, String operator, String camera, String status) {
        this.title = title;
        this.description = description;
        this.date = date;
        this.time = time;
        this.type = type;
        this.supervisor = supervisor;
        this.operator = operator;
        this.camera = camera;
        this.status = status;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(String supervisor) {
        this.supervisor = supervisor;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getCamera() {
        return camera;
    }

    public void setCamera(String camera) {
        this.camera = camera;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
