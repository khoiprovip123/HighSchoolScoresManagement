/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class ClassDAO {

    Connection conn;

    public ClassDAO() throws ClassNotFoundException {
        try {
            conn = DB.DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select class_id as id,grade, teaching.homeroom from class join teaching on class.id = teaching.class_id where homeroom != '' group by class_id,grade, homeroom");
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllTeacherNotHoomroom() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("  SELECT id, teacher.name \n"
                    + "FROM teacher \n"
                    + "WHERE id NOT IN (\n"
                    + "    SELECT teacher_id \n"
                    + "    FROM teaching \n"
                    + "    WHERE homeroom != ''\n"
                    + ");");
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

}
