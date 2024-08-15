<%-- 
    Document   : add-student
    Created on : Mar 14, 2024, 12:42:42 AM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/head.jsp" %>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 70%;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
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

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
                font-size: 16px;
            }

            .error-message {
                color: red;
                margin-top: 5px;
            }

            button {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            button:hover {
                background-color: #0056b3;
            }

        </style>
        <style>
            .toggleButton {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }

            .toggleButton input[type="checkbox"] {
                display: none;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
                border-radius: 34px;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
                border-radius: 50%;
            }

            input[type="checkbox"]:checked + .slider {
                background-color: #2196F3;
            }

            input[type="checkbox"]:checked + .slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }

            .inline-forms {
                display: flex;
                flex-direction: row;
                align-items: center;
                margin: 30px 0;
            }

            .inline-forms form {
                margin-right: 10px; /* Adjust margin as needed */
            }
        </style>

    </head>

    <body>

        <%@include file="components/header.jsp" %>


        <%                  Student oldData = (Student) session.getAttribute("oldStudent");
            session.removeAttribute("oldStudent");
        %>
        <div class="container">
            <h2>Add New Student</h2>
            <form action="AdminController" method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" type="text" id="name" name="name" value="<%= (oldData != null) ? oldData.getName() : ""%>" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= (oldData != null) ? oldData.getEmail() : ""%>" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Please enter a valid email address" required>
                    <% String dEmail = (String) session.getAttribute("duplicateEmail");
                        if (dEmail != null) { %>
                    <div class="error-message">Email already exists</div>
                    <% session.removeAttribute("duplicateEmail");
                        }%>
                </div>

                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" required>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="birthday">Birthday:</label>
                    <input type="date" id="birthday" name="birthday" value="<%= (oldData != null) ? oldData.getBirthday() : ""%>" max="YYYY-MM-DD" title="Please enter a valid date of birth" required="">
                    <% String validDay = (String) session.getAttribute("invalidDay");
                        if (validDay != null) { %>
                    <div class="error-message">Day not valid</div>
                    <% session.removeAttribute("invalidDay");
                        }%>
                </div>

                <div class="form-group">
                    <label for="phone_number">Phone Number:</label>
                    <input type="text" id="phone_number" name="phone" value="<%= (oldData != null) ? oldData.getPhone_number() : ""%>" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required>
                    <% String dPhone = (String) session.getAttribute("duplicatePhone");
                        if (dPhone != null) { %>
                    <div class="error-message">Phone already exists</div>
                    <% session.removeAttribute("duplicatePhone");
                        }%>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= (oldData != null) ? oldData.getAddress() : ""%>" pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required>
                </div>

                <button type="submit" name="addStudent">Add Student</button>
            </form>
        </div>

    </body>
</html>
