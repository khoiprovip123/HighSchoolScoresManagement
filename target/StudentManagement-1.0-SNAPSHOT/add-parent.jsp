<%-- 
    Document   : add-parent
    Created on : Mar 15, 2024, 4:36:08 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="Model.Parents"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/head.jsp" %>
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            margin-top: 5px;
        }
    </style>
    <body>
        <%@include file="components/header.jsp" %>
        <% Parents oldData = (Parents) session.getAttribute("oldParent");
            session.removeAttribute("oldParent");
        %>
        <div class="container">
            <h2>Add New Parent</h2>
            <form action="AdminController" method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" type="text" id="name" name="name" value="<%= (oldData != null) ? oldData.getName() : ""%>" required>
                </div>

                <div class="form-group">
                    <label for="phone_number">Phone Number:</label>
                    <input type="text" id="phone_number" name="phone" value="<%= (oldData != null) ? oldData.getPhone_number() : ""%>" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required>
                    <% String dPhone = (String) session.getAttribute("existPhone");
                        if (dPhone != null) { %>
                    <div class="error-message">Phone already exists</div>
                    <% session.removeAttribute("existPhone");
                        }%>
                </div>

                <div class="form-group">
                    <label for="role">Role:</label>
                    <select id="role" name="role" required>
                        <option value="Mother">Mother</option>
                        <option value="Father">Father</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="job">Job:</label>
                    <input  pattern="[a-zA-Z0-9\s]+" title="Please enter letters and spaces only" value="<%= (oldData != null) ? oldData.getJob() : ""%>" type="text" id="job" name="job" required>
                </div>

                <div class="form-group">
                    <label for="student_id">Student ID:</label>
                    <input pattern="[0-9]+" title="Please enter numbers only" value="<%= (oldData != null) ? oldData.getStudent_id() : ""%>" type="text" id="student_id" name="student_id" required>
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


                <button type="submit" value="addParent" name="addParent">Add Parent</button>
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
