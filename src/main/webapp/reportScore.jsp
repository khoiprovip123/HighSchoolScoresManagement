<%-- 
    Document   : reportScore
    Created on : Mar 4, 2024, 10:06:23 PM
    Author     : admin
--%>

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable({
                    "pageLength": 50
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

            #example_filter {
                margin-bottom: 10px;
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

            .nav-link:active {
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

        <%
            String homeroom = (String) session.getAttribute("homeroom");

            if (!homeroom.equals("false")) {
                String[] arr = homeroom.split(" ");
                String classes = arr[0];

                String semester = "";
                if ((String) session.getAttribute("semester") != null)
                    semester = (String) session.getAttribute("semester");
        %>

        <h2 class="d-flex mt-3 mb-2"><i class="fa fa-users"> Homeroom Class</i></h2>
        <form action="/AddScore" method="post">
            <div class="d-flex">
                <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01">Class: </label>
                    <select id="class" name="class" class="form-select" id="inputGroupSelect01">
                        <option value="<%=classes%>" selected="" > <%=classes%></option>
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
                <button class="btn mb-3" type="submit" name="btn-filtScore" value="Loc">Filter</button>
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
                ResultSet rsStudent = tDAO.getStudentInClass(classes);


        %>
        <table id="example">
            <thead>
                <tr>
                    <th>Phone Number</th>
                    <th>Fullname</th>
                    <th>Birthday</th>
                        <%                            while (rsSubject.next()) {
                        %>
                    <th><%=rsSubject.getString("name")%></th>
                        <%
                            }
                        %>
                    <th>GPA</th>
                    <th>Learning outcomes</th>
                    <th>Conduct</th>
                    <th>Titles and awards</th>
                </tr>
            </thead>

            <tbody>
                <%
                    while (rsStudent.next()) {
                %>
                <tr>
                    <td><%=rsStudent.getString("phone_number")%></td>
                    <td><%=rsStudent.getString("name")%></td>
                    <td><%=rsStudent.getDate("birthday")%></td>

                    <%
                        ArrayList<StudentScoreModel> scores = new ArrayList<>();
                        float average = 0;
                        float scoreConditional = 0;
                        float lowestAverage = 10;
                        boolean requireSubject = true;
                        String resultOutcomes = "";

                        for (int i = 1; i <= 10; ++i) {
                            StudentScoreModel studentScore = null;
                            if (semester_id == 3) {
                                ResultSet rsScore1 = tDAO.getScoreByStudent(rsStudent.getInt("id"), i, 1);
                                ResultSet rsScore2 = tDAO.getScoreByStudent(rsStudent.getInt("id"), i, 2);

                                while (rsScore1.next() && rsScore2.next()) {
                                    studentScore = new StudentScoreModel(rsStudent.getInt("id"), i, (rsScore1.getFloat("scoreMouth") + rsScore2.getFloat("scoreMouth")) / 2,
                                            (rsScore1.getFloat("scoreShortExam") + rsScore2.getFloat("scoreShortExam")) / 2,
                                            (rsScore1.getFloat("scoreMidSemester") + rsScore2.getFloat("scoreMidSemester")) / 2,
                                            (rsScore1.getFloat("scoreSemester") + rsScore2.getFloat("scoreSemester")) / 2);
                                }
                            } else {
                                ResultSet rsScore = tDAO.getScoreByStudent(rsStudent.getInt("id"), i, semester_id);

                                while (rsScore.next()) {
                                    studentScore = new StudentScoreModel(rsStudent.getInt("id"), i, rsScore.getFloat("scoreMouth"), rsScore.getFloat("scoreShortExam"), rsScore.getFloat("scoreMidSemester"), rsScore.getFloat("scoreSemester"));
                                }
                            }

                            if (studentScore != null) {
                                scores.add(studentScore);
                    %>
                    <td><%=(i == 9) ? (studentScore.getGpa() >= 5 ? "Đ" : "CĐ") : studentScore.getGpa()%></td>
                    <%
                    } else {
                    %>
                    <td> - </td>
                    <%
                            }
                        }

                        if (scores.size() == 10) {
                            for (StudentScoreModel studentScoreModel : scores) {
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

                    %>
                    <td><%= average%> </td>
                    <%
                    } else {
                    %>
                    <td> - </td>
                    <%
                        }
                        if (scores.size() < 10) {
                    %>
                    <td class="<%=rsStudent.getInt("id") + "outcomes"%>"> - </td>
                    <%
                    } else if (requireSubject) {

                        if (average >= 8 && scoreConditional >= 8 && lowestAverage >= 6.5) {
                            resultOutcomes = "Gioi";
                    %>
                    <td class="<%=rsStudent.getInt("id") + "outcomes"%>">Gioi</td>
                    <%
                    } else if (average >= 6.5 && scoreConditional >= 6.5 && lowestAverage >= 5) {
                        resultOutcomes = "Kha";
                    %>
                    <td class="<%=rsStudent.getInt("id") + "outcomes"%>">Kha</td>
                    <%
                    } else if (average >= 5 && scoreConditional >= 5 && lowestAverage >= 3.5) {
                        resultOutcomes = "Trung binh";
                    %>
                    <td class="<%=rsStudent.getInt("id") + "outcomes"%>">Trung binh</td>
                    <%
                    } else {
                        resultOutcomes = "Yeu";
                    %>
                    <td class="<%=rsStudent.getInt("id") + "outcomes"%>">Yeu</td>
                    <%
                        }
                    } else {
                        resultOutcomes = "Yeu";
                    %>
                    <td class="<%=rsStudent.getInt("id") + "outcomes"%>">Yeu</td>
                    <%
                        }

                        int student_id = rsStudent.getInt("id");

                        String conduct = tDAO.getConduct(classes, student_id);
//                        while(rsConduct.next()){
//                            conduct = rsConduct.getString("conduct");
//                        }
%>
                    <td>
                        <select class="select_conduct" name="<%=rsStudent.getInt("id") + " conduct"%>">
                            <option value="<%=student_id + " Select"%>">Select</option>
                            <option value="<%=student_id + " T"%>" <%= conduct != null && conduct.equals("T") ? "selected" : ""%> >Tot</option>
                            <option value="<%=student_id + " K"%>" <%= conduct != null && conduct.equals("K") ? "selected" : ""%> >Kha</option>
                            <option value="<%=student_id + " TB"%>" <%= conduct != null && conduct.equals("TB") ? "selected" : ""%> >Trung binh</option>
                            <option value="<%=student_id + " Y"%>" <%= conduct != null && conduct.equals("Y") ? "selected" : ""%> >Yeu</option>
                        </select>
                    </td>

                    <%
                        if (scores.size() >= 10 && conduct != null) {
                            if (resultOutcomes.equals("Gioi") && conduct.equals("T")) {
                    %>
                    <td class="<%=student_id + "title-award"%>"> Hoc sinh gioi </td>
                    <%
                    } else if ((resultOutcomes.equals("Gioi") || resultOutcomes.equals("Kha")) && (conduct.equals("T") || conduct.equals("K"))) {
                    %>
                    <td class="<%=student_id + "title-award"%>"> Hoc sinh tien tien </td>
                    <%
                    } else if ((resultOutcomes.equals("Gioi") || resultOutcomes.equals("Kha") || resultOutcomes.equals("Trung binh")) && (conduct.equals("T") || conduct.equals("K") || conduct.equals("TB"))) {
                    %>
                    <td class="<%=student_id + "title-award"%>"> Hoc sinh trung binh </td>
                    <%
                    } else {
                    %>
                    <td class="<%=student_id + "title-award"%>"> Hoc sinh yeu </td>
                    <%
                        }
                    } else {
                    %>
                    <td class="<%=student_id + "title-award"%>"> - </td>
                    <%
                        }
                    %>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            }
        } else {
        %>
        <p>Bạn chưa có lớp chủ nhiệm nên không thể xem báo cao điểm!!</p>
        <%
            }
        %>
        <script>
            $(document).ready(function () {
                $('.select_conduct').change(function () {
                    var newConduct = $(this).val();
                    var classes = $('#class').val();
                    var student_id = newConduct.split(" ")[0];
                    var conduct = newConduct.split(" ")[1];

                    var outcomes = $('.' + student_id + 'outcomes').text();

                    var title_award = '.' + student_id + 'title-award';

                    var result = "hi";
                    if (outcomes === "Gioi" && conduct === "T") {
                        result = "Hoc sinh gioi";
                    } else if ((outcomes === "Gioi" || outcomes === "Kha") && (conduct === "T" || conduct === "K")) {
                        result = "Hoc sinh tien tien";
                    } else if ((outcomes === "Gioi" || outcomes === "Kha" || outcomes === "Trung binh") && (conduct === "T" || conduct === "K" || conduct === "TB")) {
                        result = "Hoc sinh trung binh";
                    } else if (outcomes === " - " || conduct === "Select") {
                        result = " - ";
                    } else {
                        result = "Hoc sinh yeu";
                    }

                    $.ajax({
                        url: '/AddScore/updateConduct',
                        method: 'GET',
                        data: {
                            id: student_id,
                            classes: classes,
                            conduct: conduct
                        }, // Dữ liệu gửi đi
                        success: function (response) {
                            $(title_award).text(result);
                        },
                        error: function (xhr, status, error) {
                            console.log(error);
                        }
                    });
                });
            });
//            
        </script>
    </body>
</html>
