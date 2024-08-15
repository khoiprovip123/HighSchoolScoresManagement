/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.ParentsDAO;
import DAOs.StudentDAO1;
import DAOs.TeacherDAO1;
import Model.Parents;
import Model.Student;
import Model.Teacher1;
import com.nimbusds.jose.shaded.json.JSONObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class AdminController extends HttpServlet {

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
                if (c.getName().equals("Administrator")) {
                    phoneNumber = c.getValue();
                    break;
                }
            }
        }

        if (!phoneNumber.equals("")) {
            if (path.endsWith("/admin")) {
                request.getRequestDispatcher("/admin_homePage.jsp").forward(request, response);
            } else if (path.startsWith("/admin/teacher-management")) {
                if (path.endsWith("/admin/teacher-management")) {
                    request.getRequestDispatcher("/teacher-management.jsp").forward(request, response);
                } else if (path.endsWith("/admin/teacher-management/addnew")) {
                    request.getRequestDispatcher("/add-teacher.jsp").forward(request, response);
                } else if (path.startsWith("/admin/teacher-management/edit")) {
                    String[] s = path.split("/");
                    try {
                        int id = Integer.parseInt(s[s.length - 1]);
                        TeacherDAO1 tDAO = new TeacherDAO1();
                        Teacher1 teacher = tDAO.getTeacher(id);

                        if (teacher == null) {
                            response.sendRedirect("/admin/teacher-management");
                        } else {
                            //  HttpSession session = request.getSession();
                            session.setAttribute("teacher", teacher);
                            request.getRequestDispatcher("/edit-teacher.jsp").forward(request, response);
                        }

                    } catch (Exception ex) {
                        response.sendRedirect("/admin/teacher-management");
                    }
                }
            } else if (path.startsWith("/admin/class-management")) {
                if (path.endsWith("/admin/class-management")) {
                    request.getRequestDispatcher("/class-management.jsp").forward(request, response);
                }
            } else if (path.startsWith("/admin/student-look-up")) {
                if (path.endsWith("/admin/student-look-up")) {
                    request.getRequestDispatcher("/list-student.jsp").forward(request, response);
                } else if (path.endsWith("/admin/student-look-up/add-student")) {
                    request.getRequestDispatcher("/add-student.jsp").forward(request, response);
                }
            } else if (path.startsWith("/admin/subject-management")) {
                if (path.endsWith("/admin/subject-management")) {
                    request.getRequestDispatcher("/subject-management.jsp").forward(request, response);
                }
            } else if (path.startsWith("/admin/statistical")) {
                if (path.endsWith("/admin/statistical")) {
                    request.getRequestDispatcher("/statistical.jsp").forward(request, response);
                } else if (path.endsWith("/admin/statistical/academic")) {
                    request.getRequestDispatcher("/statistical-academic.jsp").forward(request, response);
                }
            } else if (path.startsWith("/admin/parent-management")) {
                if (path.endsWith("/admin/parent-management")) {
                    request.getRequestDispatcher("/parent-management.jsp").forward(request, response);
                } else if (path.endsWith("/admin/parent-management/addnew")) {
                    request.getRequestDispatcher("/add-parent.jsp").forward(request, response);
                } else if (path.startsWith("/admin/parent-management/edit")) {
                    String[] s = path.split("/");
                    try {
                        int id = Integer.parseInt(s[s.length - 1]);
                        ParentsDAO pDAO = new ParentsDAO();

                        Parents parent = pDAO.getParentById(id);

                        if (parent == null) {
                            response.sendRedirect("/admin/parent-management");
                        } else {
                            //  HttpSession session = request.getSession();
                            session.setAttribute("parent", parent);
                            request.getRequestDispatcher("/edit-parent.jsp").forward(request, response);
                        }
                    } catch (Exception ex) {
                        response.sendRedirect("/admin/parent-management");
                    }
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
        try {
            TeacherDAO1 tDAO = new TeacherDAO1();
            StudentDAO1 sDAO = new StudentDAO1();
            ParentsDAO pDAO = new ParentsDAO();
            HttpSession session = request.getSession();

            //updatePermission for tung` nguoi
            String action = request.getParameter("action");
            if (action != null && action.equals("updatePermission")) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                String scorePermission = request.getParameter("scorePermission");
                boolean updatePer = scorePermission.equals("1"); // 1 thi` true 0 thi` false

                if (tDAO.updateEntryPermission(teacherId, updatePer)) {
                    response.sendRedirect("/admin/teacher-management");
                } else {
                    response.sendRedirect("/admin/teacher-management");
                }
            }
            //  edit parent
            String editParent = request.getParameter("editParent");
            if (editParent != null) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String role = request.getParameter("role").trim();
                String job = request.getParameter("job").trim();
                int child = Integer.parseInt(request.getParameter("child").trim());

                Parents p = new Parents(id, phone, name, role, job, child);

                Parents oldParent = pDAO.getParentById(id);

                // int checkDuplicate = pDAO.checkDuplicateEdit(t);
                if (pDAO.checkChildEdit(p) == 1) {
                    session.setAttribute("existChild", "existChild");
                    response.sendRedirect("/admin/parent-management/edit/" + id);
                    return;
                }
                if (pDAO.getStudentById(child) == null) {
                    session.setAttribute("exist", "exist");
                    response.sendRedirect("/admin/parent-management/edit/" + id);
                    return;
                }

                if (pDAO.checkDuplicateEdit(p) == 1) {
                    session.setAttribute("existPhone", "existPhone");
                    response.sendRedirect("/admin/parent-management/edit/" + id);
                    return;
                }
                int teacher = pDAO.editParent(p);
                if (teacher == 1) {
                    response.sendRedirect("/admin/parent-management");
                } else {
                    session.setAttribute("teacher", oldParent);
                    response.sendRedirect("/admin/parent-management/edit/" + p.getId());
                }

            }
            //update stutus student
            String updateStatusStudent = request.getParameter("actionStatus");
            if (updateStatusStudent != null && updateStatusStudent.equals("updateStatus")) {
                int studentID = Integer.parseInt(request.getParameter("studentId"));
                String status = request.getParameter("status");
                boolean updateStatus = status.equals("1");
                if (sDAO.updateStatus(studentID, updateStatus)) {
                    response.sendRedirect("/admin/student-look-up");
                } else {
                    response.sendRedirect("/admin/student-look-up");
                }
            }
            //update status parent
            String updateStatusParent = request.getParameter("actionParent");
            if (updateStatusParent != null && updateStatusParent.equals("updateStatusParent")) {
                int studentID = Integer.parseInt(request.getParameter("parentId"));
                String status = request.getParameter("status");
                boolean updateStatus = status.equals("1");
                if (pDAO.updateStatus(studentID, updateStatus)) {
                    response.sendRedirect("/admin/parent-management");
                } else {
                    response.sendRedirect("/admin/parent-management");
                }
            }

            // update teacher status
            String actionActive = request.getParameter("actionActive");
            if (actionActive != null && actionActive.equals("updateStatus")) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                String scorePermission = request.getParameter("status");
                boolean updateActive = scorePermission.equals("1"); // 1 thi` true 0 thi` false

                if (tDAO.updateStatus(teacherId, updateActive)) {
                    response.sendRedirect("/admin/teacher-management");
                } else {
                    response.sendRedirect("/admin/teacher-management");
                }
            }

            //Open Nhap Diem
            String openAllPer = request.getParameter("openAllPer");
            if (openAllPer != null && openAllPer.equals("openAll")) {
                tDAO.openAllEntryPermission();
                response.sendRedirect("/admin/teacher-management");
            }

            // OFF Nhap Diem
            String offAllPer = request.getParameter("closeAllPer");
            if (offAllPer != null && offAllPer.equals("closeAll")) {
                tDAO.offAllEntryPermission();
                response.sendRedirect("/admin/teacher-management");
            }
            //add parent
            String addParent = request.getParameter("addParent");
            if (addParent != null && addParent.equals("addParent")) {
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String role = request.getParameter("role");
                String job = request.getParameter("job");
                int studentId = Integer.parseInt(request.getParameter("student_id"));
                ParentsDAO parentsDAO = new ParentsDAO();
                Parents newParent = new Parents(phone, name, role, job, studentId);
                session.setAttribute("oldParent", newParent);

                if (pDAO.getChild(studentId)) {
                    session.setAttribute("existChild", "existChild");
                    response.sendRedirect("/admin/parent-management/addnew");
                    return;
                }

                if (pDAO.getStudentById(studentId) == null) {
                    session.setAttribute("exist", "exist");
                    response.sendRedirect("/admin/parent-management/addnew");
                    return;
                }

                if (pDAO.existPhone(phone)) {
                    session.setAttribute("existPhone", "existPhone");
                    response.sendRedirect("/admin/parent-management/addnew");
                    return;
                } else {
                    Parents addedParent = parentsDAO.addNew(newParent);
                    if (addedParent != null) {
                        session.removeAttribute("oldParent");
                        response.sendRedirect("/admin/parent-management");
                    } else {
                        response.sendRedirect("/admin/parent-management/addnew");
                    }
                }

            }

            //submit add new teacher
            String addNew = request.getParameter("submitAdd");
            if (addNew != null && addNew.equals("submitAdd")) {
                String name = request.getParameter("name").trim();
                String email = request.getParameter("email").trim();
                String phone = request.getParameter("phone").trim();
                String gender = request.getParameter("gender").trim();
                Date birthday = Date.valueOf(request.getParameter("birthday"));
                String address = request.getParameter("address").trim();
                Teacher1 t = new Teacher1(phone, email, name, gender, birthday, address, "active", false);
                int checkDuplicate = tDAO.checkDuplicate(t);

                session.setAttribute("oldDataAdd", t);
                java.util.Date currentDate = new java.util.Date();
                if (birthday.after(currentDate)) {
                    session.setAttribute("invalidDay", "day");
                    response.sendRedirect("/admin/teacher-management/addnew");
                    return;
                }
                switch (checkDuplicate) {
                    case 1:
                        //phone
                        session.setAttribute("duplicatePhone", "phone");
                        response.sendRedirect("/admin/teacher-management/addnew");
                        break;
                    case 2:
                        session.setAttribute("duplicateEmail", "email");
                        response.sendRedirect("/admin/teacher-management/addnew");
                        break;
                    case 3:
                        session.setAttribute("duplicateEmail", "email");
                        session.setAttribute("duplicatePhone", "phone");
                        response.sendRedirect("/admin/teacher-management/addnew");
                        break;
                    case 0:
                        Teacher1 teacher = tDAO.addNew(t);
                        if (teacher != null) {
                            session.removeAttribute("oldDataAdd");
                            response.sendRedirect("/admin/teacher-management");
                        } else {
                            response.sendRedirect("/admin/teacher-management/addnew");
                        }
                        break;
                }
            }
            //add new student
            String addNewStudent = request.getParameter("addStudent");
            if (addNewStudent != null) {
                String name = request.getParameter("name").trim();
                String email = request.getParameter("email").trim();
                String phone = request.getParameter("phone").trim();
                String gender = request.getParameter("gender").trim();
                Date birthday = Date.valueOf(request.getParameter("birthday"));
                String address = request.getParameter("address").trim();

                // Kiểm tra xem ngày sinh có hợp lệ hay không (ví dụ: không lớn hơn ngày hiện tại)
                Student s = new Student(email, name, gender, birthday, phone, address);
                session.setAttribute("oldStudent", s);
                int checkDuplicate = sDAO.checkDuplicate(s);
                StudentDAO1 stuDAO = new StudentDAO1();
                java.util.Date currentDate = new java.util.Date();
                if (birthday.after(currentDate)) {
                    session.setAttribute("invalidDay", "day");
                    response.sendRedirect("/admin/student-look-up/add-student");
                    return;
                }
                switch (checkDuplicate) {
                    case 1:
                        //phone
                        session.setAttribute("duplicatePhone", "phone");
                        response.sendRedirect("/admin/student-look-up/add-student");
                        break;
                    case 2:
                        session.setAttribute("duplicateEmail", "email");
                        response.sendRedirect("/admin/student-look-up/add-student");
                        break;
                    case 3:
                        session.setAttribute("duplicateEmail", "email");
                        session.setAttribute("duplicatePhone", "phone");
                        response.sendRedirect("/admin/student-look-up/add-student");
                        break;
                    case 0:
                        Student student = sDAO.addNew(s);
                        if (student != null) {
                            session.removeAttribute("oldStudent");
                            response.sendRedirect("/admin/student-look-up");
                        } else {
                            response.sendRedirect("/admin/student-look-up/add-student");
                        }

                }
            }

            String checkID = request.getParameter("checkId");
            if ("checkId".equals(checkID)) {
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                Student student = pDAO.getStudentById(studentId);

                JSONObject jsonResponse = new JSONObject();
                if (student != null) {
                    jsonResponse.put("studentName", student.getName());
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse.toString());
            }

            //submit Edit teacher
            String editSubmitTeacher = request.getParameter("submitEdit");
            if (editSubmitTeacher != null && editSubmitTeacher.equals("submitEdit")) {
                String name = request.getParameter("name").trim();
                String email = request.getParameter("email").trim();
                String phone = request.getParameter("phone").trim();
                String gender = request.getParameter("gender").trim();
                Date birthday = Date.valueOf(request.getParameter("birthday"));
                String address = request.getParameter("address").trim();
                int id = Integer.parseInt(request.getParameter("id"));
                Teacher1 t = new Teacher1(id, phone, email, name, gender, birthday, address, "active", false);
                Teacher1 oldTeacher = tDAO.getTeacher(t.getId());
                int teacher = tDAO.editTeacher(t);
                int checkDuplicate = tDAO.checkDuplicateEdit(t);
                switch (checkDuplicate) {
                    case 1:
                        //phone
                        session.setAttribute("duplicatePhone", "phone");
                        response.sendRedirect("/admin/teacher-management/edit/" + t.getId());
                        break;
                    case 2:
                        session.setAttribute("duplicateEmail", "email");
                        response.sendRedirect("/admin/teacher-management/addnew");
                        break;
                    case 3:
                        session.setAttribute("duplicateEmail", "email");
                        session.setAttribute("duplicatePhone", "phone");
                        response.sendRedirect("/admin/teacher-management/edit/" + t.getId());
                        break;
                    default:
                        if (teacher == 1) {
                            response.sendRedirect("/admin/teacher-management");
                        } else {

                            session.setAttribute("teacher", oldTeacher);
                            response.sendRedirect("/admin/teacher-management/edit/" + t.getId());
                        }
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
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
