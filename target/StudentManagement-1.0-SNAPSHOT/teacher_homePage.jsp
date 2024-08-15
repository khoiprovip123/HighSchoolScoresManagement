<%-- 
    Document   : teacher_homePage
    Created on : Feb 28, 2024, 4:25:03 PM
    Author     : Admin
--%>

<%@page import="DAOs.TeacherDAO"%>
<%@page import="Model.Teacher"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include  file="components/headTeacher.jsp" %>
    </head>

    <body>
        <header>
            <%@include  file="components/headerTeacher.jsp" %>
        </header>

        <main class="container">
            <div class="row mt-5">
                <div class="col-sm-12 col-md-4  text-center">
                    <img src="<%= request.getContextPath()%>/imgs/class.png" width="200px" >
                    <a href="/AddScore" style="text-decoration: none"><p style="color: #003a5f" >Teaching classes</p></a>
                </div>

                <div class="col-sm-12 col-md-4  text-center">
                    <img src="<%= request.getContextPath()%>/imgs/teacher.png" width="200px" >
                    <a href="/AddScore/homeroom" style="text-decoration: none"><p style="color: #003a5f" >Homeroom class</p></a>
                </div>

                <div class="col-sm-12 col-md-4  text-center">
                    <img src="<%= request.getContextPath()%>/imgs/score.png" width="200px" >
                    <a href="/AddScore/reportScore" style="text-decoration: none"><p style="color: #003a5f">Report of score</p></a>
                </div>
            </div>
        </main>
    </body>
</html>
