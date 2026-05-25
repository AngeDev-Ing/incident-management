package com.mycompany.incident.managment;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.env.Environment;
import io.github.cdimascio.dotenv.Dotenv;

@SpringBootApplication
public class IncidentManagementApplication {

    public static void main(String[] args) {
        Dotenv.configure().ignoreIfMissing().systemProperties().load();
        SpringApplication.run(IncidentManagementApplication.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onReady(ApplicationReadyEvent event) {
        Environment env = event.getApplicationContext().getEnvironment();
        String port = env.getProperty("server.port", "8080");
        System.out.println("\n=======================================================");
        System.out.println("  El servidor esta corriendo con exito!");
        System.out.println("  Accede aqui: http://localhost:" + port);
        System.out.println("=======================================================\n");
    }

}
