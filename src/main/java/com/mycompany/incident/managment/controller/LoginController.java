package com.mycompany.incident.managment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

@Controller
public class LoginController {

    // ─── Auth ───────────────────────────────────────────────────────────────

    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String authenticate(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            Model model) {
        if ("admin".equals(username) && ("123".equals(password) || "admin".equals(password))) {
            // Credenciales válidas → redirige al shell SPA
            return "redirect:/app";
        }
        model.addAttribute("error", "Credenciales incorrectas de Agente.");
        return "login";
    }

    @GetMapping("/logout")
    public String logout() {
        return "redirect:/login";
    }

    // ─── SPA Shell ──────────────────────────────────────────────────────────

    /**
     * Sirve el shell principal de la SPA. El sidebar y el header
     * permanecen aquí; el contenido de cada módulo se inyecta vía JS.
     */
    @GetMapping("/app")
    public String app() {
        return "app";
    }

    // ─── Fragment Endpoints (AJAX) ───────────────────────────────────────────
    // Devuelven únicamente el fragmento HTML del módulo solicitado.
    // app.js los consume con fetch() y los inyecta en #spa-content.

    @GetMapping("/fragment/dashboard")
    public String fragmentDashboard() {
        return "dashboard-content";
    }

    @GetMapping("/fragment/incidencias")
    public String fragmentIncidencias() {
        return "incidencias-content";
    }

    @GetMapping("/fragment/reportes")
    public String fragmentReportes() {
        return "reportes-content";
    }

    @GetMapping("/fragment/camaras")
    public String fragmentCamaras() {
        return "camaras-content";
    }
}
