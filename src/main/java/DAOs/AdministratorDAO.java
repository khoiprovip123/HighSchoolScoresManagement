/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.Administrator;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class AdministratorDAO {

    Connection conn;

    public AdministratorDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean existAccount(String phone_number, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from adminstrator Where phone_number = ? AND password = ?");
            ps.setString(1, phone_number);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

//        public boolean existPass( String password) {
//        try {
//            PreparedStatement ps = conn.prepareStatement("Select * from adminstrator Where  password = ?");
//            ps.setString(2, password);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return true;
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
    public Administrator updatePasswordAdmin(String username, String newPassword) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE adminstrator SET password = ? WHERE phone_number = ?");
            ps.setString(1, newPassword);
            ps.setString(2, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : new Administrator(); // hoặc return null;

    }

    public Administrator getInfo(String phone_number) {
        Administrator acc = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from adminstrator where phone_number =?");
            ps.setString(1, phone_number);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                acc = new Administrator(rs.getString("phone_number"), rs.getString("email"), rs.getString("password"), rs.getString("name"), rs.getString("gender"), rs.getDate("birthday"), rs.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;
    }

    public ResultSet getAll(String phone_number) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from adminstrator where phone_number=?");
            ps.setString(1, phone_number);
            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs != null ? rs : null;
    }

    public Administrator updateAdmin(String phone_number, Administrator newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE adminstrator SET phone_number = ?,email = ?,name = ?, gender = ?, birthday = ?,address = ? WHERE phone_number = ?;");
            ps.setString(1, newInfo.getPhone_number());
            ps.setString(2, newInfo.getEmail());
            ps.setString(3, newInfo.getName());
            ps.setString(4, newInfo.getGender());
            ps.setDate(5, newInfo.getBirthday());
            ps.setString(6, newInfo.getAddress());
            ps.setString(7, phone_number);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count == 0 ? null : newInfo;
    }

    public boolean checkEmailAdmin(String email, String phone_number) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from adminstrator where email =? and phone_number !=?");
            ps.setString(1, email);
            ps.setString(1, phone_number);

            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public boolean checkSDAdmin(String phone_number) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from adminstrator where phone_number =?");
            ps.setString(1, phone_number);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
