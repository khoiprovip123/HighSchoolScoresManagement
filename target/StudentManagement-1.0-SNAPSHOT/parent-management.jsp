<%-- 
    Document   : parent-management
    Created on : Mar 15, 2024, 3:33:22 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ParentsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/head.jsp" %>
    </head>
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
                color: black;
                text-decoration: none;
            }
            .button-1 {
                background-color: #EA4C89;
                border-radius: 8px;
                border-style: none;
                box-sizing: border-box;
                color: #FFFFFF;
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
    <body>
        <%@include file="components/header.jsp" %>
        <a  class="button-1"  href="/admin/parent-management/addnew">Add new parent</a>
        <div id="table">
            <table id="example">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phone Number</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Job</th>
                        <th>Children</th>
                        <th>Status</th>
                        <td>Options</td>
                    </tr>
                </thead>
                <tbody>
                    <%                ParentsDAO parentsDAO = new ParentsDAO();
                        ResultSet rs = parentsDAO.getAll();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("id")%></td>
                        <td><%= rs.getString("name")%></td>
                        <td><%= rs.getString("phone_number")%></td>            
                        <td><%= rs.getString("role")%></td>
                        <td><%= rs.getString("job")%></td>
                        <td><%= rs.getString("children")%></td>
                        <td>
                            <form id="statusForm_<%= rs.getString("id")%>" action="AdminController" method="post">
                                <input type="hidden" name="actionParent" value="updateStatusParent">
                                <input type="hidden" name="parentId" value="<%= rs.getString("id")%>">
                                <input type="hidden" name="status" id="status_<%= rs.getString("id")%>" value="<%= rs.getBoolean("status") ? '1' : '0'%>">
                                <label class="toggleButton" for="statusCheckbox_<%= rs.getString("id")%>">
                                    <input type="checkbox" id="statusCheckbox_<%= rs.getString("id")%>" onchange="toggleStatus(<%= rs.getString("id")%>)" <%= rs.getBoolean("status") ? "checked" : ""%>>
                                    <span class="slider"></span>
                                </label>
                            </form></td>
                        <td> <a href="/admin/parent-management/edit/<%=rs.getString("id")%>"><i class="bi bi-pencil-fill"></i></a> </td>
                    </tr>

                    <% }%>

                </tbody>
            </table>
        </div>

        <script>
            function toggleStatus(ParentId) {
                var checkbox = document.getElementById("statusCheckbox_" + ParentId);
                var status = checkbox.checked ? "1" : "0";
                var xhr = new XMLHttpRequest();
                var url = "AdminController";
                var params = "actionParent=updateStatusParent&parentId=" + ParentId + "&status=" + status;

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
    </body>
</html>
