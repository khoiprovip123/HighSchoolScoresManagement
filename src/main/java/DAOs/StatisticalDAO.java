/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class StatisticalDAO {

    Connection conn;

    public StatisticalDAO() throws ClassNotFoundException {
        try {
            conn = DB.DBConnection.connect();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Map<String, Integer> getStudnentBySchoolYear() {
        Map<String, Integer> studentCounts = new HashMap<>();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT school_year.name as school_year, COUNT(student_id) AS student_count\n"
                    + "FROM student join studying on student.id = studying.student_id join school_year on studying.school_year = school_year.id\n"
                    + "GROUP BY school_year.name;");
            while (rs.next()) {
                String schoolYear = rs.getString("school_year");
                int studentCount = rs.getInt("student_count");
                studentCounts.put(schoolYear, studentCount);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return studentCounts;
    }

    public Map<String, Integer> getStudnentByClass() {
        Map<String, Integer> studentCounts = new HashMap<>();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("   SELECT [class_id], COUNT([student_id]) AS total_students\n" +
"                    FROM [studying]\n" +
"                    GROUP BY [class_id];");
            while (rs.next()) {
                String classID = rs.getString("class_id");
                int studentCount = rs.getInt("total_students");
                studentCounts.put(classID, studentCount);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return studentCounts;
    }

    public Map<String, Integer> getStudnentAcademic() {
        Map<String, Integer> studentCounts = new HashMap<>();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT \n"
                    + "    classification,\n"
                    + "    COUNT(*) AS count_classification\n"
                    + "FROM (\n"
                    + "    SELECT \n"
                    + "        student_id,\n"
                    + "        CASE \n"
                    + "            WHEN final_average_score >= 8 THEN 'Very Good'\n"
                    + "            WHEN final_average_score >= 6.5 THEN 'Good'\n"
                    + "            WHEN final_average_score >= 5.0 THEN 'Evergare'\n"
                    + "            ELSE 'ok'\n"
                    + "        END AS classification\n"
                    + "    FROM (\n"
                    + "        SELECT \n"
                    + "            student_id,\n"
                    + "            SUM(average_score)/10 AS final_average_score\n"
                    + "        FROM (\n"
                    + "            SELECT \n"
                    + "                student_id,\n"
                    + "                AVG(scoreMouth * 1 + scoreShortExam * 1 + scoreMidSemester * 2 + scoreSemester * 3) / 7 AS average_score\n"
                    + "            FROM \n"
                    + "                [High_School_Scores_Management1].[dbo].[score]\n"
                    + "            GROUP BY \n"
                    + "                student_id,\n"
                    + "                subject_id\n"
                    + "        ) AS subquery\n"
                    + "        GROUP BY \n"
                    + "            student_id\n"
                    + "    ) AS final_scores\n"
                    + ") AS classified_students\n"
                    + "GROUP BY \n"
                    + "    classification;");
            while (rs.next()) {
                String classification = rs.getString("classification");
                int studentCount = rs.getInt("count_classification");
                studentCounts.put(classification, studentCount);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return studentCounts;
    }
}
