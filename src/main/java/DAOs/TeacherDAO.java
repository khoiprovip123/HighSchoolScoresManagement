/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.Parents;
import Model.Student;
import Model.Teacher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class TeacherDAO {

    Connection conn;

    public TeacherDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean existAccount(String phone_number, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from teacher Where phone_number = ? AND password = ? ");
            ps.setString(1, phone_number);
            ps.setString(2, password);
            //   ps.setBoolean(3, true);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Teacher updatePasswordTeacher(String username, String newPassword) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE teacher SET password = ? WHERE phone_number = ?");
            ps.setString(1, newPassword);
            ps.setString(2, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : new Teacher(); // hoặc return null;
    }

    public Teacher updateTeacher(int id, Teacher newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE teacher SET phone_number =? , email = ?,  name = ?, gender = ?, birthday = ?, address = ?, status =? WHERE id =?;");
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

    public Teacher getInfoteacher(String phone_number) {
        Teacher acc = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from teacher where phone_number =?");
            ps.setString(1, phone_number);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                acc = new Teacher(rs.getInt("id"), rs.getString("email"), rs.getString("password"), rs.getString("name"), rs.getString("gender"), rs.getDate("birthday"), rs.getString("phone_number"), rs.getString("address"), rs.getString("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;
    }

    public ResultSet getAllTeacher(String phone_number) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from teacher where phone_number=?");
            ps.setString(1, phone_number);
            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs != null ? rs : null;
    }

    public boolean checkSDTeacher(String phone_number) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from teacher where phone_number =?");
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

    public ResultSet getAllClass() {
        ResultSet rs = null;

        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select distinct class.id as id, school_year, name  from class\n"
                    + "join teaching on class.id = teaching.class_id\n"
                    + "join school_year on teaching.school_year = school_year.id\n"
                    + "where school_year in (\n"
                    + "select top 1 id from school_year order by id desc\n"
                    + ")\n"
                    + "order by class.id");
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getAllSubject() {
        ResultSet rs = null;

        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from subject order by id");
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getAllSemester() {
        ResultSet rs = null;

        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from semester");
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public String getTeacherNameById(int id) {
        ResultSet rs = null;
        String name = "";

        try {
            PreparedStatement ps = conn.prepareStatement("select name from teacher where id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                name = rs.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return name;
    }

    public int getTeacherByPhoneNumber(String phoneNumber) {
        ResultSet rs = null;
        int id = 0;

        try {
            PreparedStatement ps = conn.prepareStatement("select id from teacher where phone_number = ?");
            ps.setString(1, phoneNumber);
            rs = ps.executeQuery();
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return id;
    }

    public boolean getTeacherByClassAndSubject(String classes, int subject_id, int id, int schoolYear_id) {
        ResultSet rs = null;
        int newId = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("select teacher_id from teaching where class_id = ? and subject_id = ? and school_year = ?");
            ps.setString(1, classes);
            ps.setInt(2, subject_id);
            ps.setInt(3, schoolYear_id);

            rs = ps.executeQuery();
            while (rs.next()) {
                newId = rs.getInt(1);
            }
            if (newId == id) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public ResultSet getStudent(String nameClass) {
        ResultSet rs = null;
        String classes = nameClass.split(" ")[0];
        int schoolYear = Integer.parseInt(nameClass.split(" ")[1]);
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT DISTINCT  student_id, student.phone_number, student.name, student.birthday\n"
                    + "from studying\n"
                    + "JOIN student ON student.id = studying.student_id\n"
                    + "WHERE studying.class_id = ? AND  studying.school_year = ?");

            ps.setString(1, classes);
            ps.setInt(2, schoolYear);

            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs != null ? rs : null;
    }

    public ResultSet getScoreByStudent2(int student_id, int subject_id, int semester_id, int school_year) {
        ResultSet rs = null;

        try {
            PreparedStatement ps = conn.prepareStatement("select * from score "
                    + "where student_id = ? and subject_id = ? and semester = ? and school_year = ?");

            ps.setInt(1, student_id);
            ps.setInt(2, subject_id);
            ps.setInt(3, semester_id);
            ps.setInt(4, school_year);

            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs != null ? rs : null;
    }

    public ResultSet getStudentInClass(String nameClass) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct id, phone_number, name, birthday, email, gender, [address], [status] from studying\n"
                    + "join student on id =student_id\n"
                    + "where class_id = ?");

            ps.setString(1, nameClass);

            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs != null ? rs : null;
    }

    public ResultSet getScoreByStudent(int student_id, int subject_id, int semester_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT DISTINCT  student_id, scoreMouth, scoreShortExam, scoreMidSemester, scoreSemester\n"
                    + "from score\n"
                    + "WHERE student_id =? and score.subject_id = ? AND score.semester = ?");

            ps.setInt(1, student_id);
            ps.setInt(2, subject_id);
            ps.setInt(3, semester_id);

            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs != null ? rs : null;
    }

    public void updateScoreById(int student_id, int subject_id, String scoreMouth, String scoreShortExam, String scoreMidSemester, String scoreSemester, float gpa, int schoolYear_id, int semester_id) {
        try {
            PreparedStatement ps = conn.prepareStatement("update score set scoreMouth=?, scoreShortExam=?, scoreMidSemester=?, scoreSemester=?, gpa =? where student_id=? and subject_id =? and school_year = ? and semester= ?");
            if (scoreMouth.equals("")) {
                ps.setNull(1, java.sql.Types.FLOAT);
            } else {
                ps.setFloat(1, Float.parseFloat(scoreMouth));
            }

            if (scoreShortExam.equals("")) {
                ps.setNull(2, java.sql.Types.FLOAT);
            } else {
                ps.setFloat(2, Float.parseFloat(scoreShortExam));
            }

            if (scoreMidSemester.equals("")) {
                ps.setNull(3, java.sql.Types.FLOAT);
            } else {
                ps.setFloat(3, Float.parseFloat(scoreMidSemester));
            }

            if (scoreSemester.equals("")) {
                ps.setNull(4, java.sql.Types.FLOAT);
            } else {
                ps.setFloat(4, Float.parseFloat(scoreSemester));
            }

            ps.setFloat(5, gpa);
            ps.setInt(6, student_id);
            ps.setInt(7, subject_id);
            ps.setInt(8, schoolYear_id);
            ps.setInt(9, semester_id);

            ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getHomeroomByPhoneNumber(String phoneNumber) {
        ResultSet rs = null;

        try {
            PreparedStatement ps = conn.prepareStatement("select distinct class_id, homeroom, school_year\n"
                    + "                   from teacher \n"
                    + "                    join teaching on teacher.id = teaching.teacher_id \n"
                    + "                   where teacher.phone_number = ? and homeroom = ? order by school_year desc");
            ps.setString(1, phoneNumber);
            ps.setString(2, "Yes");
            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public String getConduct(String classes, int student_id) {
        ResultSet rs = null;
        String result = "";
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct conduct from studying where student_id = ? and class_id =?");
            ps.setInt(1, student_id);
            ps.setString(2, classes);

            rs = ps.executeQuery();

            while (rs.next()) {
                result = rs.getString("conduct");
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public void updateConduct(String conduct, int student_id, String class_id) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE studying SET conduct = ? WHERE student_id = ? and class_id = ?");
            ps.setString(1, conduct);
            ps.setInt(2, student_id);
            ps.setString(3, class_id);

            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkMaileacher(String email, int id) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from teacher where email =? and id != ?");
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

    public boolean checkEntryPermit(String phoneNumber) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select entry_permission from teacher where phone_number = ?");
            ps.setString(1, phoneNumber);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getBoolean("entry_permission")) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Student getStudentById(int id) {
        ResultSet rs = null;
        Student student = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from student where id  = ?");

            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                student = new Student(id, rs.getString("email"), "", rs.getString("name"), rs.getString("gender"), rs.getDate("birthday"), rs.getString("phone_number"), rs.getString("address"), rs.getString("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return student;
    }

    public int checkDuplicateEdit(Student student) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from student where (student.email = ?  or student.phone_number = ?) and student.id != ?");
            ps.setString(1, student.getEmail());
            ps.setString(2, student.getPhone_number());
            ps.setInt(3, student.getId());
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
            Logger.getLogger(TeacherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int editStudent(Student editedStudentr) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE student SET phone_number = ?, email = ?, name = ?, gender = ?, birthday = ?, address = ? WHERE id = ?");
            ps.setString(1, editedStudentr.getPhone_number());
            ps.setString(2, editedStudentr.getEmail());
            ps.setString(3, editedStudentr.getName());
            ps.setString(4, editedStudentr.getGender());
            ps.setDate(5, editedStudentr.getBirthday());
            ps.setString(6, editedStudentr.getAddress());
            ps.setInt(7, editedStudentr.getId()); // assuming teacher_id is the primary key
            count = ps.executeUpdate(); // returns the number of rows affected in SQL

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? 0 : 1;
    }
}
