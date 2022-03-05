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
    <script src="${pageContext.request.contextPath}/js/userProfileScript.js"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
    <title>Hồ sơ người dùng</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="header.jsp"/>
    <main class="container-fluid py-3 py-md-4 min-vh-100 position-relative">

        <jsp:include page="toasts.jsp"/>

        <!-- User profile -->
        <section id="userProfile" class="container round-border py-3 mb-2">
            <h3 class="text-center mb-3"><strong>Hồ sơ người dùng</strong></h3>
            <form id="userProfileForm" class="row">
                <input type="text" class="form-control" value="${appUser.appUserId}" id="appUserId" hidden>
                <input type="text" class="form-control" value="${appUser.role}" id="appUserRole" hidden>
                <div class="mb-3 col-md-6">
                    <label for="appUserUsername" class="form-label">Username</label>
                    <input type="text" class="form-control" value="${appUser.username}" id="appUserUsername" readonly>
                </div>
                <div class="mb-3 col-md-6">
                    <label for="appUserEmail" class="form-label">Email</label>
                    <input type="text" class="form-control" value="${appUser.email}" id="appUserEmail" readonly>
                </div>
                <div class="mb-3 col-md-6 col-lg-3">
                    <label for="appUserFullname" class="form-label">Tên đầy đủ</label>
                    <input type="text" class="form-control" value="${appUser.fullname}" id="appUserFullname">
                    <span id="fullnameError" class="form-text text-danger" hidden>Tên không được bỏ trống</span>
                </div>
                <div class="mb-3 col-md-6 col-lg-3">
                    <label for="appUserDateOfBirth" class="form-label">Ngày sinh</label>
                    <input type="date" class="form-control" value="${appUser.dateOfBirth}" id="appUserDateOfBirth">
                    <span id="dobError" class="form-text text-danger" hidden>Ngày sinh không hợp lệ</span>
                </div>
                <div class="mb-3 col-md-6 col-lg-3">
                    <label for="appUserPhoneNumber" class="form-label">Số điện thoại</label>
                    <input type="number" class="form-control" value="${appUser.phoneNumber}" id="appUserPhoneNumber">
                    <span id="phoneNumberError" class="form-text text-danger" hidden>Số điện thoại không hợp lệ</span>
                </div>
                <div class="mb-3 col-md-6 col-lg-3">
                    <label for="appUserDateOfBirth" class="form-label">Giới tính</label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="not_set" value="NOT_SET" <c:if test="${appUser.gender=='NOT_SET'}">checked</c:if>>
                        <label class="form-check-label" for="not_set">Chưa đặt</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="male" value="MALE" <c:if test="${appUser.gender=='MALE'}">checked</c:if>>
                        <label class="form-check-label" for="male">Nam</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="female" value="FEMALE" <c:if test="${appUser.gender=='FEMALE'}">checked</c:if>>
                        <label class="form-check-label" for="female">Nữ</label>
                    </div>
                </div>
                <div class="col">
                    <div class="float-end">
                        <button class="btn btn-secondary" type="reset" disabled>Đặt lại</button>
                        <button id="submitBtn" class="btn btn-success" type="submit" disabled>Cập nhật thông tin</button>
                    </div>
                </div>
            </form>
        </section>

        <!-- Setting -->
        <section id="settings" class="container round-border py-3 mb-2">
            <h3 class="text-center mb-3"><strong>Đặt lại mật khẩu</strong></h3>
            <form id="changePasswordForm" class="row justify-content-center">        
                <div class="form-floating mb-3 col-md-3">
                    <input type="password" class="form-control" id="oldPassword" placeholder="name@example.com">
                    <label for="oldPassword" class="ms-2">Mật khẩu cũ</label>
                    <span id="oldPasswordError" class="form-text text-danger" hidden>Mật khẩu cũ không đúng</span>
                </div>
                <div class="form-floating mb-3 col-md-3">
                    <input type="password" class="form-control" id="newPassword" placeholder="name@example.com">
                    <label for="newPassword" class="ms-2">Mật khẩu mới</label>
                    <span id="newPasswordError" class="form-text text-danger" hidden>Mật khẩu mới không hợp lệ</span>
                </div>
                <div class="form-floating mb-3 col-md-3">
                    <input type="password" class="form-control" id="reNewPassword" placeholder="name@example.com">
                    <label for="reNewPassword" class="ms-2">Nhập lại mật khẩu</label>
                    <span id="reNewPasswordError" class="form-text text-danger" hidden>Mật khẩu nhập lại không khớp</span>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-primary mt-2" type="submit">Đặt lại mật khẩu</button>
                </div>
            </form>      
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>