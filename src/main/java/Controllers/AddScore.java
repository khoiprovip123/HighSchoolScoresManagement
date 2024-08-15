/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.TeacherDAO;
import Model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class AddScore extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddScore</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddScore at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        HttpSession session = request.getSession();

        String phoneNumber = "";
        Cookie[] list = request.getCookies();
        if (list != null) {
            for (Cookie c : list) {
                if (c.getName().equals("Teacher")) {
                    phoneNumber = c.getValue();
                    break;
                }
            }
        }

        if (!phoneNumber.equals("")) {

            if (path.endsWith("AddScore")) {
//                //sua roi
                TeacherDAO tDAO = new TeacherDAO();
                boolean checkEntryPermit = tDAO.checkEntryPermit(phoneNumber);
                if (checkEntryPermit) {
                    session.setAttribute("isAccess", "true");
                } else {
                    session.setAttribute("isAccess", "false");
                }
//                
                request.getRequestDispatcher("/addScore.jsp").forward(request, response);
            } else if (path.endsWith("/reportScore")) {
//            
                if (!phoneNumber.equals("")) {
                    TeacherDAO tDAO = new TeacherDAO();
                    ResultSet rs = tDAO.getHomeroomByPhoneNumber(phoneNumber);
                    String classes = "";

                    try {
                        while (rs.next()) {
                            classes = rs.getString("class_id");
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(AddScore.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    if (!classes.equals("")) {
                        session.setAttribute("homeroom", classes + " " + classes);
                    } else {
                        session.setAttribute("homeroom", "false");
                    }
                } else {
                    session.setAttribute("homeroom", "false");
                }
                request.getRequestDispatcher("/reportScore.jsp").forward(request, response);
            } else if (path.endsWith("/updateConduct")) {
                int student_id = Integer.parseInt(request.getParameter("id"));
                String conduct = request.getParameter("conduct");
                String classes = request.getParameter("classes");

                TeacherDAO tDAO = new TeacherDAO();
                tDAO.updateConduct(conduct, student_id, classes);
            } else if (path.endsWith("/homeroom")) {

                if (!phoneNumber.equals("")) {
                    TeacherDAO tDAO = new TeacherDAO();
                    ResultSet rs = tDAO.getHomeroomByPhoneNumber(phoneNumber);
                    String classes = "";

                    try {
                        while (rs.next()) {
                            classes = rs.getString("class_id");
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(AddScore.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    if (!classes.equals("")) {
                        session.setAttribute("homeroom", classes);
                    } else {
                        session.setAttribute("homeroom", "false");
                    }
                } else {
                    session.setAttribute("homeroom", "false");
                }
                request.getRequestDispatcher("/list-student-homeroom.jsp").forward(request, response);
            } else if (path.startsWith("/AddScore/edit/")) {
                String[] str = path.split("/");
                String student_id = str[str.length - 1];
                Student student = null;
                TeacherDAO tDAO = new TeacherDAO();
                try {
                    student = tDAO.getStudentById(Integer.parseInt(student_id));
                } catch (IllegalArgumentException e) {
                    System.out.println("Id must be a integer");
                }

                if (student == null) {
                    response.sendRedirect("/TeacherHomePage");
                } else {
                    HttpSession seesion = request.getSession();
                    seesion.setAttribute("student", student);
                    request.getRequestDispatcher("/student-profile.jsp").forward(request, response);
                }
            }

        } else {
            response.sendRedirect("/Management/LoginPage");
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
//        Cookie cookie = new Cookie("teacher", "0942368977");
//        cookie.setMaxAge(60 * 5);
//        response.addCookie(cookie);

        if (request.getParameter("btn-filter") != null) {
            String classes = request.getParameter("class");
            int subject = Integer.parseInt(request.getParameter("subject"));
            String semester = request.getParameter("semester");

            TeacherDAO tDAO = new TeacherDAO();
            Cookie[] cList = request.getCookies();
            String phoneNumber = "";
            for (Cookie c : cList) {
                if (c.getName().equals("Teacher")) {
                    phoneNumber = c.getValue();
                    break;
                }
            }

            List<String> list = new ArrayList<>();
            list.add(classes);
            list.add(subject + "");
            list.add(semester);
            session.setAttribute("list", list);
            String[] arr = classes.split(" ");
            int school_id = Integer.parseInt(arr[1]);
            int id = tDAO.getTeacherByPhoneNumber(phoneNumber);
            if (id > 0) {
                boolean checkTeacher = tDAO.getTeacherByClassAndSubject(classes.split(" ")[0], subject, id, school_id);

                if (checkTeacher) {
                    session.setAttribute("isPower", id + "");
                } else {
                    session.setAttribute("isPower", "false");
                }
            } else {
                session.setAttribute("isPower", "false");
            }

            response.sendRedirect("/AddScore");
        } else if (request.getParameter("btn-save") != null) {
            String[] txtValues = request.getParameter("txt_values").split(" ");
            String classes = txtValues[0];
            int subject_id = Integer.parseInt(txtValues[2]);
            int semester_id = Integer.parseInt(txtValues[3]);

            TeacherDAO tDAO = new TeacherDAO();
            ResultSet rs = tDAO.getStudent(classes + " " + txtValues[1]);
            try {
                while (rs.next()) {
                    int student_id = rs.getInt("student_id");

                    if (request.getParameter(student_id + " scoreMouth") != null) {
                        String scoreMouth = request.getParameter(student_id + " scoreMouth");
                        String scoreShortExam = request.getParameter(student_id + " scoreShortExam");
                        String scoreMidSemester = request.getParameter(student_id + " scoreMidSemester");
                        String scoreSemester = request.getParameter(student_id + " scoreSemester");
                        Float gpa = Float.parseFloat(request.getParameter(student_id + " gpa"));
                        tDAO.updateScoreById(student_id, subject_id, scoreMouth, scoreShortExam, scoreMidSemester, scoreSemester, gpa, Integer.parseInt(txtValues[1]), semester_id);

                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(AddScore.class.getName()).log(Level.SEVERE, null, ex);
            }

            response.sendRedirect("/AddScore");
        } else if (request.getParameter("btn-filtScore") != null) {
            String classes = request.getParameter("class");
            String semester = request.getParameter("semester");

            session.setAttribute("semester", semester);
            response.sendRedirect("/AddScore/reportScore");
        } else if (request.getParameter("submitEdit") != null) {
            String name = request.getParameter("name").trim();
            String email = request.getParameter("email").trim();
            String phone = request.getParameter("phone").trim();
            String gender = request.getParameter("gender").trim();
            Date birthday = Date.valueOf(request.getParameter("birthday"));
            String address = request.getParameter("address").trim();
            int id = Integer.parseInt(request.getParameter("id"));
            Student newStudent = new Student(id, email, "", name, gender, birthday, phone, address, "");
            TeacherDAO tDAO = new TeacherDAO();
            Student oldStudent = tDAO.getStudentById(id);
            int checkDuplicate = tDAO.checkDuplicateEdit(newStudent);
            switch (checkDuplicate) {
                case 1:
                    //phone
                    session.setAttribute("duplicatePhone", "phone");
                    response.sendRedirect("/AddScore/edit/" + newStudent.getId());
                    break;
                case 2:
                    session.setAttribute("duplicateEmail", "email");
                    response.sendRedirect("/AddScore/edit/" + newStudent.getId());
                    break;
                case 3:
                    session.setAttribute("duplicateEmail", "email");
                    session.setAttribute("duplicatePhone", "phone");
                    response.sendRedirect("/AddScore/edit/" + newStudent.getId());
                    break;
                case 0:
                    int checkUpdate = tDAO.editStudent(newStudent);
                    if (checkUpdate == 1) {
                        response.sendRedirect("/AddScore/homeroom");
                    } else {

                        session.setAttribute("student", oldStudent);
                        response.sendRedirect("/AddScore/edit/" + oldStudent.getId());
                    }
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
