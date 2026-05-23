package com.mycompany.incident.managment;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;

@SpringBootApplication
public class IncidentManagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(IncidentManagementApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(Environment env) {
        return args -> {
            String port = env.getProperty("server.port", "8080");
            System.out.println("\n=======================================================");
            System.out.println("El servidor está corriendo con éxito!");
            System.out.println("Accede aquí: http://localhost:" + port);
            System.out.println("=======================================================\n");
        };
    }
}
