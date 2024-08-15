<%-- 
    Document   : class-management
    Created on : Mar 4, 2024, 8:08:18 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ClassDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="components/head.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>

            .button-1 {
                background-color: blue;
                border-radius: 8px;
                border-style: none;
                box-sizing: border-box;
                color: white;
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
        <button type="submit" name="submitAssign" class="button-1" role="button">Save</button>


        <div id="table">
            <form action="saveHomeroomAssignment.jsp" method="post"> <!-- Thêm action và method -->
                <table id="example">
                    <thead>
                        <tr>
                            <th>Class Name</th>
                            <th>Grade</th>  
                            <th>Homeroom teacher</th>
                            <th>Assign Homeroom</th>
                        </tr>
                    </thead>


                    <tbody>
                        <%                            ClassDAO tDAO = new ClassDAO();
                            ResultSet rs = tDAO.getAll();
                            while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("id")%></td>
                            <td><%= rs.getInt("grade")%></td>
                            <td><%= rs.getString("homeroom")%></td>
                            <td>
                                <select name="homeroomAssignment"> 
                                    <option value="">Select Homeroom Teacher</option>
                                    <%
                                        ResultSet teacherRS = tDAO.getAllTeacherNotHoomroom();
                                        while (teacherRS.next()) {
                                    %>
                                    <option value="<%= teacherRS.getString("id")%>"><%= teacherRS.getString("name")%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <% }
                        %>
                    </tbody>    

                </table>
                <!-- Thêm nút Save -->
            </form>
        </div>
    </body>
</html>
