<%-- 
    Document   : myaccountTeacher
    Created on : Mar 4, 2024, 10:22:20 AM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="DAOs.TeacherDAO"%>
<%@page import="Model.Teacher"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="components/headTeacher.jsp" %>
  
    </head>
    <body>
        
        <%@include  file="components/headerTeacher.jsp" %>

        <%               

            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Teacher")) {
                        phone_number = c.getValue();
                        break;
                    }
                }
            }
            TeacherDAO pDAO = new TeacherDAO();
            TeacherDAO dDAO = new TeacherDAO();
            ResultSet rs = pDAO.getAllTeacher(phone_number);
            Teacher ra = dDAO.getInfoteacher(phone_number);
            while (rs.next()) {
        %>
        <h1 class="h1"> Information of <%= ra.getName()%></h1>
        <form action="/Management/" method="post">
            <label for="pro_id">ID:</label><br>
            <input id="pro_id" type="number" name="teacherID" value="<%= rs.getInt(1)%>" readonly=""/>

            <label for="field1">Phone_Number:</label><br>
            <input type="text" id="field1" name="phone_number" value="<%= rs.getString(2)%>"  pattern="[0-9]{10}" title="Please enter a 10-digit phone number" readonly=""><br>

            <label for="field2">Email:</label><br>
            <input type="email" id="field2" name="email" value="<%= rs.getString(3)%>" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required><br>
            <%
                String emailFail = (String) request.getSession().getAttribute("emailFailTeacher");
                if (emailFail != null) {
            %>
            <small class="small">   <%= emailFail%>  </small>
            <%
                    request.getSession().removeAttribute("emailFailTeacher");
                }
            %>
            <label for="field3">Name:</label><br>
            <input type="text" id="field3" name="name" value="<%= rs.getString(5)%>" required=""><br>

            <label for="female">Gender:</label>
            <div class="radio-container">
                <input type="radio" id="female" name="gender" value="Female" <%=rs.getString(6).equalsIgnoreCase("Female") ? "checked" : ""%>>
                <label for="female">Female</label>
            </div>

            <div class="radio-container">
                <input type="radio" id="male" name="gender" value="Male" <%=rs.getString(6).equalsIgnoreCase("Male") ? "checked" : ""%>>
                <label for="male">Male</label>
            </div>

            <label for="field5">Birthday:</label><br>
            <input type="date" id="field5" name="birthday" value="<%= rs.getString(7)%>" max="YYYY-MM-DD" title="Please enter a valid date of birth" ><br>
            <%
                String invalidDay = (String) request.getSession().getAttribute("invalidDay");
                if (invalidDay != null) {
            %>
            <small class="small">   <%= invalidDay%>  </small>
            <%
                    request.getSession().removeAttribute("invalidDay");
                }
            %>

            <label for="field6">Address:</label><br>
            <input type="text" id="field6" name="address" value="<%= rs.getString(8)%>"pattern="[a-zA-Z0-9\s]+" title="Please enter a valid address"><br>

            <label for="field7">Status:</label><br>
            <input type="text" id="field7" name="status" value="<%= rs.getString(9)%>" required="" readonly=""><br>

            <button id="btnSave" type="submit" name="submit_saveTeacher">Save</button>

<%
    }
%>
        </form>
    </body>
</html>
