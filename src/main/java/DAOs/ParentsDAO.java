/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.Parents;
import Model.Student;
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
public class ParentsDAO {

    Connection conn;

    public ParentsDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select parents.id,parents.name,parents.phone_number,parents.role, [job], student.name as children, parents.status from parents join student on parents.student_id = student.id");
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public boolean updateStatus(int parentId, boolean status) {
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [parents]\n"
                    + "SET [status] = ? WHERE [id] = ?");
            ps.setBoolean(1, status);
            ps.setInt(2, parentId);
            int count = ps.executeUpdate();
            return count > 0;
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Student getStudentById(int studentId) {
        Student student = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(" select * from student where id = ?");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ++count;
                student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);

        }
        return (count == 0) ? null : student;
    }

    public Boolean getChild(int studentId) {
        try {
            PreparedStatement ps = conn.prepareStatement("select * from parents where parents.student_id = ?");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);

        }
        return false;
    }

    public boolean existPhone(String phone_number) {
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from parents Where phone_number = ?");
            ps.setString(1, phone_number);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int editParent(Parents editParent) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE parents SET phone_number = ?, name = ?, [role] = ?,job = ? ,[student_id] = ? WHERE id = ?");
            ps.setString(1, editParent.getPhone_number());
            ps.setString(2, editParent.getName());
            ps.setString(3, editParent.getRole());
            ps.setString(4, editParent.getJob());
            ps.setInt(5, editParent.getStudent_id());
            ps.setInt(6, editParent.getId());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? 0 : 1;
    }

    public int checkChildEdit(Parents parent) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from parents where parents.student_id = ? and id != ?;");
            ps.setInt(1, parent.getStudent_id());
            ps.setInt(2, parent.getId());
            rs = ps.executeQuery();
            if (rs.next()) {
                String existingChild = rs.getString("student_id");
                String st = parent.getStudent_id() + "";
                if (existingChild.equals(st)) {
                    return 1; // phone
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Parents getParentById(int id) {
        Parents acc = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from parents where id =?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                acc = new Parents(rs.getInt("id"), rs.getString("phone_number"), rs.getString("password"), rs.getString("name"), rs.getString("role"), rs.getString("job"), rs.getInt("student_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;
    }

    public Parents addNew(Parents newParent) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("  INSERT INTO parents( phone_number, password, name, role, job, student_id)\n"
                    + "SELECT ?, ?, ?, ?, ?, ?\n"
                    + "FROM student\n"
                    + "WHERE ? = student.id\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1 FROM parents WHERE student_id = ?\n"
                    + ");");
            ps.setString(1, newParent.getPhone_number());
            ps.setString(2, "c4ca4238a0b923820dcc509a6f75849b");
            ps.setString(3, newParent.getName());
            ps.setString(4, newParent.getRole());
            ps.setString(5, newParent.getJob());
            ps.setInt(6, newParent.getStudent_id());
            ps.setInt(7, newParent.getStudent_id());
            ps.setInt(8, newParent.getStudent_id());

            count = ps.executeUpdate(); // tra ve so dong bi anh huong trong sql

        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }

        return (count == 0) ? null : newParent;

    }

    public boolean existAccount(String phone_number, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from parents Where phone_number = ? AND password = ?");
            ps.setString(1, phone_number);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Parents updatePasswordParents(String username, String newPassword) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE parents SET password = ? WHERE phone_number = ?");
            ps.setString(1, newPassword);
            ps.setString(2, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : new Parents(); // hoặc return null;

    }

    public Parents getInfoparent(String phone_number) {
        Parents acc = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from parents where phone_number =?");
            ps.setString(1, phone_number);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                acc = new Parents(rs.getInt("id"), rs.getString("phone_number"), rs.getString("password"), rs.getString("name"), rs.getString("role"), rs.getString("job"), rs.getInt("student_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;
    }

    public ResultSet getAllparents(String phone_number) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from parents p  inner join student s on  p.student_id = s.id \n"
                    + "where p.phone_number = ?");
            ps.setString(1, phone_number);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Parents updateParent(int id, Parents newInfo) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE parents SET phone_number =? ,  name = ?, role = ?, job = ? WHERE id =?;");
            ps.setString(1, newInfo.getPhone_number());
            ps.setString(2, newInfo.getName());
            ps.setString(3, newInfo.getRole());
            ps.setString(4, newInfo.getJob());
            ps.setInt(5, id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count == 0 ? null : newInfo;
    }

    public boolean checkSDTParent(String phone_number) {
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("select * from parents where phone_number =?");
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

    public int checkDuplicateEdit(Parents parent) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from parents Where phone_number = ? and id != ?;");
            ps.setString(1, parent.getPhone_number());
            ps.setInt(2, parent.getId());
            rs = ps.executeQuery();
            if (rs.next()) {
                String existingEPhone = rs.getString("phone_number");
                if (existingEPhone.equals(parent.getPhone_number())) {
                    return 1; // phone
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDAO1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public String getStudentByParent(String phone_number) {
        ResultSet rs = null;
        String phoneNumber = "";

        try {
            PreparedStatement ps = conn.prepareStatement("select student.phone_number from parents\n"
                    + "join student on parents.student_id = student.id\n"
                    + "where parents.phone_number = ?");
            ps.setString(1, phone_number);
            rs = ps.executeQuery();
            while (rs.next()) {
                phoneNumber = rs.getString("phone_number");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdministratorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return phoneNumber;
    }
}
