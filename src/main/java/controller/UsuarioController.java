/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dto.UsuarioDTO;
import service.UsuarioService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 *
 * @author 2004r
 */

@WebServlet("/usuarios")
public class UsuarioController extends HttpServlet {

    UsuarioService service = new UsuarioService();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null || accion.equals("listar")) {

            List<UsuarioDTO> lista = service.listarUsuarios();

            request.setAttribute("usuarios", lista);

            request.getRequestDispatcher("usuarios.jsp")
                    .forward(request, response);
        }

        if (accion != null && accion.equals("eliminar")) {

            int id = Integer.parseInt(request.getParameter("id"));

            service.eliminarUsuario(id);

            response.sendRedirect("usuarios");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");

        UsuarioDTO u = new UsuarioDTO();

        u.setNombre(nombre);
        u.setCorreo(correo);
        u.setPassword(password);
        u.setRol(rol);

        service.registrarUsuario(u);

        response.sendRedirect("usuarios");
    }
}
