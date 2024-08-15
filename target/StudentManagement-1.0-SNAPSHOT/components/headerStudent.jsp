<%-- 
    Document   : headerStudent
    Created on : Mar 15, 2024, 4:13:06 PM
    Author     : admin
--%>

<%@page import="Model.Student"%>
<%@page import="DAOs.StudentDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <%@include  file="../components/headStudent.jsp" %>
    </head>
    <body>
        <header>
            <div class="d-flex row">
                <div class="col-sm-2">
                    <a href="/Management/StudentHomePage"><img
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
            <%
                String phone_number = "";
                Cookie[] cList = request.getCookies();
                if (cList != null) {
                    for (Cookie c : cList) {
                        if (c.getName().equals("Student")) {
                            phone_number = c.getValue();
                            break;
                        }
                    }
                }
                StudentDAO ad = new StudentDAO();
                Student adc = ad.getInfostudent(phone_number);
            %>

            <nav class="navbar navbar-expand-lg navbar-light bg-light" >
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
                        class="collapse navbar-collapse justify-content-between"
                        id="navbarCollapse"
                        >
                        <p style="margin: 0">Hello <%= adc.getName()%>  </p>                        
                        <div class="navbar-nav">
                            <a class="dropdown-item" href="/Management/AccountStudentPage">My account</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/ChangpassPage">Change Password</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/StudentSignOut"> Sign out</a>
                        </div>
                    </div>
                </div>
            </nav>

        </header>
    </body>
</html>
