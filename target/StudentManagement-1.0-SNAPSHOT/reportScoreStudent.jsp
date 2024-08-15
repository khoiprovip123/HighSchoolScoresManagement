<%-- 
    Document   : reportScore
    Created on : Mar 4, 2024, 10:06:23 PM
    Author     : admin
--%>

<%@page import="Model.Student"%>
<%@page import="DAOs.StudentDAO"%>
<%@page import="Model.Teacher"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.StudentScoreModel"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.TeacherDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
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
                String phoneNumber = (String) session.getAttribute("phoneNumber");

                StudentDAO sDAO = new StudentDAO();
                Student adc = sDAO.getInfostudent(phoneNumber);
                String isParent = "";
                if (session.getAttribute("isParent") != null) {
                    isParent = (String) session.getAttribute("isParent");
                }
            %>
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light" >
                <div class="container-fluid justify-content-between">
                    <a href="<%= isParent.equals("true") ? "/Management/ParentsHomePage" : "/Management/StudentHomePage"%>">
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
                                        <a class="dropdown-item" href="/Management/AccountStudentPage"
                                           >My account</a
                                        >
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/Management/ChangpassPage"
                                           >Change Password</a
                                        >
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="<%=isParent.equals("true") ? "/Management/ParentsSignOut" : "/Management/StudentSignOut"%>"
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

        <%
            ResultSet rsClass = sDAO.getClassByPhoneNumber(phoneNumber);

            String class_id = "";
            int school_id = 0;
            String semester = "";

            int student_id = 0;
            String classes = "";
            if (session.getAttribute("classes") != null) {
                classes = (String) session.getAttribute("classes");

                class_id = classes.split(" ")[0];
                school_id = Integer.parseInt(classes.split(" ")[1]);
                semester = (String) session.getAttribute("semester");
            }
        %>
        <form action="/student" method="post">
            <div class="d-flex">
                <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01">Class: </label>
                    <select id="class" name="class" class="form-select" id="inputGroupSelect01">
                        <%
                            while (rsClass.next()) {
                                if (student_id == 0) {
                                    student_id = rsClass.getInt("student_id");
                                }

                                String nameClass = rsClass.getString("class_id") + " (" + rsClass.getString("name") + ")";
                        %>
                        <option value="<%=rsClass.getString("class_id") + " " + rsClass.getInt("school_id")%>" <%=classes.equals(rsClass.getString("class_id") + " " + rsClass.getInt("school_id")) ? "selected" : ""%> > <%=nameClass%></option>
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
                        <option value="All Year" <%= semester.equals("All Year") ? "selected" : ""%>>All Year</option>
                    </select>
                </div>
                <button class="btn" type="submit" name="btn-filtScore" value="Loc">Lọc</button>
            </div>
        </form> 


        <%
            if (!semester.equals("")) {
                int semester_id = 0;

                if (semester.equals("Semester 1")) {
                    semester_id = 1;
                } else if (semester.equals("Semester 2")) {
                    semester_id = 2;
                } else {
                    semester_id = 3;
                }

                TeacherDAO tDAO = new TeacherDAO();
                ResultSet rsSubject = tDAO.getAllSubject();
                ArrayList<StudentScoreModel> listScore = new ArrayList<>();

                if (semester_id == 3) {
        %>
        <h3>Transcript of <%=semester.toLowerCase()%> subjects</h3>
        <table>
            <thead>
                <tr>
                    <th>Subject</th>
                    <th>GPA</th>
                </tr>
            </thead>

            <tbody>
                <%
                    while (rsSubject.next()) {
                %>
                <tr>
                    <td><%=rsSubject.getString("name")%></td>
                    <%
                        int subject_id = rsSubject.getInt("id");
                        ResultSet rsScore1 = sDAO.getScoreStudent(student_id, school_id, subject_id, 1);
                        ResultSet rsScore2 = sDAO.getScoreStudent(student_id, school_id, subject_id, 2);

                        while (rsScore1.next() && rsScore2.next()) {
                            if (rsScore1.getString("scoreMouth") != null && rsScore1.getString("scoreShortExam") != null
                                    && rsScore1.getString("scoreMidSemester") != null && rsScore1.getString("scoreSemester") != null
                                    && rsScore2.getString("scoreMouth") != null && rsScore2.getString("scoreShortExam") != null
                                    && rsScore2.getString("scoreMidSemester") != null && rsScore2.getString("scoreSemester") != null) {
                                listScore.add(new StudentScoreModel(student_id, subject_id, (rsScore1.getFloat("scoreMouth") + rsScore2.getFloat("scoreMouth")) / 2,
                                        (rsScore1.getFloat("scoreShortExam") + rsScore2.getFloat("scoreShortExam")) / 2,
                                        (rsScore1.getFloat("scoreMidSemester") + rsScore2.getFloat("scoreMidSemester")) / 2,
                                        (rsScore1.getFloat("scoreSemester") + rsScore2.getFloat("scoreSemester")) / 2));
                    %>
                    <td><%=rsSubject.getInt("id") == 9 ? listScore.get(listScore.size() - 1).getGpa() >= 5 ? "D" : "D" : listScore.get(listScore.size() - 1).getGpa()%></td>

                    <%
                    } else {
                    %>
                    <td> - </td>
                    <%
                            }

                        }
                    %>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <h3>Result study of <%=adc.getName()%> in <%=semester.toLowerCase()%></h3>
        <%
            if (listScore.size() < 10) {
        %>
        <table>
            <tr>
                <td>GPA</td>
                <td> - </td>
            </tr>
            <tr>
                <td>Outcomes</td>
                <td> - </td>
            </tr>
            <tr>
                <td>Conduct</td>
                <td>Not assign</td>
            </tr>
            <tr>
                <td>Title</td>                
                <td>Not assign</td>
            </tr>
        </table>
        <%
        } else {
            float average = 0;
            float scoreConditional = 0;
            float lowestAverage = 10;
            boolean requireSubject = true;
            String resultOutcomes = "";
            String title = "";

            for (StudentScoreModel studentScoreModel : listScore) {
                if (studentScoreModel.getSubject_id() != 9) {
                    average += studentScoreModel.getGpa();
                }

                if (studentScoreModel.getSubject_id() == 1
                        || studentScoreModel.getSubject_id() == 2
                        || studentScoreModel.getSubject_id() == 8) {
                    if (studentScoreModel.getGpa() > scoreConditional) {
                        scoreConditional = studentScoreModel.getGpa();
                    }
                } else if (studentScoreModel.getSubject_id() == 9 && studentScoreModel.getGpa() < 5) {
                    requireSubject = false;
                }

                if (studentScoreModel.getGpa() < lowestAverage) {
                    lowestAverage = studentScoreModel.getGpa();
                }
            }
            average = (float) Math.round(average) / 10;

            if (requireSubject) {
                if (average >= 8 && scoreConditional >= 8 && lowestAverage >= 6.5) {
                    resultOutcomes = "Gioi";
                } else if (average >= 6.5 && scoreConditional >= 6.5 && lowestAverage >= 5) {
                    resultOutcomes = "Kha";
                } else if (average >= 5 && scoreConditional >= 5 && lowestAverage >= 3.5) {
                    resultOutcomes = "Trung binh";
                } else {
                    resultOutcomes = "Yeu";
                }
            } else {
                resultOutcomes = "Yeu";
            }

            String conduct = sDAO.getConduct(class_id, student_id, school_id);
            if (conduct.equals("")) {
                title = "Not assign";
            } else {
                if (resultOutcomes.equals("Gioi") && conduct.equals("T")) {
                    title = "Hoc sinh gioi";
                } else if ((resultOutcomes.equals("Gioi") || resultOutcomes.equals("Kha")) && (conduct.equals("T") || conduct.equals("K"))) {
                    title = "Hoc sinh tien tien";
                } else if ((resultOutcomes.equals("Gioi") || resultOutcomes.equals("Kha") || resultOutcomes.equals("Trung binh")) && (conduct.equals("T") || conduct.equals("K") || conduct.equals("TB"))) {
                    title = "Hoc sinh trung binh";
                } else {
                    title = "Hoc sinh yeu";
                }
            }
            if (conduct.equals("T")) {
                conduct = "Tot";
            } else if (conduct.equals("K")) {
                conduct = "Kha";
            } else if (conduct.equals("TB")) {
                conduct = "Trung Binh";
            } else if (conduct.equals("Y")) {
                conduct = "Yeu";
            }
        %>
        <table>
            <tr>
                <td>GPA</td>
                <td><%=average%></td>
            </tr>
            <tr>
                <td>Outcomes</td>
                <td><%=resultOutcomes%></td>
            </tr>
            <tr>
                <td>Conduct</td>
                <td><%=conduct.equals("") ? "Not assign" : conduct%></td>
            </tr>
            <tr>
                <td>Title</td>   
                <td><%=title%></td> 
            </tr>
        </table>
        <%
            }
        } else {
        %>
        <h3>Transcript of <%=semester.toLowerCase()%> subjects</h3>
        <table id="example">
            <thead>
                <tr>
                    <th>Subject</th>
                    <th>Score mouth</th>
                    <th>Score short exam</th>
                    <th>Score mid semester</th>
                    <th>Score semester</th>
                    <th>GPA</th>
                </tr>
            </thead>

            <tbody>
                <%
                    while (rsSubject.next()) {
                        ResultSet rsScore = sDAO.getScoreStudent(student_id, school_id, rsSubject.getInt("id"), semester_id);
                %>
                <tr>
                    <td><%=rsSubject.getString("name")%></td>

                    <%
                        while (rsScore.next()) {

                    %>

                    <td> <%=rsScore.getString("scoreMouth") != null ? rsScore.getFloat("scoreMouth") : " - "%> </td>
                    <td> <%=rsScore.getString("scoreShortExam") != null ? rsScore.getFloat("scoreShortExam") : " - "%> </td>                            
                    <td> <%=rsScore.getString("scoreMidSemester") != null ? rsScore.getFloat("scoreMidSemester") : " - "%> </td>                            
                    <td> <%=rsScore.getString("scoreSemester") != null ? rsScore.getFloat("scoreSemester") : " - "%> </td>
                    <%
                        if (rsScore.getString("scoreMouth") != null && rsScore.getString("scoreShortExam") != null
                                && rsScore.getString("scoreMidSemester") != null && rsScore.getString("scoreSemester") != null) {
                            listScore.add(new StudentScoreModel(student_id, rsSubject.getInt("id"), rsScore.getFloat("scoreMouth"), rsScore.getFloat("scoreShortExam"), rsScore.getFloat("scoreMidSemester"), rsScore.getFloat("scoreSemester")));
                            float gpa = (rsScore.getFloat("scoreMouth") + rsScore.getFloat("scoreShortExam")
                                    + rsScore.getFloat("scoreMidSemester") * 2 + rsScore.getFloat("scoreSemester") * 3) / 7;
                    %>
                    <td> <%=rsSubject.getInt("id") == 9 ? ((float) (Math.round(gpa * 10)) / 10) >= 5 ? "D" : "CD" : (float) (Math.round(gpa * 10)) / 10%> </td>
                    <%
                    } else {
                    %>
                    <td> - </td>
                    <%
                        }
                    %>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <h2>Result study of <%=adc.getName()%> in <%=semester.toLowerCase()%></h2>

        <%
            if (listScore.size() < 10) {
        %>
        <table>
            <tr>
                <td>GPA</td>
                <td> - </td>
            </tr>
            <tr>
                <td>Outcomes</td>
                <td> - </td>
            </tr>
            <tr>
                <td>Conduct</td>
                <td>Not assign</td>
            </tr>
            <tr>
                <td>Title</td>                
                <td>Not assign</td>
            </tr>
        </table>
        <%
        } else {
            float average = 0;
            float scoreConditional = 0;
            float lowestAverage = 10;
            boolean requireSubject = true;
            String resultOutcomes = "";
            String title = "";

            for (StudentScoreModel studentScoreModel : listScore) {
                if (studentScoreModel.getSubject_id() != 9) {
                    average += studentScoreModel.getGpa();
                }

                if (studentScoreModel.getSubject_id() == 1
                        || studentScoreModel.getSubject_id() == 2
                        || studentScoreModel.getSubject_id() == 8) {
                    if (studentScoreModel.getGpa() > scoreConditional) {
                        scoreConditional = studentScoreModel.getGpa();
                    }
                } else if (studentScoreModel.getSubject_id() == 9 && studentScoreModel.getGpa() < 5) {
                    requireSubject = false;
                }

                if (studentScoreModel.getGpa() < lowestAverage) {
                    lowestAverage = studentScoreModel.getGpa();
                }
            }
            average = (float) Math.round(average) / 10;

            if (requireSubject) {
                if (average >= 8 && scoreConditional >= 8 && lowestAverage >= 6.5) {
                    resultOutcomes = "Gioi";
                } else if (average >= 6.5 && scoreConditional >= 6.5 && lowestAverage >= 5) {
                    resultOutcomes = "Kha";
                } else if (average >= 5 && scoreConditional >= 5 && lowestAverage >= 3.5) {
                    resultOutcomes = "Trung binh";
                } else {
                    resultOutcomes = "Yeu";
                }
            } else {
                resultOutcomes = "Yeu";
            }

            String conduct = sDAO.getConduct(class_id, student_id, school_id);
            if (conduct.equals("")) {
                title = "Not assign";
            } else {
                if (resultOutcomes.equals("Gioi") && conduct.equals("T")) {
                    title = "Hoc sinh gioi";
                } else if ((resultOutcomes.equals("Gioi") || resultOutcomes.equals("Kha")) && (conduct.equals("T") || conduct.equals("K"))) {
                    title = "Hoc sinh tien tien";
                } else if ((resultOutcomes.equals("Gioi") || resultOutcomes.equals("Kha") || resultOutcomes.equals("Trung binh")) && (conduct.equals("T") || conduct.equals("K") || conduct.equals("TB"))) {
                    title = "Hoc sinh trung binh";
                } else {
                    title = "Hoc sinh yeu";
                }
            }
            if (conduct.equals("T")) {
                conduct = "Tot";
            } else if (conduct.equals("K")) {
                conduct = "Kha";
            } else if (conduct.equals("TB")) {
                conduct = "Trung Binh";
            } else if (conduct.equals("Y")) {
                conduct = "Yeu";
            }
        %>
        <table>
            <tr>
                <td>GPA</td>
                <td><%=average%></td>
            </tr>
            <tr>
                <td>Outcomes</td>
                <td><%=resultOutcomes%></td>
            </tr>
            <tr>
                <td>Conduct</td>
                <td><%=conduct.equals("") ? "Not assign" : conduct%></td>
            </tr>
            <tr>
                <td>Title</td>   
                <td><%=title%></td> 
            </tr>
        </table>
        <%
                    }
                }
            }

        %>
    </body>
</html>
