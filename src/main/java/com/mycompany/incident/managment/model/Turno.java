package com.mycompany.incident.managment.model;

import jakarta.persistence.*;

@Entity
@Table(name = "turnos")
public class Turno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String operator;

    private String status; // Activo, Programado

    @Column(name = "start_time")
    private String startTime; // Ej: 08:00 AM

    @Column(name = "end_time")
    private String endTime; // Ej: 16:00 PM

    // Constructors
    public Turno() {}

    public Turno(String operator, String status, String startTime, String endTime) {
        this.operator = operator;
        this.status = status;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
