<%-- 
    Document   : edit-parent
    Created on : Mar 19, 2024, 7:20:54 AM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Model.Parents"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="components/head.jsp" %>
        <style>
            /* Define your CSS styles here */
            .container {
                width: 50%; /* Adjust the width as needed */
                margin: 0 auto; /* Center the container horizontally */
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: inline-block;
                width: 120px; /* Adjust the width as needed */
                font-weight: bold;
            }

            input[type="text"],
            input[type="radio"] {
                width: 200px; /* Adjust the width as needed */
                padding: 5px;
                border-radius: 3px;
                border: 1px solid #ccc;
            }

            input[type="radio"] {
                width: auto;
                margin-right: 10px;
            }

            button {
                padding: 8px 15px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 3px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

            .error-message {
                color: red;
            }
        </style>
    </head>
    <body>
        <%@include file="components/header.jsp" %>
        <%
            Parents parent = (Parents) session.getAttribute("parent");
        %>
        <div class="container">
            <form action="AdminController" method="post">

                <div class="form-group">
                    <label for="id">ID:</label>
                    <input  type="text" id="id" name="id" value="<%= parent.getId()%>" readonly="">
                </div>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" type="text" id="name" name="name" value="<%= parent.getName()%>">
                </div>
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required="" type="text" id="phone" name="phone" value="<%=parent.getPhone_number()%>" >
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
                    <label for="gender">Role:</label>
                    <input type="radio"  name="role" value="Father" <% if (parent != null && parent.getRole().equals("Father")) { %> checked <% } %>> Male
                    <input type="radio"  name="role" value="Morther" <% if (parent != null && parent.getRole().equals("Morther")) { %> checked <% }%>> Female
                </div>

                <div class="form-group">    
                    <label for="address">Job:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required="" type="text" id="address" name="job" value="<%=parent.getJob()%>">
                </div>

                <div class="form-group">    
                    <label for="address">Children:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address" required="" type="text" id="student_id" name="child" value="<%=parent.getStudent_id()%>">
                    <button id="checkButton" type="button" onclick="checkStudent()">Check</button>
                    <div id="studentName"></div>
                    <%
                        String child = (String) session.getAttribute("existChild");
                        if (child != null) { %>
                    <div class="error-message">This student already has a parent</div>
                    <% session.removeAttribute("existChild");
                        }%>

                    <%
                        String childEx = (String) session.getAttribute("exist");
                        if (childEx != null) { %>
                    <div class="error-message">Student is not exist</div>
                    <% session.removeAttribute("exist");
                        }%>
                </div>
                <button type="submit" name="editParent" value="submitEdit">Submit </button>
            </form>
        </div>

        <script>
            function checkStudent() {
                var studentId = document.getElementById("student_id").value;
                var xhr = new XMLHttpRequest();
                var url = "AdminController";
                var params = "checkId=checkId&studentId=" + studentId;

                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.studentName) {
                            document.getElementById("studentName").textContent = "Student Name: " + response.studentName;
                        } else {
                            document.getElementById("studentName").textContent = "Student not found.";
                        }
                    }
                };
                xhr.send(params);
            }
        </script>

    </body>
</html>
