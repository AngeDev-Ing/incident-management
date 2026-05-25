package com.mycompany.incident.managment.controller;

import com.mycompany.incident.managment.config.JwtUtil;
import com.mycompany.incident.managment.dto.LoginRequest;
import com.mycompany.incident.managment.model.Usuario;
import com.mycompany.incident.managment.repository.UsuarioRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthController(UsuarioRepository usuarioRepository,
                          PasswordEncoder passwordEncoder,
                          JwtUtil jwtUtil) {
        this.usuarioRepository = usuarioRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody LoginRequest request) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(request.getUsername());

        if (usuarioOpt.isPresent() &&
                passwordEncoder.matches(request.getPassword(), usuarioOpt.get().getPassword())) {

            String token = jwtUtil.generateToken(request.getUsername());
            return ResponseEntity.ok(Map.of(
                    "token", token,
                    "username", usuarioOpt.get().getUsername()
            ));
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("error", "Credenciales incorrectas. Verifique sus datos."));
    }
}
