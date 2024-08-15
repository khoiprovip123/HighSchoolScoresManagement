/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.Student;
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
public class StudentDAO {

    Connection conn;

    public StudentDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean existAccount(String phone_number, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from student Where phone_number = ? AND password = ? and status =?");
            ps.setString(1, phone_number);
            ps.setString(2, password);
            ps.setString(3, "true");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Student updatePasswordStudent(String username, String newPassword) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE student SET password = ? WHERE phone_number = ?");
            ps.setString(1, newPassword);
            ps.setString(2, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : new Student(); // hoặc return null;

    }

    public Student getInfostudent(String phone_number) {
        Student acc = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from student where phone_number =?");
            ps.setString(1, phone_number);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                acc = new Student(rs.getInt("id"), rs.getString("email"), rs.getString("password"), rs.getString("name"), rs.getString("gender"), rs.getDate("birthday"), rs.getString("phone_number"), rs.getString("address"), rs.getString("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;
    }

    public ResultSet getAllStudent(String phone_number) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from student s join parents on s.id = student_id  where s.phone_number = ?");
            ps.setString(1, phone_number);
            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs != null ? rs : null;
    }

    public Student updateStudent(int id, Student newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE student SET phone_number =? , email = ?,  name = ?, gender = ?, birthday = ?, address = ?, status =? WHERE id =?;");
            ps.setString(1, newInfo.getPhone_number());
            ps.setString(2, newInfo.getEmail());
            ps.setString(3, newInfo.getName());
            ps.setString(4, newInfo.getGender());
            ps.setDate(5, newInfo.getBirthday());
            ps.setString(6, newInfo.getAddress());
            ps.setString(7, newInfo.getStatus());
            ps.setInt(8, id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count == 0 ? null : newInfo;
    }

    public boolean checkSDTStudent(String phone_number) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from student where phone_number =?");
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

    public ResultSet getClassByPhoneNumber(String phoneNumber) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct student.id as student_id, class_id, school_year.id as school_id, school_year.name from student \n"
                    + "join studying on studying.student_id = student.id\n"
                    + "join school_year on studying.school_year = school_year.id\n"
                    + "where phone_number = ?");
            ps.setString(1, phoneNumber);
            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getScoreStudent(int student_id, int schoolYear_id, int subject_id, int semester_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct student_id, scoreMouth, scoreShortExam, scoreMidSemester, scoreSemester\n"
                    + "from score \n"
                    + "where score.student_id = ? and score.school_year = ? and subject_id = ? and score.semester = ?");
            ps.setInt(1, student_id);
            ps.setInt(2, schoolYear_id);
            ps.setInt(3, subject_id);
            ps.setInt(4, semester_id);

            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public String getConduct(String classes, int student_id, int school_year) {
        ResultSet rs = null;
        String result = "";
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct conduct from studying where student_id = ? and class_id = ? and school_year =?");
            ps.setInt(1, student_id);
            ps.setString(2, classes);
            ps.setInt(3, school_year);

            rs = ps.executeQuery();

            while (rs.next()) {
                result = rs.getString("conduct");
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean checkEmailStudent(String email, int id) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from student where email =? and id != ?");
            ps.setString(1, email);
            ps.setInt(2, id);
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
