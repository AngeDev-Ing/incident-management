package com.mycompany.incident.managment.dto;

public class CamaraDTO {
    private String id;
    private String name;
    private String location;
    private String status;
    private String zonaId;
    private String ipAddress;

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getZonaId() { return zonaId; }
    public void setZonaId(String zonaId) { this.zonaId = zonaId; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
}
