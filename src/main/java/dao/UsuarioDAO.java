/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConexionBD;
import dto.UsuarioDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author 2004r
 */
public class UsuarioDAO {

    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    // LISTAR
    public List<UsuarioDTO> listar() {

        List<UsuarioDTO> lista = new ArrayList<>();

        try {

            cn = ConexionBD.getConexion();

            String sql = "SELECT * FROM usuarios";

            ps = cn.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                UsuarioDTO u = new UsuarioDTO();

                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
                u.setRol(rs.getString("rol"));

                lista.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    // REGISTRAR
    public boolean registrar(UsuarioDTO u) {

        try {

            cn = ConexionBD.getConexion();

            String sql = "INSERT INTO usuarios(nombre,correo,password,rol) VALUES(?,?,?,?)";

            ps = cn.prepareStatement(sql);

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getCorreo());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // BUSCAR POR ID
    public UsuarioDTO buscarPorId(int id) {

        UsuarioDTO u = new UsuarioDTO();

        try {

            cn = ConexionBD.getConexion();

            String sql = "SELECT * FROM usuarios WHERE id=?";

            ps = cn.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {

                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
                u.setRol(rs.getString("rol"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return u;
    }

    // EDITAR
    public boolean editar(UsuarioDTO u) {

        try {

            cn = ConexionBD.getConexion();

            String sql = "UPDATE usuarios SET nombre=?, correo=?, password=?, rol=? WHERE id=?";

            ps = cn.prepareStatement(sql);

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getCorreo());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());
            ps.setInt(5, u.getId());

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ELIMINAR
    public boolean eliminar(int id) {

        try {

            cn = ConexionBD.getConexion();

            String sql = "DELETE FROM usuarios WHERE id=?";

            ps = cn.prepareStatement(sql);

            ps.setInt(1, id);

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
