<%-- 
    Document   : student_homePage
    Created on : Feb 28, 2024, 3:12:31 PM
    Author     : Admin
--%>

<%@page import="DAOs.StudentDAO"%>
<%@page import="Model.Student"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include  file="components/headStudent.jsp" %>
    </head>

    <body >
        
        <header class="container-fluid"> 
            <%@include  file="components/headerStudent.jsp" %>

        </header>

        <main class="container">
            <div class="row mt-5">
                <div class="col-sm-12 col-md-6 text-center">

                    <a style="text-decoration: none "  class="col-sm-12 col-md-6  text-center" href="/student/report">
                        <img src="<%= request.getContextPath()%>/imgs/score.png" width="200px" style="background-color: white"  >
                        <p style="color: 003a5f" >Study Result</p>
                    </a>
                </div>
                <div class="col-sm-12 col-md-6 text-center">
                    <a style="text-decoration: none "  class="col-sm-12 col-md-6  text-center" href="">
                        <img src="<%= request.getContextPath()%>/imgs/score.png" width="200px" style="background-color: white"  >
                        <p style="color: 003a5f" >Report</p>
                    </a>
                </div>
            </div>
        </main>

        <footer>

        </footer>
    </body>
</html>
