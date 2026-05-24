package com.mycompany.incident.managment;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;
import com.mycompany.incident.managment.model.*;
import com.mycompany.incident.managment.repository.*;
import java.time.LocalDate;

@SpringBootApplication
public class IncidentManagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(IncidentManagementApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(
            Environment env,
            UsuarioRepository usuarioRepo,
            CamaraRepository camaraRepo,
            IncidenciaRepository incidenciaRepo,
            TurnoRepository turnoRepo) {
        return args -> {
            String port = env.getProperty("server.port", "8080");
            System.out.println("\n=======================================================");
            System.out.println("El servidor está corriendo con éxito!");
            System.out.println("Accede aquí: http://localhost:" + port);
            System.out.println("=======================================================\n");

            // ─── Inicializar Usuario ───
            if (usuarioRepo.count() == 0) {
                usuarioRepo.save(new Usuario("admin", "123", "Administrador Sentinel", "Admin"));
                usuarioRepo.save(new Usuario("aris.cmd", "123", "Comandante Aris", "Supervisor"));
                System.out.println("-> Usuarios iniciales insertados en PostgreSQL.");
            }

            // ─── Inicializar Cámaras ───
            if (camaraRepo.count() == 0) {
                camaraRepo.save(new Camara("DS-CAM-8842", "Intersección Calle Real", "Zona A-1", "Operativa", 
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuC7CqVIYJvwY8Mj0jS6EimLdFQkkwP5aytxwXsxZ_hCLTCmBgow6GjAucBiTJikyAX8ZVFnOO8EgQLBV4BWmM_zvLBILhXknL1mQmyvOCTGYrVfUZ3sUF9-ouXMgphBzdllcYP927UOwrC7hNfHiLtdmHNb2rQf_3yYHwDMj8rgjdyHif2dJUXJDsfVC4jlktYuK5vp0oA_YoAMn4zLu2jrr41hVAYM69qBxC9z0fPO10kW1fxuGMExJvgnpepfmEu91fzGBOZ8DgFg"));
                camaraRepo.save(new Camara("DS-CAM-9011", "Entrada Principal Norte", "Perímetro", "Operativa", 
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuA2tyNRpa2xgFuByo8bVPPHg8vwbVnlEd7SqsbLqC-s3iKWu29hEL1DKuRl7CgT_iEzZiUIUt3xQOIToIn5Vwmo3WgCd0HzbwUUeAZbdfG5nzFNV4RYLd81qmQ-l93gqa6EXJtQL_w08KkjfbGx3d4UJYw9oD6Qu0ZG-a7FdZcmAlmzhml_WyT05eqtnJqSUfMq_IHy0lc2TkJFoHXAPmE06F13eq0zh5KUpUYaq-wi2cOJeOmgkmqWiKJA298Fut1LjsKQeegXZdwn"));
                camaraRepo.save(new Camara("DS-CAM-4421", "Callejón 4 - Sector C", "Zona C-4", "Inoperativa", ""));
                camaraRepo.save(new Camara("DS-CAM-1102", "Plaza de Armas S.", "Zona B-2", "Mantenimiento", 
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuA3jenfROXDYkWlwpEZQ4pXYFJxi8nj6B_jOcZilV4DvN2tr77YaSNBnKOmKxtWxCqlK3OWcnifbJBwRcEi11RyUAMX4EvrTHCvVHQlycTd3h6v8v1pl1W7jM0q2k7hcIqa2Yck4syIxyQSn0gbQ00l79zhPre2ZaDgDqcdwaj_9eQkiIzFEUHPmqjEGl9vxr14F4vYDjZxq9NYSD3_Cp8VqvBu_4J52F8PM972LWc9gFe7E46kp_AsnzI2lzq5coL4ne2X_di-gPTk"));
                System.out.println("-> Cámaras iniciales insertadas en PostgreSQL.");
            }

            // ─── Inicializar Incidencias ───
            if (incidenciaRepo.count() == 0) {
                incidenciaRepo.save(new Incidencia("Intrusión Perímetro Norte", "Intruso avistado intentando trepar la valla en sector noroeste.", LocalDate.now(), "14:20", "Robo", "R. Mendez", "Alejandro Morales", "DS-CAM-9011", "Pendiente"));
                incidenciaRepo.save(new Incidencia("Falla Sensor Cámara 04", "El feed de video se encuentra en negro de manera intermitente.", LocalDate.now(), "12:45", "Accidente", "A. Castillo", "Elena Castillo", "DS-CAM-4421", "En Proceso"));
                incidenciaRepo.save(new Incidencia("Acceso No Autorizado Nivel 2", "Tarjeta de acceso inválida detectada en el terminal de acceso del almacén.", LocalDate.now().minusDays(1), "23:10", "Sospechoso", "L. Figueroa", "Ricardo Jimenez", "DS-CAM-8842", "Resuelto"));
                incidenciaRepo.save(new Incidencia("Anomalía Térmica Sector B", "Se registra temperatura sobre 45°C en área de racks de telecomunicaciones.", LocalDate.now().minusDays(1), "18:30", "Accidente", "R. Mendez", "Alejandro Morales", "DS-CAM-1102", "Pendiente"));
                System.out.println("-> Incidencias iniciales insertadas en PostgreSQL.");
            }

            // ─── Inicializar Turnos ───
            if (turnoRepo.count() == 0) {
                turnoRepo.save(new Turno("Cmdr. Marcus Vance", "Activo", "08:00 AM", "16:00 PM"));
                turnoRepo.save(new Turno("Sgt. Lucía Ferreyra", "Programado", "16:00 PM", "00:00 AM"));
                turnoRepo.save(new Turno("Cpl. Daniel Ortega", "Programado", "00:00 AM", "08:00 AM"));
                System.out.println("-> Turnos iniciales insertados en PostgreSQL.");
            }
        };
    }
}
