<%-- 
    Document   : headStudent
    Created on : Mar 15, 2024, 5:00:28 PM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/style.css"/>
<title>Student</title>
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
    table {
        width: 80%; /* Chiều rộng của bảng, bạn có thể điều chỉnh theo ý muốn */
        margin: 0 auto; /* Căn giữa bảng */
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    /* Thiết lập cho dòng chẵn của bảng */
    tr:nth-child(even) {
        background-color: #f2f2f2; /* Màu xám nhạt */
    }

    /* Thiết lập cho các ô của bảng */
    td {
        padding: 8px; /* Khoảng cách giữa nội dung và viền của ô */
        text-align: left; /* Căn trái nội dung trong ô */
        border: 1px solid #ddd; /* Viền của ô */
        width: 50%; /* Thiết lập width cố định cho ô td */

    }

    /* Hiệu ứng hover cho các dòng của bảng */
    tr:hover {
        background-color: #ddd; /* Màu xám nhạt khi di chuột qua */
    }

    /* Style cho tiêu đề của bảng */
    .h1 {
        text-align: center; /* Căn giữa nội dung */
        color: red; /* Màu chữ đỏ */
    }
     .h1-parent {
        text-align: center; /* Căn giữa nội dung */
        color: red; /* Màu chữ đỏ */
        padding-right:  210px;
    }
</style>