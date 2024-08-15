<%-- 
    Document   : changePass
    Created on : Feb 29, 2024, 10:49:41 AM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="Model.Teacher"%>
<%@page import="DAOs.TeacherDAO"%>
<%@page import="Model.Student"%>
<%@page import="DAOs.StudentDAO"%>
<%@page import="Model.Parents"%>
<%@page import="DAOs.ParentsDAO"%>
<%@page import="Model.Administrator"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
            />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"
        ></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <style>
            .nav-link {
                color: white;
            }

            .nav-link:hover {
                text-decoration: underline;
                color: white;
            }
            /* Reset some default styles */
            body, html {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            form {
                max-width: 400px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
            }

            div {
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            input[type="password"] {
                width: 100%;
                padding: 10px;
                border-radius: 3px;
                border: 1px solid #ccc;
                box-sizing: border-box; /* Ensure padding and border are included in width */
            }

            button {
                display: block;
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 3px;
                background-color: #007bff;
                color: #fff;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

            .error {
                color: red;
                font-size: 14px;
                margin-top: 5px;
            }
            .h2{
                text-align: center;
            }

            .small {
                display: block;
                text-align: center; /* Canh giữa nội dung */
                font-size: 20px; /* Kích thước chữ */
                color: red; /* Màu chữ */
                margin-top: 10px; /* Khoảng cách từ trên xuống */
            }

        </style>
    </head>
    <body>
        <%
            String role = "";
            String phone_number = "";
            Cookie[] cList = request.getCookies();
            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Administrator")) {
                        phone_number = c.getValue();
                        role = "admin";
                        break;
                    } else if (c.getName().equals("Teacher")) {
                        phone_number = c.getValue();
                        role = "teacher";
                        break;
                    } else if (c.getName().equals("Parents")) {
                        phone_number = c.getValue();
                        role = "parents";
                        break;
                    } else if (c.getName().equals("Student")) {
                        phone_number = c.getValue();
                        role = "student";
                        break;
                    }
                }
            }
            AdministratorDAO ad = new AdministratorDAO();
            Administrator adc = ad.getInfo(phone_number);
            ParentsDAO pa = new ParentsDAO();
            Parents pa1 = pa.getInfoparent(phone_number);
            StudentDAO dDAO = new StudentDAO();
            Student ra = dDAO.getInfostudent(phone_number);
            TeacherDAO TDAO = new TeacherDAO();
            Teacher ra1 = TDAO.getInfoteacher(phone_number);
        %>
        <header class="container-fluid">
            <div class="d-flex row">
                <div class="col-sm-2">
                    <a href=" <%=role.equals("admin") ? "/Management/AdministratorHomePage"
                            : role.equals("parents") ? "/Management/ParentsHomePage"
                            : role.equals("student") ? "/Management/StudentHomePage"
                            : "/Management/TeacherHomePage"%>"><img
                            class="navbar-brand"
                            id="logo"
                            src="<%= request.getContextPath()%>/imgs/logo_small.png"
                            alt="Hame Logo"
                            width="200px"
                            /></a>
                </div>

                <div id="school-name" class="col-sm-10 d-flex align-items-center ">
                    <h1 class="text-center" style="color: #003a5f; width: 100%">Welcome to ABC High School</h1>
                </div>
            </div>

            <!-- Menu -->
            <nav  style="padding: 0px ; margin-bottom: 0;"  class="navbar navbar-expand-lg navbar-light bg-light" >
                <div class="container-fluid justify-content-between">
                    <button
                        type="button"
                        class="navbar-toggler"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    
                    
                    <div
                        style="padding-top: 10px;" class="collapse navbar-collapse justify-content-between"
                        id="navbarCollapse"
                        >
                        <p >Hello,  <%=role.equals("admin") ? adc.getName()
                                : role.equals("parents") ? pa1.getName()
                                : role.equals("student") ? ra.getName()
                                : ra1.getName()%>  </p>                        
                        <div class="navbar-nav">
                            <a class="dropdown-item" href="<%=role.equals("admin") ? "/Management/AccountPage"
                                    : role.equals("parents") ? "/Management/AccountParentsPage"
                                    : role.equals("student") ? "/Management/AccountStudentPage"
                                    : "/Management/AccountTeacherPage"%>">My account</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/ChangpassPage">Change Password</a>
                            <a style="margin-left: 20px" class="dropdown-item" href=" <%=role.equals("admin") ? "/Management/AdministratorSignOut"
                                    : role.equals("parents") ? "/Management/ParentsSignOut"
                                    : role.equals("student") ? "/Management/StudentSignOut"
                                    : "/Management/TeacherSignOut"%>"> Sign out</a>
                        </div>
                    </div>
                </div>
            </nav>
                        
                        
                        
        </header>
        <h2  class="h2">Change Password</h2>

        <form action="/Management" method="post">
            <div>
                <label for="new_password">Old Password:</label>
                <input type="password" id="old_password" name="old_password" value="" required  title="Please enter letters and spaces only">
            </div>
            <div>
                <label for="new_password">New Password:</label>
                <input type="password" id="new_password" name="new_password" required>
            </div>
            <div>
                <label for="confirm_password">Confirm New Password:</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
            </div>
            <button type="submit" name="btn_submit" value="submit">Change Password</button>
            <%
                String samepass = (String) request.getSession().getAttribute("samepass");
                String samepass1 = (String) request.getSession().getAttribute("samepass1");
                //String samepass11 = (String) request.getSession().getAttribute("samepass11");
                String samepass111 = (String) request.getSession().getAttribute("samepass111");
                if (samepass != null) {
            %>

            <small class="small"> <%= samepass%>  </small>

            <%
                request.getSession().removeAttribute("samepass");
            } else if (samepass1 != null) {
            %>

            <small class="small"> <%= samepass1%>  </small>
            <%
                request.getSession().removeAttribute("samepass1");

            } else if (samepass111 != null) {
            %>
            <small class="small"> <%= samepass111%>  </small>
            <%
                    request.getSession().removeAttribute("samepass111");
                }
            %>
        </form>
    </body>
</html>


