<%-- 
    Document   : myaccountStudent
    Created on : Mar 4, 2024, 1:57:29 AM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="DAOs.StudentDAO"%>
<%@page import="Model.Student"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="components/headStudent.jsp" %>

    </head>
    <body>

        <%@include  file="components/headerStudent.jsp" %>
        <table>
            <%                if (cList != null) {
                    for (Cookie c : cList) {
                        if (c.getName().equals("Student")) {
                            phone_number = c.getValue();
                            break;
                        }
                    }
                }
                StudentDAO pDAO = new StudentDAO();
                ResultSet rs = pDAO.getAllStudent(phone_number);
                StudentDAO dDAO = new StudentDAO();
                Student ra = dDAO.getInfostudent(phone_number);
                while (rs.next()) {
            %>
            <h3 class="h1">Information of <%= ra.getName()%></h3>
            <tr>
                <td>ID</td>
                <td><%= rs.getString(1)%></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><%= rs.getString(2)%></td>
            </tr>
            <tr>
                <td>Name</td>
                <td><%= rs.getString(4)%></td>
            </tr>
            <tr>
                <td>Gender</td>
                <td><%= rs.getString(5)%></td>
            </tr>
            <tr>
                <td>Birthday</td>
                <td><%= rs.getString(6)%></td>
            </tr>
            <tr>
                <td>Phone_Number</td>
                <td><%= rs.getString(7)%></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><%= rs.getString(8)%></td>
            </tr>
            <tr>
                <td>Status</td>
                <td><%= rs.getString(9)%></td>
            </tr>


        </table>


        <table>
            <h3 class="h1-parent"> Parent Of <%= ra.getName()%></h3>
            <tr>
                <td>Phone_number</td>
                <td><%=rs.getString(11)%></td>
            </tr>
            <tr>
                <td>Name</td>
                <td><%=rs.getString(13)%></td>
            </tr>
            <tr>
                <td>Role</td>
                <td><%=rs.getString(14)%></td>
            </tr>
            <tr>
                <td>Job</td>
                <td><%=rs.getString(15)%></td>
            </tr>
            <tr>
                <td>Student ID</td>
                <td><%= rs.getString(16)%></td>
            </tr>
            <tr>
                <td>Status</td>
                <td><%= rs.getString(17)%></td>
            </tr>
            <tr>
            </tr>

        </table>
        <%
            }
        %>

    </body>
</html>
