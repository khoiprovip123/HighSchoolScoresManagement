<%-- 
    Document   : header
    Created on : Mar 4, 2024, 9:44:16 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Model.Administrator"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../components/head.jsp" %>
    </head>
    <body>
        <header class="container-fluid">
            <div class="d-flex row">
                <div class="col-sm-2">
                    <a href="/Management/AdministratorHomePage"><img
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
                        if (c.getName().equals("Administrator")) {
                            phone_number = c.getValue();
                            break;
                        }
                    }
                }
                AdministratorDAO ad = new AdministratorDAO();
                Administrator adc = ad.getInfo(phone_number);
            %>
            <!-- Menu -->
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
                        <p style="margin: 0">Hello,  <%= adc.getName()%>  </p>                        
                        <div class="navbar-nav">
                            <a class="dropdown-item" href="/Management/AccountPage">My account</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/ChangpassPage">Change Password</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/AdministratorSignOut"> Sign out</a>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
    </body>
</html>
