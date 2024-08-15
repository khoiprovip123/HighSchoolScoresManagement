<%-- 
    Document   : add-teacher
    Created on : Mar 5, 2024, 9:47:17 AM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="java.io.DataInput"%>
<%@page import="Model.Teacher1"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
            }

            form {
                max-width: 70%;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .form-group input[type="text"],
            .form-group input[type="date"] {
                width: calc(100% - 10px);
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .form-group input[type="radio"] {
                margin-top: 5px;
                margin-right: 5px;
            }

            button {
                width: 100%;
                background-color: #007bff;
                color: white;
                padding: 14px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #2196F3;
            }
        </style>

    </head>
    
   
    <body>
        <header>
          <%@include  file="components/header.jsp" %>
         </header>
          <h2 style="text-align:  center ">Add New Teacher</h2>

        <%
            Teacher1 oldData = (Teacher1) session.getAttribute("oldDataAdd");
            session.removeAttribute("oldDataAdd");
        %>
        <form action="AdminController" method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" required type="text" id="name" name="name" value="<%= (oldData != null) ? oldData.getName() : ""%>">
            </div>
            <div class="form-group">
                <label for="name">Email:</label>
                <input pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Please enter a valid email address" type="text" id="email" name="email" value="<%= (oldData != null) ? oldData.getEmail() : ""%>">
                <%
                    String dEmail = (String) session.getAttribute("duplicateEmail");
                    if (dEmail != null) {

                %>
                <div style="color: red;">Email already exists  </div>
                <%                session.removeAttribute("duplicateEmail");
                    }
                %>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= (oldData != null) ? oldData.getPhone() : ""%>" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required>
                <%
                    String dPhone = (String) session.getAttribute("duplicatePhone");
                    if (dPhone != null) {

                %>
                <div style="color: red;">Phone already exists  </div>
                <%                session.removeAttribute("duplicatePhone");
                    }
                %>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <input type="radio" id="gender" name="gender" value="Male" <% if (oldData != null && oldData.getGender().equals("Male")) { %> checked <% } %>> Male
                <input type="radio" id="gender" name="gender" value="Female" <% if (oldData != null && oldData.getGender().equals("Female")) { %> checked <% }%>> Female
            </div>
            <div class="form-group">
                <label for="birthday">Birthday:</label>
                <input type="date" id="birthday" name="birthday" value="<%= (oldData != null) ? oldData.getBirthday() : ""%>" max="YYYY-MM-DD" title="Please enter a valid date of birth" required="">
                <% String validDay = (String) session.getAttribute("invalidDay");
                    if (validDay != null) { %>
                <div style="color: " class="error-message">Day not valid</div>
                <% session.removeAttribute("invalidDay");
                    }%>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= (oldData != null) ? oldData.getAddress() : ""%>" pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required>
            </div>
            <button type="submit" name="submitAdd" value="submitAdd">Submit </button>
        </form>

    </body>
</html>
