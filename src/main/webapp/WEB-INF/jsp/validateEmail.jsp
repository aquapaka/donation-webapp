<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
    <script src="${pageContext.request.contextPath}/js/validateEmailScript.js"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
    <title>Xác minh email</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="header.jsp"/>
    <main class="container-fluid py-3 py-md-4 min-vh-100 position-relative">

        <jsp:include page="toasts.jsp"/>

        <section id="appUserManagement" class="container round-border py-3 mb-2">
            <form id="validateForm" class="d-flex justify-content-center align-items-center px-5">
                <span class="mx-1">Nhập mã xác minh được gửi tới email của bạn</span>
                <input type="number" class="form-control form-control-sm mx-1" value="" id="activeCode" min="100000" max="999999" style="width: 100px">
                <button class="btn btn-primary btn-sm mx-1" type="submit">Xác minh</button>
                <span id="wrongActiveCode" class="form-text text-danger mx-1" hidden>Mã xác minh không đúng</span>
            </form>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>