<%-- 
    Document   : forgot-password
    Created on : Mar 19, 2024, 2:37:27 PM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>        
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Teacher Management</title>
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
        <style>
            #school-name {
                font-family: "Lobster", sans-serif;
                font-weight: 400;
                font-style: normal;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
               
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 400px; /* Thêm chiều rộng cho container */
            }

            h2 {
                text-align: center;
                margin-bottom: 20px; /* Thêm khoảng cách dưới cho tiêu đề */
            }

            form {
                max-width: 100%; /* Đảm bảo form không bị tràn ra ngoài container */
            }

            label {
                display: block;
                margin-bottom: 8px;
            }

            input[type="tel"],
            input[type="password"],
            input[type="submit"] {
                width: calc(100% - 20px); /* Thêm khoảng cách cho input */
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                background-color: #4caf50;
                color: white;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            select {
                width: 100%;
                padding: 5px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                background-color: #f0ebeb; /* Màu nền cho select */
                color: #555; /* Màu chữ cho select */
            }
            .small {
                display: block;
                text-align: center; /* Canh giữa nội dung */
                font-size: 20px; /* Kích thước chữ */
                color: red; /* Màu chữ */
                margin-top: 10px; /* Khoảng cách từ trên xuống */
            }
        </style>
    </head>
    <body>
        <header>
            <div class="d-flex row">
                <div class="col-sm-2">
                    <a href="/Management/LoginPage"><img
                            class="navbar-brand"
                            style="margin-left: 80px"
                            id="logo"
                            src="<%= request.getContextPath()%>/imgs/logo_small.png"
                            alt="Hame Logo"
                            width="200px"
                            /></a>
                </div>

                <div id="school-name" class="col-sm-10 d-flex align-items-center ">
                    <h1 class="text-center" style="color: #003a5f; width: 100%; padding-right:240px">Welcome to ABC High School</h1>
                </div>
            </div>
        </header>
        <div class="container">
            <h2>Forgot Password</h2>


            <form action="/Management" method="post">

                <select
                    for="username"
                    name="role"
                    >
                    <option>-- Choose Role --</option>
                    <option>Administrator</option>
                    <option>Teacher</option>
                    <option>Parents</option>
                    <option>Student</option>
                </select>



                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" title="Please enter a 10-digit phone number"  required><br><br>
                <label for="old_password">New Password:</label>
                <input type="password" id="old_password" name="new_password" required><br><br>
                <label for="new_password">Confirm Password:</label>
                <input type="password" id="new_password" name="confirm_password" required><br><br>
                <input type="submit" value="Reset Password" name="btnForget">

                <%
                    String passerr = (String) request.getSession().getAttribute("passerr");
                    String passerr1 = (String) request.getSession().getAttribute("phoneerr");
                    String noerr = (String) request.getSession().getAttribute("noerr");
                    if (passerr != null) {
                %>
                <small class="small">      <%= passerr%></small>
                <%
                    request.getSession().removeAttribute("passerr");
                } else if (passerr1 != null) {
                %>

                <smal  class="small"> <%= passerr1%></small>

                    <%
                        request.getSession().removeAttribute("phoneerr");
                    } else if (noerr != null) {
                    %>
                    <small class="small"> <%= noerr%></small>
                    <%
                            request.getSession().removeAttribute("noerr");
                        }
                    %>
            </form>
        </div>
    </body>
</html>
