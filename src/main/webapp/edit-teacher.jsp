<%-- 
    Document   : edit-teacher
    Created on : Mar 6, 2024, 4:10:18 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Model.Teacher1"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .container {
                width: 50%;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="date"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-sizing: border-box;
            }

            input[type="radio"] {
                margin-right: 5px;
            }

            button[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 3px;
                cursor: pointer;
            }

            button[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <%
            Teacher1 teacher = (Teacher1) session.getAttribute("teacher");
        %>
        <div class="container">
            <form action="AdminController" method="post">

                <div class="form-group">
                    <label for="id">ID:</label>
                    <input  type="text" id="id" name="id" value="<%= teacher.getId()%>" readonly="">
                </div>

                <div class="form-group">
                    <label for="name">Name:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" type="text" id="name" name="name" value="<%= teacher.getName()%>">
                </div>
                <div class="form-group">
                    <label for="name">Email:</label>
                    <input pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Please enter a valid email address" type="text" id="email" name="email" value="<%=teacher.getEmail()%>" >
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
                    <input pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required="" type="text" id="phone" name="phone" value="<%=teacher.getPhone()%>" >
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
                    <input type="radio"  name="gender" value="Male" <% if (teacher != null && teacher.getGender().equals("Male")) { %> checked <% } %>> Male
                    <input type="radio"  name="gender" value="Female" <% if (teacher != null && teacher.getGender().equals("Female")) { %> checked <% }%>> Female
                </div>
                <div class="form-group">
                    <label for="birthday">Birthday:</label>
                    <input max="YYYY-MM-DD" title="Please enter a valid date of birth" required="" type="date" id="birthday" name="birthday" value="<%=teacher.getBirthday()%>">
                </div>
                <div class="form-group">    
                    <label for="address">Address:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required="" type="text" id="address" name="address" value="<%=teacher.getAddress()%>">
                </div>
                <button type="submit" name="submitEdit" value="submitEdit">Submit </button>
            </form>
        </div>
    </body>
</html>
