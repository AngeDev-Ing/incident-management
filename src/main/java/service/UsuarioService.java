/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.UsuarioDAO;
import dto.UsuarioDTO;

import java.util.List;

/**
 *
 * @author 2004r
 */
public class UsuarioService {

    UsuarioDAO dao = new UsuarioDAO();

    public List<UsuarioDTO> listarUsuarios() {

        return dao.listar();

    }

    public boolean registrarUsuario(UsuarioDTO u) {

        return dao.registrar(u);

    }

    public UsuarioDTO buscarUsuario(int id) {

        return dao.buscarPorId(id);

    }

    public boolean editarUsuario(UsuarioDTO u) {

        return dao.editar(u);

    }

    public boolean eliminarUsuario(int id) {

        return dao.eliminar(id);

    }
}