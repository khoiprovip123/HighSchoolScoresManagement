<%-- 
    Document   : headTeacher
    Created on : Mar 15, 2024, 4:19:35 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/style.css"/>
<title>Teacher</title>
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
    .nav-link {
        color: white;
    }

    .nav-link:hover {
        text-decoration: underline;
        color: white;
    }

    img {
        color: black;
    }

    #school-name {
        font-family: "Lobster", sans-serif;
        font-weight: 400;
        font-style: normal;
    }
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
    }
    form {
        max-width: 400px;
        margin: 20px auto;
        padding: 20px;
        background: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    label {
        font-weight: bold;
    }
    input[type="text"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="number"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="date"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="email"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    button {
        background-color: #4CAF50;
        color: white;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
    }
    button:hover {
        background-color: #45a049;
    }
    .h1{
        text-align: center;
        color: red;
    }
    .small {
        display: block;
        font-size: 14px; /* Kích thước chữ */
        color: red; /* Màu chữ */
    }
</style>

