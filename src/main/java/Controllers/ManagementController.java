/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AdministratorDAO;
import DAOs.LoginDAO;
import DAOs.ParentsDAO;
import DAOs.StudentDAO;
import DAOs.TeacherDAO;
import Model.Administrator;
import Model.Parents;
import Model.Student;
import Model.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class ManagementController extends HttpServlet {

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
            out.println("<title>Servlet ManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagementController at " + request.getContextPath() + "</h1>");
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
    @SuppressWarnings("empty-statement")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI(); // Get the URL

        String phone_number = "";
        String role = "";
        Cookie[] list = request.getCookies();
        if (list != null) {
            for (Cookie c : list) {
                String name = c.getName();
                if (name.equals("Teacher") || name.equals("Administrator")
                        || name.equals("Parents") || name.equals("Student")) {
                    role = name;
                    phone_number = c.getValue();
                    break;
                }
            }
        }

        if (!phone_number.equals("")) {
            if (path.endsWith("/AdministratorHomePage")) { //Login for Customer
                if (role.equals("Administrator")) {
                    request.getRequestDispatcher("/admin_homePage.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/");
                }
            } else if (path.endsWith("/TeacherHomePage")) { //Login for Customer
                if (role.equals("Teacher")) {
                    request.getRequestDispatcher("/teacher_homePage.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/");
                }
            } else if (path.endsWith("/ParentsHomePage")) { //Login for Customer
                if (role.equals("Parents")) {
                    request.getRequestDispatcher("/parents_homePage.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/");
                }
            } else if (path.endsWith("/StudentHomePage")) { //Login for Customer
                if (role.equals("Student")) {
                    request.getRequestDispatcher("/student_homePage.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/");
                }
            } else if (path.endsWith("/ChangpassPage")) {
                request.getRequestDispatcher("/changePass.jsp").forward(request, response);
            } else if (path.endsWith("/AccountPage")) {
                request.getRequestDispatcher("/myaccount.jsp").forward(request, response);
            } else if (path.endsWith("/AccountParentsPage")) {
                request.getRequestDispatcher("/myaccountParents.jsp").forward(request, response);
            } else if (path.endsWith("/AccountStudentPage")) {
                request.getRequestDispatcher("/myaccountStudent.jsp").forward(request, response);
            } else if (path.endsWith("/AccountTeacherPage")) {
                request.getRequestDispatcher("/myaccountTeacher.jsp").forward(request, response);
            } else if (path.endsWith("/AdministratorSignOut")) { //Login for Customer

                Cookie[] cList;
                cList = request.getCookies();
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    if (cList1.getName().equals("Administrator")) { //nguoi dung da dang nhap
                        cList1.setValue("");
                        cList1.setPath("/");
                        cList1.setMaxAge(0);
                        response.addCookie(cList1);

                        break; //thoat khoi vong lap
                    }
                }
                response.sendRedirect("/");
            } else if (path.endsWith("/TeacherSignOut")) { //Login for Customer
                Cookie[] cList;
                cList = request.getCookies();
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    if (cList1.getName().equals("Teacher")) { //nguoi dung da dang nhap
                        cList1.setValue("");
                        cList1.setPath("/");
                        cList1.setMaxAge(0);
                        response.addCookie(cList1);
                        break; //thoat khoi vong lap
                    }
                }
                response.sendRedirect("/");
            } else if (path.endsWith("/ParentsSignOut")) { //Login for Customer
                Cookie[] cList;
                cList = request.getCookies();
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    if (cList1.getName().equals("Parents")) { //nguoi dung da dang nhap
                        cList1.setValue("");
                        cList1.setPath("/");
                        cList1.setMaxAge(0);
                        response.addCookie(cList1);
                        break; //thoat khoi vong lap
                    }
                }
                response.sendRedirect("/");
            } else if (path.endsWith("/StudentSignOut")) { //Login for Customer
                Cookie[] cList;
                cList = request.getCookies();
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    if (cList1.getName().equals("Student")) { //nguoi dung da dang nhap
                        cList1.setValue("");
                        cList1.setPath("/");
                        cList1.setMaxAge(0);
                        response.addCookie(cList1);
                        break; //thoat khoi vong lap
                    }
                }
                response.sendRedirect("/");
            }
        } else if (path.endsWith("/ForgotPassword")) {
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } else if (path.endsWith("/Management/LoginPage")) {
            response.sendRedirect("/");
        } else {
            response.sendRedirect("/");
        };
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

        if (request.getParameter("btnLogin") != null) { //Nguoi dung da nhan nut submit
            LoginDAO lDAO = new LoginDAO();
            String role = request.getParameter("role");
            String phone_number = request.getParameter("phone_number");
            String password = lDAO.getPwdMd5(request.getParameter("password"));

            if (role.equals("Administrator")) {
                AdministratorDAO aDAO = new AdministratorDAO();
                if (aDAO.existAccount(phone_number, password)) {
                    Cookie c = new Cookie("Administrator", phone_number);
                    c.setMaxAge(5 * 60 * 60); //Thiet lap han su dung 3 ngay
                    response.addCookie(c);//Day cookie xuong may duong dung (client)
                    response.sendRedirect("/Management/AdministratorHomePage");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("loginfail", "1");
                    response.sendRedirect("/");
                }
            } else if (role.equals("Teacher")) {
                TeacherDAO tDAO = new TeacherDAO();
                if (tDAO.existAccount(phone_number, password)) {
                    Cookie c = new Cookie("Teacher", phone_number);
                    c.setMaxAge(5 * 60 * 60); //Thiet lap han su dung 3 ngay
                    response.addCookie(c);//Day cookie xuong may duong dung (client)
                    response.sendRedirect("/Management/TeacherHomePage");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("loginfail", "1");
                    response.sendRedirect("/");
                }
            } else if (role.equals("Parents")) {
                ParentsDAO pDAO = new ParentsDAO();
                if (pDAO.existAccount(phone_number, password)) {
                    Cookie c = new Cookie("Parents", phone_number);
                    c.setMaxAge(5 * 60 * 60); //Thiet lap han su dung 3 ngay
                    response.addCookie(c);//Day cookie xuong may duong dung (client)
                    response.sendRedirect("/Management/ParentsHomePage");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("loginfail", "1");
                    response.sendRedirect("/");
                }
            } else if (role.equals("Student")) {
                StudentDAO sDAO = new StudentDAO();
                if (sDAO.existAccount(phone_number, password)) {
                    Cookie c = new Cookie("Student", phone_number);
                    c.setMaxAge(5 * 60 * 60); //Thiet lap han su dung 3 ngay
                    response.addCookie(c);//Day cookie xuong may duong dung (client)
                    response.sendRedirect("/Management/StudentHomePage");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("loginfail", "1");
                    response.sendRedirect("/");
                }
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("loginfail", "2");
                response.sendRedirect("/");
            }
        } else if (request.getParameter("submit_saveAdmin") != null) {
            String phone = request.getParameter("phone_number");
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String gen = request.getParameter("gender");
            Date birthday = Date.valueOf(request.getParameter("birthday"));
            String address = request.getParameter("address");
            java.util.Date currentDate = new java.util.Date();

            AdministratorDAO adao = new AdministratorDAO();
            boolean admin1 = adao.checkEmailAdmin(email, phone);
            if (admin1) {
                HttpSession session = request.getSession();
                session.setAttribute("emailFail", " Email already exists ");
                response.sendRedirect("/Management/AccountPage");
            } else if (birthday.after(currentDate)) {
                HttpSession session = request.getSession();
                session.setAttribute("invalidDay", "Invalid data");
                response.sendRedirect("/Management/AccountPage");
                return;
            } else {
                Administrator adminnew = new Administrator(phone, email, "", name, gen, birthday, address);
                Administrator admin = adao.updateAdmin(phone, adminnew);

                if (admin == null) {
                    response.sendRedirect("/Management/AccountPage");
                } else {
                    response.sendRedirect("/Management/AdministratorHomePage");

                }
            }

        } else if (request.getParameter("submit_saveTeacher") != null) {
            int id = Integer.parseInt(request.getParameter("teacherID"));
            String phone = request.getParameter("phone_number");
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String gen = request.getParameter("gender");
            Date birthday = Date.valueOf(request.getParameter("birthday"));
            String address = request.getParameter("address");
            String status = request.getParameter("status");
            TeacherDAO TDAO = new TeacherDAO();
            boolean admin1 = TDAO.checkMaileacher(email, id);
            java.util.Date currentDate = new java.util.Date();
            if (admin1) {
                HttpSession session = request.getSession();
                session.setAttribute("emailFailTeacher", " Email already exists ");
                response.sendRedirect("/Management/AccountTeacherPage");
            } else if (birthday.after(currentDate)) {
                HttpSession session = request.getSession();
                session.setAttribute("invalidDay", "Invalid data");
                response.sendRedirect("/Management/AccountTeacherPage");
                return;
            } else {
                Teacher teachernew = new Teacher(id, email, "", name, gen, birthday, phone, address, status);
                Teacher admin = TDAO.updateTeacher(id, teachernew);
                if (admin == null) {
                    response.sendRedirect("/Management/AccountTeacherPage");
                } else {
                    response.sendRedirect("/Management/TeacherHomePage");
                }
            }

        } else if (request.getParameter("submit_saveParent") != null) {
            int id = Integer.parseInt(request.getParameter("parentID"));
            String phone = request.getParameter("phone_parent");
            String name = request.getParameter("name_parent");
            String role = request.getParameter("role_parent");
            String job = request.getParameter("job_parent");
            Parents parentnew = new Parents(id, phone, "", name, role, job, 0);
            ParentsDAO PDAO = new ParentsDAO();
            Parents admin = PDAO.updateParent(id, parentnew);
            if (admin == null) {
                Parents thongTinCu = PDAO.getInfoparent(phone);
                HttpSession sesstion = request.getSession();
                sesstion.setAttribute("order", thongTinCu);
                response.sendRedirect("/Management/AccountParentsPage");
            } else {
                response.sendRedirect("/Management/ParentsHomePage");
            }

        } else if (request.getParameter("submit_saveStudent") != null) {
            int id = Integer.parseInt(request.getParameter("teacherID"));
            String phone = request.getParameter("phone_student");
            String name = request.getParameter("name_student");
            String email = request.getParameter("email_student");
            String gen = request.getParameter("gender_student");
            Date birthday = Date.valueOf(request.getParameter("birthday_student"));
            String address = request.getParameter("address_student");
            String status = request.getParameter("status_student");
            StudentDAO SDAO = new StudentDAO();
            boolean admin1 = SDAO.checkEmailStudent(email, id);
            java.util.Date currentDate = new java.util.Date();
            if (admin1) {
                HttpSession session = request.getSession();
                session.setAttribute("emailFailStudent", " Email already exists ");
                response.sendRedirect("/Management/AccountParentsPage");
            } else if (birthday.after(currentDate)) {
                HttpSession session = request.getSession();
                session.setAttribute("invalidDay", "Invalid data");
                response.sendRedirect("/Management/AccountParentsPage");
                return;
            } else {
                Student studentnew = new Student(id, email, "", name, gen, birthday, phone, address, status);
                Student admin = SDAO.updateStudent(id, studentnew);
                if (admin == null) {
                    response.sendRedirect("/Management/AccountParentsPage");
                } else {
                    response.sendRedirect("/Management/ParentsHomePage");
                }
            }

        } else if (request.getParameter("btn_submit") != null) {

            LoginDAO lDAO = new LoginDAO();
            // String old_password = lDAO.getPwdMd5(request.getParameter("current_password"));
            String role = "";
            String old_pass = lDAO.getPwdMd5(request.getParameter("old_password"));
            String new_pass = lDAO.getPwdMd5(request.getParameter("new_password"));
            String confirm_password = lDAO.getPwdMd5(request.getParameter("confirm_password"));

            AdministratorDAO ADAO = new AdministratorDAO();
            TeacherDAO TDAO = new TeacherDAO();
            StudentDAO SDAO = new StudentDAO();
            ParentsDAO PDAO = new ParentsDAO();
            String username = null;
            Cookie[] cList = request.getCookies();
            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Administrator")) {
                        role = "admin";
                        username = c.getValue();
                        break;
                    } else if (c.getName().equals("Teacher")) {
                        role = "teacher";
                        username = c.getValue();
                        break;
                    } else if (c.getName().equals("Parents")) {
                        role = "parents";
                        username = c.getValue();
                        break;
                    } else if (c.getName().equals("Student")) {
                        role = "student";
                        username = c.getValue();
                        break;
                    }
                }
                Administrator admin = null;
                Student student = null;
                Parents parents = null;
                Teacher teacher = null;
                if (role.equals("teacher")) {
                    Teacher admin1 = TDAO.getInfoteacher(username);
                    String old_pass1 = admin1.getPassword();
                    if (old_pass.equals(old_pass1)) {
                        if (!new_pass.equals(old_pass)) {
                            if (new_pass.equals(confirm_password)) {
                                teacher = TDAO.updatePasswordTeacher(username, new_pass);
                            } else {
                                request.getSession().setAttribute("samepass111", "The new password must be the same as the confirm password");
                                response.sendRedirect("/Management/ChangpassPage");
                            }
                            // Xử lý khi new_pass không giống old_pass1
                        } else {
                            request.getSession().setAttribute("samepass1", "The new password must be different from the old password");
                            response.sendRedirect("/Management/ChangpassPage");

                        }
                    } else {
                        // Xử lý khi new_pass giống old_pass1
                        request.getSession().setAttribute("samepass", "Old-Password incorrect");
                        response.sendRedirect("/Management/ChangpassPage");

                    }
                } else if (role.equals("parents")) {
                    Parents admin1 = PDAO.getInfoparent(username);
                    String old_pass1 = admin1.getPassword();
                    if (old_pass.equals(old_pass1)) {
                        if (!new_pass.equals(old_pass)) {
                            if (new_pass.equals(confirm_password)) {
                                parents = PDAO.updatePasswordParents(username, new_pass);
                            } else {
                                request.getSession().setAttribute("samepass111", "The new password must be the same as the confirm password");
                                response.sendRedirect("/Management/ChangpassPage");
                            }
                        } else {
                            request.getSession().setAttribute("samepass1", "The new password must be different from the old password");
                            response.sendRedirect("/Management/ChangpassPage");

                        }
                    } else {
                        // Xử lý khi new_pass giống old_pass1
                        request.getSession().setAttribute("samepass", "Old-Password incorrect");
                        response.sendRedirect("/Management/ChangpassPage");

                        // Có thể thêm điều hướng hoặc mã thông báo khác tại đây nếu cần
                    }
                } else if (role.equals("student")) {
                    Student admin1 = SDAO.getInfostudent(username);
                    String old_pass1 = admin1.getPassword();
                    if (old_pass.equals(old_pass1)) {
                        if (!new_pass.equals(old_pass)) {
                            if (new_pass.equals(confirm_password)) {
                                student = SDAO.updatePasswordStudent(username, new_pass);
                            } else {
                                request.getSession().setAttribute("samepass111", "The new password must be the same as the confirm password");
                                response.sendRedirect("/Management/ChangpassPage");
                            }
                            // Xử lý khi new_pass không giống old_pass1
                        } else {
                            request.getSession().setAttribute("samepass1", "The new password must be different from the old password");
                            response.sendRedirect("/Management/ChangpassPage");

                        }
                    } else {
                        // Xử lý khi new_pass giống old_pass1
                        request.getSession().setAttribute("samepass", "Old-Password incorrect");
                        response.sendRedirect("/Management/ChangpassPage");

                        // Có thể thêm điều hướng hoặc mã thông báo khác tại đây nếu cần
                    }
                } else if (role.equals("admin")) {
                    Administrator admin1 = ADAO.getInfo(username);
                    String old_pass1 = admin1.getPassword();
                    if (old_pass.equals(old_pass1)) {
                        if (!new_pass.equals(old_pass)) {
                            if (new_pass.equals(confirm_password)) {
                                admin = ADAO.updatePasswordAdmin(username, new_pass);
                            } else {
                                request.getSession().setAttribute("samepass111", "The new password must be the same as the confirm password");
                                response.sendRedirect("/Management/ChangpassPage");
                            }
                        } else {
                            request.getSession().setAttribute("samepass1", "The new password must be different from the old password");
                            response.sendRedirect("/Management/ChangpassPage");

                        }
                    } else {
                        // Xử lý khi new_pass giống old_pass1
                        request.getSession().setAttribute("samepass", "Old-Password incorrect");
                        response.sendRedirect("/Management/ChangpassPage");
                        // Có thể thêm điều hướng hoặc mã thông báo khác tại đây nếu cần
                    }
                }
                if (teacher != null) {
                    response.sendRedirect("/Management/TeacherHomePage");
                    //  request.getSession().setAttribute("samepass11", "Thanh Cong Roi");
                } else if (admin != null) {
                    response.sendRedirect("/Management/AdministratorHomePage");
                    //request.getSession().setAttribute("samepass11", "Thanh Cong Roi");
                } else if (student != null) {
                    response.sendRedirect("/Management/StudentHomePage");
                    // request.getSession().setAttribute("samepass11", "Thanh Cong Roi");
                } else if (parents != null) {
                    response.sendRedirect("/Management/ParentsHomePage");
                    // request.getSession().setAttribute("samepass11", "Thanh Cong Roi");
                }
