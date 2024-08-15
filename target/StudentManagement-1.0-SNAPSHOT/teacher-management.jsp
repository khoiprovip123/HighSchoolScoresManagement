<%-- 
    Document   : teacher-management
    Created on : Mar 3, 2024, 1:39:51 PM
    Author     : La Hoang Khoi - CE171855
--%>


<%@page import="DAOs.TeacherDAO1"%>
<%@page import="DAOs.TeacherDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="components/head.jsp" %>
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
            }

            .button-1:hover,
            .button-1:focus {
                background-color: #F082AC;
            }
        </style>
    </head>
    <body>
        <%@include file="components/header.jsp" %>
        <div class="inline-forms">
            Score entry rights for all:     
            <form style="margin-left: 20px" id="openAllForm" action="AdminController" method="post">
                <input type="hidden" name="openAllPer" value="openAll">
                <button type="submit" class="toggleButton custom-button" id="openAllButton">Mở</button>
            </form> 
            <form id="closeAllForm" action="AdminController" method="post">
                <input type="hidden" name="closeAllPer" value="closeAll">
                <button type="submit" class="toggleButton custom-button" id="closeAllButton">Tắt</button>
            </form>
        </div>
        <button class="button-1" role="button"><a href="/admin/teacher-management/addnew" style="color: white">Add New Teacher</a></button>

        <div id="table">
            <table id="example">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phone Number</th>
                        <th>Email</th>               
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Birthday</th>
                        <th>Address</th>    
                        <th>Status</th>
                        <td>Score Permission</td>
                        <td>Options</td>
                    </tr>
                </thead>


                <tbody>
                    <%                    TeacherDAO1 tDAO = new TeacherDAO1();
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
                                <input type="hidden" name="teacherId" value="<%= rs.getString("id")%>">
                                <input type="hidden" name="status" id="status_<%= rs.getString("id")%>" value="<%= rs.getBoolean("status") ? '1' : '0'%>">
                                <label class="toggleButton" for="statusCheckbox_<%= rs.getString("id")%>">
                                    <input type="checkbox" id="statusCheckbox_<%= rs.getString("id")%>" onchange="toggleStatus(<%= rs.getString("id")%>)" <%= rs.getBoolean("status") ? "checked" : ""%>>
                                    <span class="slider"></span>
                                </label>
                            </form>
                        </td>
                        <td> 
                            <form id="toggleForm_<%= rs.getString("id")%>" action="AdminController" method="post">
                                <input type="hidden" name="action" value="scorePermission">
                                <input type="hidden" name="teacherId" value="<%= rs.getString("id")%>">
                                <input type="hidden" name="scorePermission" id="scorePermission_<%= rs.getString("id")%>" value="<%= rs.getString("entry_permission")%>">
                                <label class="toggleButton" for="toggleCheckbox_<%= rs.getString("id")%>">
                                    <input type="checkbox" id="toggleCheckbox_<%= rs.getString("id")%>" onchange="togglePermission(<%= rs.getString("id")%>)" <%= rs.getString("entry_permission").equals("1") ? "checked" : ""%>>
                                    <span class="slider"></span>
                                </label>
                            </form>
                            <%

                                //                            String entryPermission = rs.getString("entry_permission");
                                //                            if (entryPermission != null && entryPermission.equals("1")) {
                                //                                out.print("allow");
                                //                            } else {
                                //                                out.print("not allow");
                                //                            }
%>

                        </td>
                        <td> <a href="/admin/teacher-management/edit/<%=rs.getString("id")%>"><i class="bi bi-pencil-fill"></i></a> </td>
                    </tr>
                    <%                        }
                    %>

                </tbody>    
            </table>
        </div>
        <script>
            function togglePermission(teacherId) {
                var checkbox = document.getElementById("toggleCheckbox_" + teacherId);
                var scorePermission = checkbox.checked ? "1" : "0"; // Chuyển đổi giá trị của checkbox thành "1" hoặc "0"

                // Tạo một đối tượng XMLHttpRequest
                var xhr = new XMLHttpRequest();

                // Xác định phương thức và URL của request
                var url = "AdminController";
                var params = "action=updatePermission&teacherId=" + teacherId + "&scorePermission=" + scorePermission;

                // Mở kết nối với phương thức POST và URL đã xác định
                xhr.open("POST", url, true);

                // Cài đặt tiêu đề của request
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

                // Xử lý sự kiện khi request hoàn thành
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                        // Xử lý phản hồi từ servlet (nếu cần)
                        console.log(xhr.responseText);
                    }
                };

                // Gửi request với dữ liệu được định dạng
                xhr.send(params);
            }
        </script>

        <script>
            function toggleStatus(teacherId) {
                var checkbox = document.getElementById("statusCheckbox_" + teacherId);
                var status = checkbox.checked ? "1" : "0";
                var xhr = new XMLHttpRequest();
                var url = "AdminController";
                var params = "actionActive=updateStatus&teacherId=" + teacherId + "&status=" + status;

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
