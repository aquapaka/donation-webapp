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
    <script src="${pageContext.request.contextPath}/js/userManagementScript.js"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
    <title>Quản lý người dùng</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="header.jsp"/>
    <main class="container-fluid py-3 py-md-4 min-vh-100">

        <!-- App User -->
        <section id="appUserManagement" class="container-fluid round-border py-3 mb-2">
            <table class="table">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Tên đầy đủ</th>
                        <th>Ngày sinh</th>
                        <th>Giới tính</th>
                        <th>Số điện thoại</th>
                        <th>Quyền hạn</th>
                        <th>Chức năng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${appUsers}" var="appUser" varStatus="appUserStatus">
                        <tr>
                            <td>${appUser.appUserId}</td>
                            <td>${appUser.username}</td>
                            <td>${appUser.email}</td>
                            <td>${appUser.fullname}</td>
                            <td>${appUser.dateOfBirth}</td>
                            <td>
                                <c:if test="${!appUser.gender}">Nam</c:if>
                                <c:if test="${appUser.gender}">Nữ</c:if>
                            </td>
                            <td>${appUser.phoneNumber}</td>
                            <td>${appUser.role}</td>
                            <td>
                                <button class="btn btn-warning mb-1" onclick="editAppUser(${appUser.appUserId})">Edit</button>
                                <button class="btn btn-danger mb-1" onclick="deleteAppUser(${appUser.appUserId})">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                
            </table>
        </section>
    </main>
    
    <!-- Delete app user modal -->
    <div class="modal fade" id="deleteAppUserModal" tabindex="-1" >
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xoá người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xoá người dùng <b id="appUserDeleteName">...</b> (id: <b id="appUserDeleteId">id</b>)</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Thoát</button>
                    <button type="button" class="btn btn-danger" onclick="deleteAppUserConfirm()">Xoá</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit app user modal -->
    <div class="modal fade" id="editAppUserModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa thông tin người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body row">
                    <div class="mb-3 col-4">
                        <label for="appUserId" class="form-label">Id</label>
                        <input type="text" class="form-control" value="" id="appUserId" readonly>
                    </div>
                    <div class="mb-3 col-8">
                        <label for="appUserUsername" class="form-label">Username</label>
                        <input type="text" class="form-control" value="" id="appUserUsername" readonly>
                    </div>
                    <div class="mb-3 col-12">
                        <label for="appUserEmail" class="form-label">Email</label>
                        <input type="text" class="form-control" value="" id="appUserEmail" readonly>
                    </div>
                    <div class="mb-3 col-7">
                        <label for="appUserFullname" class="form-label">Tên đầy đủ</label>
                        <input type="text" class="form-control" value="" id="appUserFullname">
                    </div>
                    <div class="mb-3 col-5">
                        <label for="appUserDateOfBirth" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" value="" id="appUserDateOfBirth">
                    </div>
                    <div class="mb-3 col-3">
                        <label for="appUserDateOfBirth" class="form-label">Giới tính</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="male" value="false">
                            <label class="form-check-label" for="male">Nam</label>
                          </div>
                          <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="female" value="true">
                            <label class="form-check-label" for="female">Nữ</label>
                          </div>
                    </div>
                    <div class="mb-3 col-5">
                        <label for="appUserPhoneNumber" class="form-label">Số điện thoại</label>
                        <input type="number" class="form-control" value="" id="appUserPhoneNumber">
                    </div>
                    <div class="mb-3 col-4">
                        <label for="role" class="form-label">Quyền hạn</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="role" id="user" value="USER">
                            <label class="form-check-label" for="user">USER</label>
                          </div>
                          <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="role" id="admin" value="ADMIN">
                            <label class="form-check-label" for="admin">ADMIN</label>
                          </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="text" class="btn btn-primary float-end" onclick="editAppUserConfirm()">Cập nhật</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>