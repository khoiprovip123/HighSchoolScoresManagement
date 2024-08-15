<%-- 
    Document   : index
    Created on : Feb 25, 2024, 4:51:16 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Document</title>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anony.mous"
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
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
    </head>
    <body>

        <div class="container-fluid">
            <div class="left-content">
                <img id="left-image" src="<%=request.getContextPath()%>/imgs/logo.jpg" alt="" />
                <div class="left-text">Welcome to ABCschool</div>
            </div>

            <div class="right-content">
                <div class="login-container">
                    <!-- <img src="logo.png" alt="School Logo" /> -->
                    <h2>Educational Institution</h2>
                    <form method="post" action="/Management" >
                        <div class="input-group">
                            <select
                                for="username"
                                style="
                                width: 100%;
                                padding: 5px 0;
                                background-color: rgb(240, 235, 235);
                                border: white;
                                "
                                name="role"
                                >
                                <option>-- Choose Role --</option>
                                <option>Administrator</option>
                                <option>Teacher</option>
                                <option>Parents</option>
                                <option>Student</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label for="username">Phone Number:</label>
                            <input type="text" id="username" name="phone_number" required />
                        </div>
                        <div class="input-group">
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required />
                        </div>
                        <button type="submit" name="btnLogin">Login</button>

                        <%
                            String err = (String) session.getAttribute("loginfail");

                            if ("1".equals(err)) {
                                out.print("<h3 style=\"color: red;padding-top:20px; \" >Login failed due to incorrect account or password</h3>");
                            } else if ("2".equals(err)) {
                                out.print("<h3 style=\"color: red;padding-top:20px; \" >Please select a role before logging in</h3>");
                            }
                            session.removeAttribute("loginfail");
                        %>
                    </form>
                    <div class="additional-links">
                        <a href="/Management/ForgotPassword" >Forgot Password </a>
                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
