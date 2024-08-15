/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Model.Student;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class StudentDAO1 {

    Connection conn;

    public StudentDAO1() throws ClassNotFoundException {
        try {
            conn = DB.DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT id, email, name, gender, birthday, phone_number, address, status\n"
                    + "  FROM [student]");
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Student addNew(Student student) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO [student] ([name], [email], [password], [gender], [birthday], [phone_number], [address], [status]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, "c4ca4238a0b923820dcc509a6f75849b");
            ps.setString(4, student.getGender());
            ps.setDate(5, student.getBirthday());
            ps.setString(6, student.getPhone_number());
            ps.setString(7, student.getAddress());
            ps.setBoolean(8, true);
            count = ps.executeUpdate();

            if (count > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int studentId = generatedKeys.getInt(1);

                    PreparedStatement psScore = conn.prepareStatement("INSERT INTO score (student_id, subject_id, scoreMouth, scoreShortExam, scoreMidSemester, scoreSemester, date, semester, school_year) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)");
                    for (int subjectId = 1; subjectId <= 10; subjectId++) {
                        psScore.setInt(1, studentId);
                        psScore.setInt(2, subjectId);
                        psScore.setNull(3, Types.FLOAT);
                        psScore.setNull(4, Types.FLOAT);
                        psScore.setNull(5, Types.FLOAT);
                        psScore.setNull(6, Types.FLOAT);
                        psScore.setDate(7, new java.sql.Date(System.currentTimeMillis()));
                        psScore.setInt(8, 1);
                          psScore.setInt(9, 2);
                        count += psScore.executeUpdate();
                    }
                    for (int subjectId = 1; subjectId <= 10; subjectId++) {
                        psScore.setInt(1, studentId);
                        psScore.setInt(2, subjectId);
                        psScore.setNull(3, Types.FLOAT);
                        psScore.setNull(4, Types.FLOAT);
                        psScore.setNull(5, Types.FLOAT);
                        psScore.setNull(6, Types.FLOAT);
                        psScore.setDate(7, new java.sql.Date(System.currentTimeMillis()));
                        psScore.setInt(8, 2); 
                        count += psScore.executeUpdate();
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count > 0) ? student : null;
    }

    public int checkDuplicate(Student student) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from student where student.email = ? or student.phone_number = ?");
            ps.setString(1, student.getEmail());
            ps.setString(2, student.getPhone_number());
            rs = ps.executeQuery();
            if (rs.next()) {
                String existingEmail = rs.getString("email");
                String existingEPhone = rs.getString("phone_number");
                if (existingEPhone.equals(student.getPhone_number()) && existingEmail.equalsIgnoreCase(student.getEmail())) {
                    return 3; //two
                } else if (existingEPhone.equals(student.getPhone_number())) {
                    return 1; // phone
                } else if (existingEmail.equalsIgnoreCase(student.getEmail())) {
                    return 2; //email
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
        public boolean updateStatus(int studentId, boolean status) {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [student]\n"
                    + "SET [status] = ? WHERE [id] = ?");
            ps.setBoolean(1, status);
            ps.setInt(2, studentId);
            int count = ps.executeUpdate();
            return count > 0;
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

}
