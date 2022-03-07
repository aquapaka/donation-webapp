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
    <jsp:include page="components/header.jsp"/>

    <main class="container-fluid py-3 py-md-4 min-vh-100 position-relative">

        <jsp:include page="components/toasts.jsp"/>

        <!-- App User -->
        <section id="appUserManagement" class="container-fluid round-border py-3 mb-2">

            <!-- Control buttons -->
            <div class="container-fluid mb-5">
                <button class="btn btn-primary float-start me-1" onclick="addAppUser()">Thêm người dùng mới</button>
                <button id="deleteAllButton" class="btn btn-danger float-start mx-1 " onclick="deleteAppUsers()"
                    disabled>Xoá tất cả đã chọn</button>
                <form id="searchForm" class="float-end row me-1"
                    action="${pageContext.request.contextPath}/user-management">
                    <input id="page" name="page" value="" class="form-control" hidden>
                    <div class="col-5">
                        <input id="searchBox" name="searchText" value="${searchText}" class="form-control"
                            type="search" placeholder="Tìm kiếm" aria-label="Search">
                    </div>
                    <div class="col-3">
                        <select id="searchType" name="searchType" class="form-select">
                            <option value="email" <c:if test="${searchType == 'email'}">selected</c:if>>Tìm theo email</option>
                            <option value="username" <c:if test="${searchType == 'username'}">selected</c:if>>Tìm theo username</option>
                            <option value="fullname" <c:if test="${searchType == 'fullname'}">selected</c:if>>Tìm theo họ tên</option>
                            <option value="phoneNumber" <c:if test="${searchType == 'phoneNumber'}">selected</c:if>>Tìm theo số điện thoại</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <select id="sortType" name="sortType" class="form-select">
                            <option value="appUserId" <c:if test="${sortType == 'appUserId'}">selected</c:if>>Sắp xếp theo ID</option>
                            <option value="email" <c:if test="${sortType == 'email'}">selected</c:if>>Sắp xếp theo email</option>
                            <option value="username" <c:if test="${sortType == 'username'}">selected</c:if>>Sắp xếp theo username</option>
                            <option value="fullname" <c:if test="${sortType == 'fullname'}">selected</c:if>>Sắp xếp theo họ tên</option>
                            <option value="phoneNumber" <c:if test="${sortType == 'phoneNumber'}">selected</c:if>>Sắp xếp theo số điện thoại</option>
                        </select>
                    </div>
                    <div class="col-1">
                        <button type="submit" class="btn btn-primary">Tìm</button>
                    </div>
                </form>
            </div>
            
            <table class="table">
                <caption>Danh sách người dùng</caption>
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
                        <th>Trạng thái</th>
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
                                <c:if test="${appUser.gender == 'NOT_SET'}">Chưa đặt</c:if>
                                <c:if test="${appUser.gender == 'MALE'}">Nam</c:if>
                                <c:if test="${appUser.gender == 'FEMALE'}">Nữ</c:if>
                            </td>
                            <td>${appUser.phoneNumber}</td>
                            <td>${appUser.role}</td>
                            <td>${appUser.state}</td>
                            <td>
                                <button class="btn btn-warning mb-1" onclick="editAppUser(${appUser.appUserId})">Chỉnh sửa</button>
                                <button class="btn btn-danger mb-1" onclick="deleteAppUser(${appUser.appUserId})">Xoá</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <div aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                <li class="page-item <c:if test='${currentPage <= 1}'>disabled</c:if>">
                    <a class="page-link" href="#" tabindex="${currentPage-1}">Previous</a>
                </li>
                <li class="page-item" <c:if test='${currentPage <= 3}'>hidden</c:if>>
                    <a class="page-link" href="#" tabindex="1">1</a>
                </li>
                <li class="page-item disabled" <c:if test='${currentPage-3 <= 1}'>hidden</c:if>>
                    <a class="page-link" href="#" tabindex="-1">...</a>
                </li>
                <c:if test="${currentPage-2 >= 1}">
                    <li class="page-item"><a class="page-link" href="#" tabindex="${currentPage-2}">${currentPage-2}</a></li>
                </c:if>
                <c:if test="${currentPage-1 >= 1}">
                    <li class="page-item"><a class="page-link" href="#" tabindex="${currentPage-1}">${currentPage-1}</a></li>
                </c:if>  
                <li class="page-item active"><span class="page-link" tabindex="${currentPage}">${currentPage}</span></li>
                <c:if test="${currentPage+1 <= totalPage}">
                    <li class="page-item"><a class="page-link" href="#" tabindex="${currentPage+1}">${currentPage+1}</a></li>
                </c:if>
                <c:if test="${currentPage+2 <= totalPage}">
                    <li class="page-item"><a class="page-link" href="#" tabindex="${currentPage+2}">${currentPage+2}</a></li>
                </c:if>
                <li class="page-item disabled" <c:if test='${currentPage+3 >= totalPage}'>hidden</c:if>>
                    <a class="page-link" href="#" tabindex="-1">...</a>
                </li>
                <li class="page-item" <c:if test='${currentPage >= totalPage-2}'>hidden</c:if>>
                    <a class="page-link" href="#" tabindex="${totalPage}">${totalPage}</a>
                </li>
                <li class="page-item <c:if test='${currentPage >= totalPage}'>disabled</c:if>">
                    <a class="page-link" href="#" tabindex="${currentPage+1}">Next</a>
                </li>
                </ul>
            </div>
        </section>
    </main>

    <!-- Add app user modal -->
    <div class="modal fade" id="addAppUserModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm người dùng mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body row">
                    <div class="mb-3 col-12">
                        <label for="addUsername" class="form-label">Username</label>
                        <input type="text" class="form-control" value="" id="addUsername">
                        <span id="addUsernameExistError" class="form-text text-danger" hidden>Username đã tồn tại<br></span>
                        <span id="addUsernameError" class="form-text text-danger" hidden>Username không chứa ký tự đặc biệt (độ dài từ 5-20)</span>
                    </div>
                    <div class="mb-3 col-12">
                        <label for="addEmail" class="form-label">Email</label>
                        <input type="text" class="form-control" value="" id="addEmail">
                        <span id="addEmailExistError" class="form-text text-danger" hidden>Email đã tồn tại<br></span>
                        <span id="addEmailError" class="form-text text-danger" hidden>Email không hợp lệ</span>
                    </div>
                    <div class="mb-3 col-7">
                        <label for="addFullname" class="form-label">Tên đầy đủ</label>
                        <input type="text" class="form-control" value="" id="addFullname">
                        <span id="addFullnameError" class="form-text text-danger" hidden>Tên không được bỏ trống</span>
                    </div>
                    <div class="mb-3 col-5">
                        <label for="addDateOfBirth" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" value="" id="addDateOfBirth">
                        <span id="addDobError" class="form-text text-danger" hidden>Ngày sinh không hợp lệ</span>
                    </div>
                    <div class="mb-3 col-3">
                        <label for="addDateOfBirth" class="form-label">Giới tính</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="addGender" id="not_set" value="NOT_SET" checked>
                            <label class="form-check-label" for="not_set">Chưa đặt</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="addGender" id="male" value="MALE">
                            <label class="form-check-label" for="male">Nam</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="addGender" id="female" value="FEMALE">
                            <label class="form-check-label" for="female">Nữ</label>
                        </div>
                    </div>
                    <div class="mb-3 col-5">
                        <label for="addPhoneNumber" class="form-label">Số điện thoại</label>
                        <input type="number" class="form-control" value="" id="addPhoneNumber">
                        <span id="addPhoneNumberError" class="form-text text-danger" hidden>Số điện thoại không hợp lệ</span>
                    </div>
                    <div class="mb-3 col-4">
                        <label for="role" class="form-label">Quyền hạn</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="addRole" value="USER" checked>
                            <label class="form-check-label" for="user">USER</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="addRole" value="ADMIN">
                            <label class="form-check-label" for="admin">ADMIN</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button id="addSubmitBtn" type="text" class="btn btn-primary float-end" onclick="addAppUserConfirm()">Xác nhận</button>
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
                        <span id="fullnameError" class="form-text text-danger" hidden>Tên không được bỏ trống</span>
                    </div>
                    <div class="mb-3 col-5">
                        <label for="appUserDateOfBirth" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" value="" id="appUserDateOfBirth">
                        <span id="dobError" class="form-text text-danger" hidden>Ngày sinh không hợp lệ</span>
                    </div>
                    <div class="mb-3 col-3">
                        <label for="appUserDateOfBirth" class="form-label">Giới tính</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="not_set" value="NOT_SET">
                            <label class="form-check-label" for="not_set">Chưa đặt</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="male" value="MALE">
                            <label class="form-check-label" for="male">Nam</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="female" value="FEMALE">
                            <label class="form-check-label" for="female">Nữ</label>
                        </div>
                    </div>
                    <div class="mb-3 col-5">
                        <label for="appUserPhoneNumber" class="form-label">Số điện thoại</label>
                        <input type="number" class="form-control" value="" id="appUserPhoneNumber">
                        <span id="phoneNumberError" class="form-text text-danger" hidden>Số điện thoại không hợp lệ</span>
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
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="text" class="btn btn-primary float-end" onclick="editAppUserConfirm()">Cập nhật</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete app user modal -->
    <div class="modal fade" id="deleteAppUserModal" tabindex="-1" >
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xoá người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xoá người dùng <strong id="appUserDeleteName">...</strong> (id: <strong id="appUserDeleteId">id</strong>)</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="button" class="btn btn-danger" onclick="deleteAppUserConfirm()">Xoá</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="components/footer.jsp"/>
</body>
</html>