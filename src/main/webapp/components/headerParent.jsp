<%-- 
    Document   : headerParent
    Created on : Mar 15, 2024, 5:41:02 PM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="Model.Parents"%>
<%@page import="DAOs.ParentsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="../components/headParent.jsp" %>
    </head>
    <body>
        <header>
            <div class="d-flex row">
                <div class="col-sm-2">
                    <a href="/Management/ParentsHomePage"><img
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
                        if (c.getName().equals("Parents")) {
                            phone_number = c.getValue();
                            break;
                        }
                    }
                }
                ParentsDAO ad = new ParentsDAO();
                Parents adc = ad.getInfoparent(phone_number);
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
                            <a class="dropdown-item" href="/Management/AccountParentsPage">My account</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/ChangpassPage">Change Password</a>
                            <a style="margin-left: 20px" class="dropdown-item" href="/Management/ParentsSignOut"> Sign out</a>
                        </div>
                    </div>
                </div>
            </nav>

        </header>
    </body>
</html>
