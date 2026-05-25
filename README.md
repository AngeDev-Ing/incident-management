# Digital Sentinel - Incident Management System

![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.2.5-brightgreen?style=for-the-badge&logo=spring-boot)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supabase-blue?style=for-the-badge&logo=postgresql)
![JWT](https://img.shields.io/badge/Security-JWT-black?style=for-the-badge&logo=json-web-tokens)
![Bootstrap](https://img.shields.io/badge/UI-Bootstrap_5-purple?style=for-the-badge&logo=bootstrap)

Digital Sentinel es una plataforma avanzada de Centro de Control y Comando diseñada para la monitorización en tiempo real, gestión de incidencias de seguridad y administración del estado de cámaras de vigilancia. 

El sistema utiliza una arquitectura híbrida (**SPA Frontend con JSP Fragments**) protegida por autenticación Stateless (**JWT**) a través de **Spring Security**.

---

## Módulos Principales

*   **Panel Principal (Dashboard):** Vista general con métricas en vivo sobre incidencias activas.
*   **Gestión de Incidencias:** CRUD y seguimiento de eventos (Robos, Accidentes, Sospechosos, etc.) con sus niveles de riesgo.
*   **Reportes:** Generación de estadísticas y analíticas de los incidentes categorizados.
*   **Cámaras de Seguridad:** Monitorización del parque de cámaras y asignación de turnos de vigilancia.

---

## Arquitectura Técnica

*   **Backend:** Spring Boot 3.2.5 (MVC).
*   **Seguridad:** Spring Security con JSON Web Tokens (JWT) Stateless y BCrypt para encriptación.
*   **Persistencia:** Spring Data JPA / Hibernate conectado a PostgreSQL remoto (Supabase).
*   **Frontend:** Vanilla JavaScript implementando un enrutador SPA personalizado que consume fragmentos HTML vía AJAX. Estilizado con Bootstrap 5 y variables de CSS nativas.

---

## Guía de Instalación y Despliegue

### 1. Prerrequisitos
*   Java Development Kit (JDK) 17 o superior.
*   Maven instalado.
*   Una base de datos PostgreSQL (El proyecto actualmente usa Supabase).

### 2. Clonar el repositorio
```bash
git clone <url-del-repositorio>
cd incident-management
```

### 3. Configurar Variables de Entorno
Por motivos de seguridad, las credenciales no se suben al repositorio. Debes crear un archivo `.env` en la raíz del proyecto.
Copia el archivo de ejemplo:
```bash
cp .env.example .env
```
Y rellena tus credenciales reales en el `.env`:
```env
DB_URL=jdbc:postgresql://tu-host:5432/postgres?sslmode=require
DB_USERNAME=postgres
DB_PASSWORD=tu-password-super-seguro
JWT_SECRET=LlaveSuperSecreta-Meow:3
JWT_EXPIRATION=86400000
```

### 4. Ejecutar la Aplicación
Con Maven Wrapper:
```bash
mvn spring-boot:run
```
La aplicación estará disponible en `http://localhost:8080`.

### 5. Acceso Inicial
Las contraseñas en la base de datos se migran automáticamente a `BCrypt` en el primer arranque. 
*   **Usuario por defecto:** `admin`
*   **Contraseña:** `123` *(Se encriptará sola en la BD al arrancar)*

---

## Flujo de Colaboración (Ramas)
Para trabajar en este proyecto de forma concurrente, seguimos estas directrices:
1. Nunca hacer commits directos a `main`.
2. Crear una rama independiente para cada feature: `git checkout -b feature/nombre-del-modulo`.
3. Al finalizar, confirmar que el código no rompe la construcción y realizar un Pull Request o Merge supervisado.

---
*Digital Sentinel - Operaciones de Nivel 4*
