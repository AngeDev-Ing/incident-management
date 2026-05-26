package com.mycompany.incident.managment.service;

import com.mycompany.incident.managment.dto.CamaraDTO;
import com.mycompany.incident.managment.model.Camara;
import com.mycompany.incident.managment.repository.CamaraRepository;
import com.mycompany.incident.managment.repository.ZonaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CamaraService {

    private final CamaraRepository camaraRepo;
    private final ZonaRepository zonaRepo;

    public CamaraService(CamaraRepository camaraRepo, ZonaRepository zonaRepo) {
        this.camaraRepo = camaraRepo;
        this.zonaRepo = zonaRepo;
    }

    public List<Camara> obtenerTodas() {
        return camaraRepo.findAll();
    }

    public void guardarCamara(CamaraDTO dto) throws Exception {
        Camara camara = camaraRepo.findById(dto.getId()).orElse(new Camara());
        camara.setId(dto.getId());
        camara.setName(dto.getName());
        camara.setLocation(dto.getLocation());
        camara.setStatus(dto.getStatus());
        camara.setIpAddress((dto.getIpAddress() != null && !dto.getIpAddress().isBlank()) ? dto.getIpAddress() : null);

        if (dto.getZonaId() != null && !dto.getZonaId().isBlank() && !dto.getZonaId().equals("null")) {
            try {
                Long zonaIdLong = Long.parseLong(dto.getZonaId());
                zonaRepo.findById(zonaIdLong).ifPresent(camara::setZona);
            } catch (NumberFormatException ignored) {
                camara.setZona(null);
            }
        } else {
            camara.setZona(null);
        }

        if (camara.getImageUrl() == null || camara.getImageUrl().isEmpty()) {
            camara.setImageUrl("https://placehold.co/600x400/212529/FFFFFF?text=" + dto.getId());
        }

        camaraRepo.save(camara);
    }

    public void eliminarCamara(String id) {
        camaraRepo.deleteById(id);
    }
}
