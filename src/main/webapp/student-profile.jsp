<%-- 
    Document   : student-profile
    Created on : Mar 19, 2024, 12:16:10 AM
    Author     : admin
--%>

<%@page import="Model.Teacher"%>
<%@page import="DAOs.TeacherDAO"%>
<%@page import="Model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        <style>

            .d-flex {
                display: flex;
                justify-content: space-around;
                align-items: center;
            }
            
            .nav-link {
                color: white;
            }

            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .container {
                width: 50%;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="date"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-sizing: border-box;
            }

            input[type="radio"] {
                margin-right: 5px;
            }

            button[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 3px;
                cursor: pointer;
            }

            button[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <header style="background-color: #003a5f">
            <%
                String phone_number = "";
                Cookie[] cList = request.getCookies();
                if (cList != null) {
                    for (Cookie c : cList) {
                        if (c.getName().equals("Teacher")) {
                            phone_number = c.getValue();
                            break;
                        }
                    }
                }

                TeacherDAO ad = new TeacherDAO();
                Teacher adc = ad.getInfoteacher(phone_number);
            %>
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light" >
                <div class="container-fluid justify-content-between">
                    <a href="/Management/TeacherHomePage">
                        <img
                            class="navbar-brand"
                            id="logo"
                            src="<%= request.getContextPath()%>/imgs/logo_small.jpg"
                            alt="Hame Logo"
                            style="width: 60px; border-radius: 15%"
                            />
                    </a>
                    <button
                        type="button"
                        class="navbar-toggler"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div
                        class="collapse navbar-collapse justify-content-between"
                        id="navbarCollapse"
                        >                        
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a
                                    class="nav-link dropdown-toggle"
                                    data-bs-toggle="dropdown"
                                    href=""
                                    >Hello, <%=adc.getName()%></a
                                >
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="/Management/AccountTeacherPage"
                                           >My account</a
                                        >
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/Management/ChangpassPage"
                                           >Change Password</a
                                        >
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/Management/TeacherSignOut"
                                           >Sign out</a
                                        >
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <%
            Student student = (Student) session.getAttribute("student");
        %>

        <h4 class="d-flex mt-5"><i class="fa fa-user" aria-hidden="true"> Information of <%=student.getName()%></i></h4>
        <div class="container">
            <form action="AddScore" method="post">

                <div class="form-group">
                    <label for="id">ID:</label>
                    <input  type="text" id="id" name="id" value="<%= student.getId()%>" readonly="">
                </div>

                <div class="form-group">
                    <label for="name">Name:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" type="text" id="name" name="name" value="<%= student.getName()%>">
                </div>
                <div class="form-group">
                    <label for="name">Email:</label>
                    <input pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Please enter a valid email address" type="text" id="email" name="email" value="<%=student.getEmail()%>" >
                    <%
                        String dEmail = (String) session.getAttribute("duplicateEmail");
                        if (dEmail != null) {
                    %>
                    <div style="color: red;">Email already exists  </div>
                    <%                session.removeAttribute("duplicateEmail");
                        }
                    %>
                </div>

                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required="" type="text" id="phone" name="phone" value="<%=student.getPhone_number()%>" >
                    <%
                        String dPhone = (String) session.getAttribute("duplicatePhone");
                        if (dPhone != null) {

                    %>
                    <div style="color: red;">Phone already exists  </div>
                    <%                session.removeAttribute("duplicatePhone");
                        }
                    %>
                </div>
                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <input type="radio"  name="gender" value="Male" <% if (student != null && student.getGender().equals("Male")) { %> checked <% } %>> Male
                    <input type="radio"  name="gender" value="Female" <% if (student != null && student.getGender().equals("Female")) { %> checked <% }%>> Female
                </div>
                <div class="form-group">
                    <label for="birthday">Birthday:</label>
                    <input max="YYYY-MM-DD" title="Please enter a valid date of birth" required="" type="date" id="birthday" name="birthday" value="<%=student.getBirthday()%>">
                </div>
                <div class="form-group">    
                    <label for="address">Address:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required="" type="text" id="address" name="address" value="<%=student.getAddress()%>">
                </div>
                <button type="submit" name="submitEdit" value="submitEdit">Submit </button>
            </form>
        </div>
    </body>
</html>
