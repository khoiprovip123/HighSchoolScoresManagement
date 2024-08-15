<%-- 
    Document   : myaccount
    Created on : Mar 4, 2024, 12:12:29 AM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="Model.Administrator"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@include  file="components/head.jsp" %>
    </head>

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


    <body>
        <%@include  file="components/header.jsp" %>

        <%            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Administrator")) {
                        phone_number = c.getValue();
                        break;
                    }
                }
            }
            AdministratorDAO pDAO = new AdministratorDAO();
            ResultSet rs = pDAO.getAll(phone_number);
            AdministratorDAO dDAO = new AdministratorDAO();
            Administrator ra = dDAO.getInfo(phone_number);

            while (rs.next()) {
        %>

        <h2 class="h2-student">Information of <%= ra.getName()%></h2>
        <form action="/Management" method="POST">
            <label for="value1">Phone_Number:</label><br>
            <input type="text" id="value1" name="phone_number" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" value="<%= rs.getString(1)%>"><br>

            <label for="value2">Email:</label><br>
            <input type="email" id="value2" name="email" value="<%= rs.getString(2)%>" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required><br>
            <%
                String emailFail = (String) request.getSession().getAttribute("emailFail");
                if (emailFail != null) {
            %>
            <small class="small" style="margin-bottom: 10px; "> <%= emailFail%> </small>
            <%
                    request.getSession().removeAttribute("emailFail");
                }
            %>
            <label for="value3">Name:</label><br>
            <input type="text" id="value3" name="name" value="<%= rs.getString(4)%>"pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" required><br>

            <label for="female">Gender:</label>
            <div class="radio-container">
                <input type="radio" id="female" name="gender" value="Female" <%=rs.getString(5).equalsIgnoreCase("Female") ? "checked" : ""%>>
                <label for="female">Female</label>
            </div>

            <div class="radio-container">
                <input type="radio" id="male" name="gender" value="Male" <%=rs.getString(5).equalsIgnoreCase("Male") ? "checked" : ""%>>
                <label for="male">Male</label>
            </div>

            <label for="value5">Birthday:</label><br>
            <input type="date" id="value5" name="birthday" value="<%= rs.getString(6)%>" max="YYYY-MM-DD" title="Please enter a valid date of birth" ><br>
            <%
                String invalidDay = (String) request.getSession().getAttribute("invalidDay");
                if (invalidDay != null) {
            %>
            <small class="small">   <%= invalidDay%>  </small>
            <%
                    request.getSession().removeAttribute("invalidDay");

                }
            %>

            <label for="value6">Address:</label><br>
            <input type="text" id="value6" name="address" value="<%= rs.getString(7)%>" pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required><br>


            <button id="btnSave" type="submit" name="submit_saveAdmin">Save</button>
        </form>

        <%
            }
        %>
    </body>
</html>
