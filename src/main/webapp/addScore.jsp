<%-- 
    Document   : addScore
    Created on : Feb 29, 2024, 8:36:58 AM
    Author     : admin
--%>

<%@page import="Model.Teacher"%>
<%@page import="Model.SubjectModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TeacherDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#example').DataTable({
                "pageLength": 25
            });
        });
    </script>

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
        crossorigin="anonymous"
        />
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"
    ></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"
    ></script>

    <style>
        .d-flex {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .input-group {
            margin-right: 10px;
        }
        
        #example_filter {
            margin-bottom: 10px;
        }

        .btn {
            background-color: green;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
        }

        .nav-link {
            color: white;
        }

        .nav-link:hover {
            text-decoration: underline;
            color: white;
        }

        .navbar-nav .nav-link.active, .navbar-nav .nav-link.show  {
            color: white;
        }

        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
        }

        table#example tr:nth-child(even) {
            background-color: #eee;
        }

        table#example tr:nth-child(odd) {
            background-color: #fff;
        }

        table#example th {
            color: white;
            background-color: gray;
        }
    </style>
</head>
<body>
    <header style="background-color: #003a5f">
        <%
            String phone_number = "";
            Cookie[] cList = request.getCookies();
            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Teacher")) {
                        phone_number = c.getValue();
                        break;
                    }
                }
            }

            TeacherDAO ad = new TeacherDAO();
            Teacher adc = ad.getInfoteacher(phone_number);
        %>
        <!-- Menu -->
        <nav class="navbar navbar-expand-lg navbar-light" >
            <div class="container-fluid justify-content-between">
                <a href="/Management/TeacherHomePage">
                    <img
                        class="navbar-brand"
                        id="logo"
                        src="<%= request.getContextPath()%>/imgs/logo_small.jpg"
                        alt="Hame Logo"
                        style="width: 60px; border-radius: 15%"
                        />
                </a>
                <button
                    type="button"
                    class="navbar-toggler"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse"
                    >
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div
                    class="collapse navbar-collapse justify-content-between"
                    id="navbarCollapse"
                    >                        
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a
                                class="nav-link dropdown-toggle"
                                data-bs-toggle="dropdown"
                                href=""
                                >Hello, <%=adc.getName()%></a
                            >
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="/Management/AccountTeacherPage"
                                       >My account</a
                                    >
                                </li>
                                <li>
                                    <a class="dropdown-item" href="/Management/ChangpassPage"
                                       >Change Password</a
                                    >
                                </li>
                                <li>
                                    <a class="dropdown-item" href="/Management/TeacherSignOut"
                                       >Sign out</a
                                    >
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
                            <h2 class="d-flex mt-4"><i class="fa fa-book"> Grade Book</i></h2>
    <%
        String isAccess = (String) session.getAttribute("isAccess");
        String isPower = (String) session.getAttribute("isPower");
        ArrayList<String> list = (ArrayList<String>) session.getAttribute("list");
        String classes = "";
        int subject_id = 0;
        int school_year = 0;
        String subject_name = "";
        String semester = "";

        if (list != null && list.size() > 0) {
            classes = list.get(0);
            school_year = Integer.parseInt(classes.split(" ")[1]);
            subject_id = Integer.parseInt(list.get(1));
            semester = list.get(2);
        }
        if (isAccess.equals("true")) {
    %>
    <h4><i class="fa fa-file-text" ></i> Please select class to enter mark</h4>

    <%
        TeacherDAO tDAO = new TeacherDAO();
        ResultSet listClass = tDAO.getAllClass();
        ResultSet rsSubject = tDAO.getAllSubject();
        ResultSet listSemester = tDAO.getAllSemester();
        int semester_id = 0;

        while (listSemester.next()) {

            if (listSemester.getString("name").equals(semester)) {
                semester_id = listSemester.getInt("id");
                break;
            }
        }

        ArrayList<SubjectModel> listSubject = new ArrayList<>();
        while (rsSubject.next()) {
            listSubject.add(new SubjectModel(rsSubject.getInt(1), rsSubject.getString(2)));
        }
    %>
    <form action="/AddScore" method="post">
        <div class="d-flex">
            <div class="input-group mb-3">
                <label class="input-group-text" for="inputGroupSelect01">Class: </label>
                <select name="class" class="form-select" id="inputGroupSelect01">
                    <%
                        while (listClass.next()) {
                    %>
                    <option value="<%=listClass.getString("id") + " " + listClass.getInt("school_year")%>" <%=classes.equals(listClass.getString("id") + " " + listClass.getInt("school_year")) ? "selected" : ""%> > 
                        <%=listClass.getString("id") + " (" + listClass.getString("name") + ")"%>
                    </option>

                    <%
                        }
                    %>
                </select>
            </div>
            <div class="input-group mb-3">
                <label class="input-group-text" for="inputGroupSelect02">Subject: </label>
                <select name="subject" class="form-select" id="inputGroupSelect02">

                    <%
                        for (SubjectModel subject : listSubject) {
                            if (subject_id == subject.getId())
                                subject_name = subject.getName();
                    %>
                    <option value="<%=subject.getId()%>" <%=subject_id == subject.getId() ? "selected" : ""%>><%=subject.getName()%></option>

                    <%
                        }
                    %>
                </select>
            </div>
            <div class="input-group mb-3">
                <label class="input-group-text" for="inputGroupSelect03">Semester: </label>
                <select name="semester" class="form-select" id="inputGroupSelect03">
                    <option value="Semester 1" <%= semester.equals("Semester 1") ? "selected" : ""%>>Semester 1</option>    
                    <option value="Semester 2" <%= semester.equals("Semester 2") ? "selected" : ""%>>Semester 2</option>
                </select>
            </div>
            <button class="btn mb-3" type="submit" name="btn-filter" value="Loc">Filter</button>
        </div>
    </form>      
    <%
        if (isPower != null && isPower.equals("false")) {
    %>
    <p>Bạn không có quyền nhập và sửa điểm của lớp này!!</p>
    <%
    } else if (isPower != null) {
        String teacherName = tDAO.getTeacherNameById(Integer.parseInt(isPower));

        ResultSet rsStudent = tDAO.getStudent(classes);
    %>

    <div class="d-flex">
        <h4>Grade Book Detail: </h4>
        <p> <span><strong>Class: </strong> </span> <%=classes.split(" ")[0]%></p>
        <p> <span><strong>Subject: </strong> </span> <%=subject_name%> - <%=semester%></p>
        <p> <span> <strong>Teacher:</strong> </span> <%=teacherName%></p>
    </div>  

    <form action="/AddScore" method="post"> 
        <input type="hidden" name="txt_values" value="<%=classes + " " + subject_id + " " + semester_id%>">
        <table id="example">
            <thead>
                <tr>
                    <th>Phone Number</th>
                    <th>Fullname</th>
                    <th>Birthday</th>
                    <th>Mark Mouth</th>
                    <th>Mark Short Exam</th>                            
                    <th>Mark Mid Semester</th>
                    <th>Mark Semester</th>
                    <th>Mark GPA</th>
                </tr>
            </thead>

            <tbody>
                <%
                    while (rsStudent.next()) {
                        int student_id = rsStudent.getInt("student_id");

                %>
                <tr>
                    <td><%=rsStudent.getString("phone_number")%></td>
                    <td><%=rsStudent.getString("name")%></td>
                    <td><%=rsStudent.getDate("birthday")%></td>

                    <%
                        ResultSet rsScore = tDAO.getScoreByStudent2(student_id, subject_id, semester_id, school_year);
                        while (rsScore.next()) {

                            float gpa = (rsScore.getFloat("scoreMouth") + rsScore.getFloat("scoreShortExam")
                                    + rsScore.getFloat("scoreMidSemester") * 2 + rsScore.getFloat("scoreSemester") * 3) / 7;
                    %>
                    <td> <input type="number" min="0" max="10" step="0.1" name="<%=student_id + " scoreMouth"%>" value="<%=rsScore.getString("scoreMouth") != null ? rsScore.getFloat("scoreMouth") : ""%>" > </td>
                    <td> <input type="number" min="0" max="10" step="0.1" name="<%=student_id + " scoreShortExam"%>" value="<%=rsScore.getString("scoreShortExam") != null ? rsScore.getFloat("scoreShortExam") : ""%>"> </td>                            
                    <td> <input type="number" min="0" max="10" step="0.1" name="<%=student_id + " scoreMidSemester"%>" value="<%=rsScore.getString("scoreMidSemester") != null ? rsScore.getFloat("scoreMidSemester") : ""%>"> </td>                            
                    <td> <input type="number" min="0" max="10" step="0.1" name="<%=student_id + " scoreSemester"%>" value="<%=rsScore.getString("scoreSemester") != null ? rsScore.getFloat("scoreSemester") : ""%>"> </td>
                    <td> <input type="number" name="<%=student_id + " gpa"%>" value="<%=(float) (Math.round(gpa * 10)) / 10%>" readonly=""> </td>
                        <%
                            }
                        %>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <button class="btn" type="submit" name="btn-save" value="Save">Save</button>
    </form>
    <%
        }
    } else {
    %>
    <p>
        Thời gian bắt đầu: 00:00 ngày 03/11/2023. Thời gian kết thúc: trước 12:00 ngày 05/11/2023
        Starting date: 00:00 date 03/11/2023. Duedate: before 12:00 date 05/11/2023
    </p>
    <%
        }
    %>

</body>
</html>
