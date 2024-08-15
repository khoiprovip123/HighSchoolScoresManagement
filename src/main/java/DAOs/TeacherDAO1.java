/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Model.Teacher1;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class TeacherDAO1 {

    Connection conn;

    public TeacherDAO1() throws ClassNotFoundException {
        try {
            conn = DB.DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from teacher");
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public boolean updateEntryPermission(int teacherId, boolean entryPermission) {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [teacher]\n"
                    + "SET [entry_permission] = ? WHERE [id] = ?");
            ps.setBoolean(1, entryPermission);
            ps.setInt(2, teacherId);
            int count = ps.executeUpdate();
            return count > 0;
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean updateStatus(int teacherId, boolean status) {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [teacher]\n"
                    + "SET [status] = ? WHERE [id] = ?");
            ps.setBoolean(1, status);
            ps.setInt(2, teacherId);
            int count = ps.executeUpdate();
            return count > 0;
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public void openAllEntryPermission() {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [teacher]\n"
                    + "SET [entry_permission] = 1\n"
                    + "WHERE [entry_permission] = 0");
            int count = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void offAllEntryPermission() {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [teacher]\n"
                    + "SET [entry_permission] = 0\n"
                    + "WHERE [entry_permission] = 1");
            int count = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Teacher1 addNew(Teacher1 newTeacher) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO [teacher] ( [phone_number], [email], [name], [gender], [birthday], [address], [status], [entry_permission],[password])\n"
                    + "VALUES (?,?,?,?,?,?,?,?,?)");
            ps.setString(1, newTeacher.getPhone());
            ps.setString(2, newTeacher.getEmail());
            ps.setString(3, newTeacher.getName());
            ps.setString(4, newTeacher.getGender());
            ps.setDate(5, newTeacher.getBirthday());
            ps.setString(6, newTeacher.getAddress());
            ps.setBoolean(7, true);
            ps.setBoolean(8, false);
            ps.setString(9, "c4ca4238a0b923820dcc509a6f75849b");
            count = ps.executeUpdate(); // tra ve so dong bi anh huong trong sql

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? null : newTeacher;

    }

    public int checkDuplicate(Teacher1 teacher) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from teacher where teacher.email = ? or teacher.phone_number = ?");
            ps.setString(1, teacher.getEmail());
            ps.setString(2, teacher.getPhone());
            rs = ps.executeQuery();
            if (rs.next()) {
                String existingEmail = rs.getString("email");
                String existingEPhone = rs.getString("phone_number");
                if (existingEPhone.equals(teacher.getPhone()) && existingEmail.equalsIgnoreCase(teacher.getEmail())) {
                    return 3; //two
                } else if (existingEPhone.equals(teacher.getPhone())) {
                    return 1; // phone
                } else if (existingEmail.equalsIgnoreCase(teacher.getEmail())) {
                    return 2; //email
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int checkDuplicateEdit(Teacher1 teacher) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from teacher where (teacher.email = ?  or teacher.phone_number = ?) and teacher.id != ?");
            ps.setString(1, teacher.getEmail());
            ps.setString(2, teacher.getPhone());
            ps.setInt(3, teacher.getId());
            rs = ps.executeQuery();
            if (rs.next()) {
                String existingEmail = rs.getString("email");
                String existingEPhone = rs.getString("phone_number");
                if (existingEPhone.equals(teacher.getPhone()) && existingEmail.equalsIgnoreCase(teacher.getEmail())) {
                    return 3; //two
                } else if (existingEPhone.equals(teacher.getPhone())) {
                    return 1; // phone
                } else if (existingEmail.equalsIgnoreCase(teacher.getEmail())) {
                    return 2; //email
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int editTeacher(Teacher1 editedTeacher) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE teacher SET phone_number = ?, email = ?, name = ?, gender = ?, birthday = ?, address = ? WHERE id = ?");
            ps.setString(1, editedTeacher.getPhone());
            ps.setString(2, editedTeacher.getEmail());
            ps.setString(3, editedTeacher.getName());
            ps.setString(4, editedTeacher.getGender());
            ps.setDate(5, editedTeacher.getBirthday());
            ps.setString(6, editedTeacher.getAddress());
            ps.setInt(7, editedTeacher.getId()); // assuming teacher_id is the primary key
            count = ps.executeUpdate(); // returns the number of rows affected in SQL

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? 0 : 1;
    }

    public Teacher1 getTeacher(int teacherId) {
        Teacher1 teacher = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM teacher WHERE id = ?");
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                String phone = rs.getString("phone_number");
                String email = rs.getString("email");
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                Date birthday = rs.getDate("birthday");
                String address = rs.getString("address");
                teacher = new Teacher1(teacherId, phone, email, name, gender, birthday, address);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return teacher;
    }
}
