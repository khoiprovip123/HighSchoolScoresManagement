<%-- 
    Document   : admin_homePage
    Created on : Feb 28, 2024, 8:22:29 AM
    Author     : Admin
--%>

<%@page import="Model.Administrator"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include  file="components/head.jsp" %>
    </head>

    <body>
        <header>
                   <%@include  file="components/header.jsp" %>

        </header>
        <main class="container">
            <div class="row mt-5">
                <a style="text-decoration: none" class="col-sm-12 col-md-6 col-lg-4 text-center" href="/admin/teacher-management">
                    <img src="<%= request.getContextPath()%>/imgs/teacher.png" width="200px" >
                    <p style="color: #003a5f">Teacher Management</p>
                </a>
                <a style="text-decoration: none" class="col-sm-12 col-md-6 col-lg-4 text-center" href="/admin/student-look-up">
                    <img src="<%= request.getContextPath()%>/imgs/student.png" width="200px" >
                    <p style="color: #003a5f">List of students</p>
                </a>
                <a style="text-decoration: none" class="col-sm-12 col-md-6 col-lg-4 text-center" href="/admin/class-management">
                    <img src="<%= request.getContextPath()%>/imgs/class.png" width="200px" >
                    <p style="color: #003a5f">Classes Management</p>
                </a>

            </div>
            <div class="row mt-5">
                <a href="/admin/subject-management" style="text-decoration: none" class="col-sm-12 col-md-6 col-lg-4 text-center" >
                    <img src="<%= request.getContextPath()%>/imgs/subject.png" width="200px" >
                    <p style="color: #003a5f">List of subjects</p>
                </a> 
                <a href="/admin/statistical" style="text-decoration: none" class="col-sm-12 col-md-6 col-lg-4 text-center" >
                    <img src="<%= request.getContextPath()%>/imgs/statistic.png" width="200px" >
                    <p style="color: #003a5f">Statistical</p>
                </a>
                <a href="/admin/parent-management" style="text-decoration: none" class="col-sm-12 col-md-6 col-lg-4 text-center" >
                    <img src="<%= request.getContextPath()%>/imgs/icons8-parent-100.png" width="200px" >
                    <p style="color: #003a5f">Parent</p>
                </a>
            </div>


        </main>

    </body>
</html>
