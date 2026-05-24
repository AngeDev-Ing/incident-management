package com.mycompany.incident.managment.model;

import jakarta.persistence.*;

@Entity
@Table(name = "camaras")
public class Camara {

    @Id
    private String id; // Ej: DS-CAM-8842

    @Column(nullable = false)
    private String name;

    private String location; // Ej: Zona A-1, Perímetro

    private String status; // Operativa, Inoperativa, Mantenimiento

    @Column(name = "image_url", length = 1000)
    private String imageUrl;

    // Constructors
    public Camara() {}

    public Camara(String id, String name, String location, String status, String imageUrl) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.status = status;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
