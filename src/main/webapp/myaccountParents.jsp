<%-- 
    Document   : myaccountTeacher
    Created on : Mar 4, 2024, 1:02:58 AM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="DAOs.ParentsDAO"%>
<%@page import="Model.Parents"%>
<%@page import="Model.Teacher"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/style.css"/>
        <title>Parent</title>
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
            form {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            label {
                font-weight: bold;
            }

            input[type="text"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="number"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="date"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="email"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                padding: 10px 20px;
                background-color: #4caf50;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            button:hover {
                background-color: #45a049;
            }

            /* Các phần tử cụ thể cho từng biểu mẫu */
            #parentForm {
                margin-bottom: 30px;
            }

            #studentForm {
                margin-top: 30px;
            }
            .h2-parent{
                text-align: center;
            }
            .h2-student{
                text-align: center;
            }
            .small {
                display: block;
                font-size: 14px; /* Kích thước chữ */
                color: red; /* Màu chữ */
            }
        </style>

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
        <%
    
            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Parents")) {
                        phone_number = c.getValue();
                        break;
                    }
                }
            }

            ParentsDAO dDAO = new ParentsDAO();

            ParentsDAO pDAO = new ParentsDAO();
            ResultSet rs = pDAO.getAllparents(phone_number);
            Parents ra = dDAO.getInfoparent(phone_number);

            while (rs.next()) {
        %>
        <h2 class="h2-parent">Information of <%= ra.getName()%> </h2>        

        <form action="/Management/" method="POST">
            <label for="pro_id">ID:</label><br>
            <input id="pro_id" type="number" name="parentID" value="<%= rs.getInt(1)%>" readonly=""/>

            <label for="value4">Phone_number:</label><br>
            <input type="text" id="value4" name="phone_parent" value=" <%=rs.getString(2)%>" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" readonly=""><br>

            <label for="value1">Name:</label><br>
            <input type="text" id="value1" name="name_parent" value="<%=rs.getString(4)%>"pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" required=""><br>

            <label for="value2">Role:</label><br>
            <input type="text" id="value2" name="role_parent" value="<%=rs.getString(5)%>" pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" required="" ><br>

            <label for="value3">Job:</label><br>
            <input type="text" id="value3" name="job_parent" value="<%=rs.getString(6)%>" pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only"  required=""><br>
              <label for="value3">Status</label><br>
            <input type="text" id="value3" name="job_parent" value="<%=rs.getString(8)%>" pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" readonly="" required=""><br>
            <button id="btnSave" type="submit" name="submit_saveParent">Save</button>       
        </form>

        <h2 class="h2-student">Student  </h2>
        <form action="/Management/" method="POST">
            <label for="pro_id">ID:</label><br>
            <input id="pro_id" type="number" name="teacherID" value="<%= rs.getInt(9)%>" readonly=""/>

            <label for="value1">Email:</label><br>
            <input type="email" id="value1" name="email_student" value="<%=rs.getString(10)%>" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required><br>
            <%
                String emailFail = (String) request.getSession().getAttribute("emailFailStudent");
                if (emailFail != null) {
            %>
            <small class="small"> <%= emailFail%> </small>
            <%
                    request.getSession().removeAttribute("emailFailStudent");

                }
            %>
            <label for="value2">Name:</label><br>
            <input type="text" id="value2" name="name_student" value="<%=rs.getString(12)%>" pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" required=""><br>

            <label for="female">Gender:</label>
            <div class="radio-container">
                <input type="radio" id="female" name="gender_student" value="Female" <%=rs.getString(13).equalsIgnoreCase("Female") ? "checked" : ""%>>
                <label for="female">Female</label>
            </div>

            <div class="radio-container">
                <input type="radio" id="male" name="gender_student" value="Male" <%=rs.getString(13).equalsIgnoreCase("Male") ? "checked" : ""%>>
                <label for="male">Male</label>
            </div>
            <label for="value4">Birthday:</label><br>
            <input type="date" id="value4" name="birthday_student" value="<%=rs.getString(14)%>" max="YYYY-MM-DD" title="Please enter a valid date of birth" ><br>
            <%
                String invalidDay = (String) request.getSession().getAttribute("invalidDay");
                if (invalidDay != null) {
            %>
            <small class="small">   <%= invalidDay%>  </small>
            <%
                    request.getSession().removeAttribute("invalidDay");

                }
            %>

            <label for="value2">Phone_number of student:</label><br>
            <input type="text" id="value2" name="phone_student" value="<%=rs.getString(15)%> " pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required="" readonly=""><br>

            <label for="value3">Address:</label><br>
            <input type="text" id="value3" name="address_student" value="<%=rs.getString(16)%>"  pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required=""><br>

            <label for="value4">Status:</label><br>
            <input type="text" id="value4" name="status_student" value="<%=rs.getString(17)%>" readonly="" required=""><br>

            <button id="btnSave" type="submit" name="submit_saveStudent">Save</button>
        </form>


        <%
            }
        %>

    </body>
</html>
