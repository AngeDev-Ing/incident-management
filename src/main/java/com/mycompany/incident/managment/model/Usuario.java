package com.mycompany.incident.managment.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Usuario del sistema Digital Sentinel.
 * Puede ser Admin, Supervisor u Operador.
 */
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Nombre de usuario único para el login */
    @Column(nullable = false, unique = true)
    private String username;

    /** Contraseña (en producción debe estar hasheada con BCrypt) */
    @Column(nullable = false)
    private String password;

    /** Nombre completo visible en la UI */
    @Column(name = "full_name")
    private String fullName;

    /** Rol del usuario: Admin | Supervisor | Operador */
    private String role;

    /** Email de contacto */
    @Column(unique = true)
    private String email;

    /** Teléfono de contacto */
    private String telefono;

    /** Estado de la cuenta: Activo | Inactivo | Suspendido */
    @Column(nullable = false)
    private String status = "Activo";

    /** URL del avatar/foto de perfil */
    @Column(name = "avatar_url", length = 1000)
    private String avatarUrl;

    /** Último login registrado */
    @Column(name = "ultimo_login")
    private LocalDateTime ultimoLogin;

    /** Fecha de creación de la cuenta */
    @Column(name = "creado_en")
    private LocalDateTime creadoEn;

    /** Incidencias que supervisa este usuario */
    @OneToMany(mappedBy = "supervisorUsuario", fetch = FetchType.LAZY)
    private List<Incidencia> incidenciasSupervisa;

    /** Incidencias que opera/atiende este usuario */
    @OneToMany(mappedBy = "operadorUsuario", fetch = FetchType.LAZY)
    private List<Incidencia> incidenciasOpera;

    /** Turnos asignados */
    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY)
    private List<Turno> turnos;

    // ─── Constructors ────────────────────────────────────────────────────────
    public Usuario() {}

    /** Constructor básico para el seeder inicial */
    public Usuario(String username, String password, String fullName, String role) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
        this.status = "Activo";
        this.creadoEn = LocalDateTime.now();
    }

    // ─── Getters & Setters ───────────────────────────────────────────────────
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }

    public LocalDateTime getUltimoLogin() { return ultimoLogin; }
    public void setUltimoLogin(LocalDateTime ultimoLogin) { this.ultimoLogin = ultimoLogin; }

    public LocalDateTime getCreadoEn() { return creadoEn; }
    public void setCreadoEn(LocalDateTime creadoEn) { this.creadoEn = creadoEn; }

    public List<Incidencia> getIncidenciasSupervisa() { return incidenciasSupervisa; }
    public void setIncidenciasSupervisa(List<Incidencia> incidenciasSupervisa) { this.incidenciasSupervisa = incidenciasSupervisa; }

    public List<Incidencia> getIncidenciasOpera() { return incidenciasOpera; }
    public void setIncidenciasOpera(List<Incidencia> incidenciasOpera) { this.incidenciasOpera = incidenciasOpera; }

    public List<Turno> getTurnos() { return turnos; }
    public void setTurnos(List<Turno> turnos) { this.turnos = turnos; }
}
