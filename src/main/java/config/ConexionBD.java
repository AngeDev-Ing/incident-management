/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author 2004r
 */
public class ConexionBD {

    public static Connection getConexion() {

        Connection cn = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            cn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/incidencias",
                    "root",
                    "1234"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cn;
    }
}