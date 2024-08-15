<%-- 
    Document   : list-student-homeroom
    Created on : Mar 19, 2024, 12:19:15 AM
    Author     : admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Model.Teacher"%>
<%@page import="DAOs.TeacherDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable({
                    "pageLength": 50
                });
            });
        </script>
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
            .btn-edit {
                text-decoration: none;
                color: white;
                background-color: green;
                padding: 5px 10px;
                border-radius: 5px;
            }
            .d-flex {
                display: flex;
                justify-content: space-around;
                align-items: center;
            }

            #example_filter {
                margin-bottom: 10px;
            }

            .input-group {
                margin-right: 10px;
            }

            .nav-link {
                color: white;
            }

            .nav-link:hover {
                text-decoration: underline;
                color: white;
            }

            .nav-link:active {
                color: white;
            }

            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
            }

            th, td {
                padding: 10px;
            }

            table#example tr:nth-child(even) {
                background-color: #eee;
            }

            table#example tr:nth-child(odd) {
                background-color: #fff;
            }

            table#example th {
                color: white;
                background-color: gray;
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
            String classes = (String) session.getAttribute("homeroom");
            TeacherDAO tDAO = new TeacherDAO();
            if (!classes.equals("false")) {
                ResultSet rsStudent = tDAO.getStudentInClass(classes);
        %>

        <h2 class="d-flex mt-3"> <i class="fa fa-users" aria-hidden="true"> List Homeroom</i></h2>
        <table id="example">
            <thead>
                <tr>
                    <th>ID Student</th>
                    <th>Phone Number</th>
                    <th>Email</th>               
                    <th>Name</th>
                    <th>Gender</th>
                    <th>Birthday</th>
                    <th>Address</th>    
                    <th></th>
                </tr>
            </thead>

            <tbody>
                <%
                    while (rsStudent.next()) {
                %>
                <tr>
                    <td><%=rsStudent.getString("id")%></td>
                    <td><%=rsStudent.getString("phone_number")%></td>
                    <td><%=rsStudent.getString("email")%></td>
                    <td><%=rsStudent.getString("name")%></td>
                    <td><%=rsStudent.getString("gender")%></td>
                    <td><%=rsStudent.getDate("birthday")%></td>
                    <td><%=rsStudent.getString("address")%></td>
                    <td>
                        <a class="btn-edit" href="/AddScore/edit/<%=rsStudent.getString("id")%>">Edit</a>  
                    </td>
                </tr>

                <%
                    }
                %>
            </tbody>
        </table>

        <%
        } else {
        %>
        <p>Bạn chưa có lớp chủ nhiệm nên không thể xem báo cao điểm!!</p>
        <%
            }
        %>
    </body>
</html>
