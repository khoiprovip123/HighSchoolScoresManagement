<%-- 
    Document   : parents_homePage
    Created on : Feb 28, 2024, 4:24:50 PM
    Author     : Admin
--%>

<%@page import="DAOs.ParentsDAO"%>
<%@page import="Model.Parents"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include  file="components/headParent.jsp" %>
    </head>

    <body>  
        <header>
        <%@include  file="components/headerParent.jsp" %>

        </header>

        <main class="container">
            <div class="row mt-5">
                <div class="col-sm-12 col-md-6 text-center">
                    <img src="<%= request.getContextPath()%>/imgs/score.png" width="200px" >
                    <a href="/student/report" style ="text-decoration: none">
                        <p  style="color: #003a5f">Study Result</p>
                    </a>
                </div>
                <div class="col-sm-12 col-md-6 text-center">
                    <img src="<%= request.getContextPath()%>/imgs/student.png" width="200px" >
                    <a href="/Management/AccountParentsPage" style="text-decoration: none">
                        <p style="color: #003a5f">Student Profile</p>
                    </a>
                </div>

            </div>
        </main>
    </body>
</html>
