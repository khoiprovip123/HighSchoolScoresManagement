<%-- 
    Document   : list-student
    Created on : Mar 4, 2024, 9:26:38 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="DAOs.StudentDAO1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.StudentDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="components/head.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            .button-1 a{
                text-decoration: none;
            }
            .button-1 {
                background-color: blue;
                border-radius: 8px;
                border-style: none;
                box-sizing: border-box;
                cursor: pointer;
                display: inline-block;
                font-family: "Haas Grot Text R Web", "Helvetica Neue", Helvetica, Arial, sans-serif;
                font-size: 14px;
                font-weight: 500;
                height: 40px;
                line-height: 20px;
                list-style: none;
                margin: 0;
                outline: none;
                padding: 10px 16px;
                position: relative;
                text-align: center;
                text-decoration: none;
                transition: color 100ms;
                vertical-align: baseline;
                user-select: none;
                -webkit-user-select: none;
                touch-action: manipulation;
                margin-bottom: 20px;
                margin-top: 10px;
            }

            .button-1:hover,
            .button-1:focus {
                background-color: #F082AC;
            }
        </style>
    </head>
    <body>
        <%@include file="components/header.jsp" %>

        <button class="button-1" role="button">  <a href="/admin/student-look-up/add-student" style="color: white"> Add new student</a></button>

        <div id="table">
            <table id="example">
                <thead>
                    <tr>
                        <th>ID Student</th>
                        <th>Phone Number</th>
                        <th>Email</th>               
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Birthday</th>
                        <th>Address</th>    
                        <th>Status</th>                     
                    </tr>
                </thead>

                <tbody>
                    <%                    StudentDAO1 tDAO = new StudentDAO1();
                        ResultSet rs = tDAO.getAll();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("id")%></td>
                        <td><%= rs.getString("phone_number")%></td>
                        <td><%= rs.getString("email")%></td>             
                        <td><%= rs.getString("name")%></td>
                        <td><%= rs.getString("gender")%></td>
                        <td><%= rs.getString("birthday")%></td>
                        <td><%= rs.getString("address")%></td>
                        <td>

                            <form id="statusForm_<%= rs.getString("id")%>" action="AdminController" method="post">
                                <input type="hidden" name="actionActive" value="updateStatus">
                                <input type="hidden" name="id" value="<%= rs.getString("id")%>">
                                <input type="hidden" name="status" id="status_<%= rs.getString("id")%>" value="<%= rs.getBoolean("status") ? '1' : '0'%>">
                                <label class="toggleButton" for="statusCheckbox_<%= rs.getString("id")%>">
                                    <input type="checkbox" id="statusCheckbox_<%= rs.getString("id")%>" onchange="toggleStatus(<%= rs.getString("id")%>)" <%= rs.getBoolean("status") ? "checked" : ""%>>
                                    <span class="slider"></span>
                                </label>
                            </form>
                        </td>           
                    </tr>
                    <%                        }
                    %>

                <script>
                    function toggleStatus(studentId) {
                        var checkbox = document.getElementById("statusCheckbox_" + studentId);
                        var status = checkbox.checked ? "1" : "0";
                        var xhr = new XMLHttpRequest();
                        var url = "AdminController";
                        var params = "actionStatus=updateStatus&studentId=" + studentId + "&status=" + status;

                        xhr.open("POST", url, true);
                        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                        xhr.onreadystatechange = function () {
                            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                                console.log(xhr.responseText);
                            }
                        };
                        xhr.send(params);
                    }
                </script>
                </tbody>    
            </table>
        </div>
    </body>
</html>
