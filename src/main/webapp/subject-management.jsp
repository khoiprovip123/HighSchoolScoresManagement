<%-- 
    Document   : subject-management
    Created on : Mar 4, 2024, 9:54:08 PM
    Author     : La Hoang Khoi - CE171855
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.SubjectDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
               <%@include file="components/head.jsp" %>
    </head>
    <body>
            <%@include file="components/header.jsp" %>
        <div id="table">
            <table id="example">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
        </tr>
    </thead>
    <tbody>
       
        <%
            SubjectDAO tDAO = new SubjectDAO();
                    ResultSet rs = tDAO.getAll();
                    while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("name") %></td>
            </tr>
        <%
            }
        %>
    </tbody>
</table>
        </div>
    </body>
</html>