//else {
//                    response.sendRedirect("/Management/ChangpassPage");
//                }
            }
        } else if (request.getParameter("btnForget") != null) {
            LoginDAO lDAO = new LoginDAO();
            String role = request.getParameter("role");
            String phone = (request.getParameter("phone"));
            String new_pass = lDAO.getPwdMd5(request.getParameter("new_password"));
            String confirm_password = lDAO.getPwdMd5(request.getParameter("confirm_password"));
            AdministratorDAO aDAO = new AdministratorDAO();
            TeacherDAO tDAO = new TeacherDAO();
            StudentDAO sDAO = new StudentDAO();
            ParentsDAO pDAO = new ParentsDAO();
            Administrator admin = null;
            Teacher teacher = null;
            Parents parent = null;
            Student student = null;
            if (role.equals("Administrator")) {
                if (aDAO.checkSDAdmin(phone)) {
                    if (new_pass.equals(confirm_password)) {
                        admin = aDAO.updatePasswordAdmin(phone, new_pass);
                    } else {
                        request.getSession().setAttribute("passerr", "New password and confirm password must be the same");
                        response.sendRedirect("/Management/ForgotPassword");
                    }
                } else {
                    request.getSession().setAttribute("phoneerr", "Phone number does not exist");
                    response.sendRedirect("/Management/ForgotPassword");
                }
            } else if (role.equals("Teacher")) {
                if (tDAO.checkSDTeacher(phone)) {
                    if (new_pass.equals(confirm_password)) {
                        teacher = tDAO.updatePasswordTeacher(phone, new_pass);
                    } else {
                        request.getSession().setAttribute("passerr", "New password and confirm password must be the same");
                        response.sendRedirect("/Management/ForgotPassword");
                    }
                } else {
                    request.getSession().setAttribute("phoneerr", "Phone number does not exist");
                    response.sendRedirect("/Management/ForgotPassword");
                }
            } else if (role.equals("Student")) {
                if (sDAO.checkSDTStudent(phone)) {
                    if (new_pass.equals(confirm_password)) {
                        student = sDAO.updatePasswordStudent(phone, new_pass);
                    } else {
                        request.getSession().setAttribute("passerr", "New password and confirm password must be the same");
                        response.sendRedirect("/Management/ForgotPassword");
                    }
                } else {
                    request.getSession().setAttribute("phoneerr", "Phone number does not exist");
                    response.sendRedirect("/Management/ForgotPassword");
                }
            } else if (role.equals("Parents")) {
                if (pDAO.checkSDTParent(phone)) {
                    if (new_pass.equals(confirm_password)) {
                        parent = pDAO.updatePasswordParents(phone, new_pass);
                    } else {
                        request.getSession().setAttribute("passerr", "New password and confirm password must be the same");
                        response.sendRedirect("/Management/ForgotPassword");
                    }
                } else {
                    request.getSession().setAttribute("phoneerr", "Phone number does not exist");
                    response.sendRedirect("/Management/ForgotPassword");
                }
            } else {
                request.getSession().setAttribute("noerr", "Please select role before entering information");
                response.sendRedirect("/Management/ForgotPassword");
            }

            if (admin != null) {
                response.sendRedirect("/Management/LoginPage");
            }
            if (teacher != null) {
                response.sendRedirect("/Management/LoginPage");
            }
            if (student != null) {
                response.sendRedirect("/Management/LoginPage");
            }
            if (parent != null) {
                response.sendRedirect("/Management/LoginPage");
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
