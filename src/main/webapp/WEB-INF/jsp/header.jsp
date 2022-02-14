<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:set var="donationEventsUrl" value="${pageContext.request.contextPath}/#donationEvents" />
<c:set var="contactUrl" value="${pageContext.request.contextPath}/#contact" />
<c:set var="userManagementUrl" value="${pageContext.request.contextPath}/userManagement" />
<c:set var="donationEventManagementUrl" value="${pageContext.request.contextPath}/donationEventManagement" />
<c:set var="donationManagementUrl" value="${pageContext.request.contextPath}/donationManagement" />
<c:set var="signInUrl" value="${pageContext.request.contextPath}/signIn" />
<c:set var="registerUrl" value="${pageContext.request.contextPath}/register" />
<c:set var="profileUrl" value="${pageContext.request.contextPath}/profile" />
<c:set var="myDonationsUrl" value="${pageContext.request.contextPath}/myDonations" />
<c:set var="settingsUrl" value="${pageContext.request.contextPath}/settings" />
<c:set var="signOutUrl" value="${pageContext.request.contextPath}/signOut" />

<!--Header-->
<header>
    <!--Nav bar-->
    <div class="row">
        <div class="container">
            <nav class="navbar navbar-expand-md navbar-dark">
                <div class="container">
                    <!-- Brand logo -->
                    <a class="navbar-brand d-flex align-items-end" href="${pageContext.request.contextPath}/">
                        <img id="brand-logo" class="img-fluid" src="img/brand-icon.png" alt="logo">
                        <strong class="ps-1">DONATION</strong>
                    </a>
                    <!-- Mobile nav toggle button -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <!-- Nav items -->
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <c:if test="${isSignedIn}">
                                <li class="nav-item">
                                    <i class="d-md-none nav-link">Xin chào <b>${appUser.username}</b>!</i>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="${donationEventsUrl}"><b>Quyên góp</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${contactUrl}"><b>Liên hệ</b></a>
                                </li>
                                <c:if test="${appUser.role == 'ADMIN'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${userManagementUrl}"><b>QL Người dùng</b></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${donationEventManagementUrl}"><b>QL Sự kiện</b></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${donationManagementUrl}"><b>QL quyên góp</b></a>
                                    </li>
                                </c:if>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${profileUrl}"><b>Hồ sơ</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${myDonationsUrl}"><b>Lịch sử quyên góp</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${settingsUrl}"><b>Thiết đặt</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${signOutUrl}"><b>Đăng xuất</b></a>
                                </li>
                            </c:if>
                            <c:if test="${!isSignedIn}">
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="" data-bs-toggle="modal" data-bs-target="#loginModal"><b>Đăng nhập</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="" data-bs-toggle="modal" data-bs-target="#registerModal"><b>Đăng kí</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="${donationEventsUrl}"><b>Quyên góp</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${contactUrl}"><b>Liên hệ</b></a>
                                </li>
                            </c:if>
                        </ul>

                        <!-- User button -->
                        <div class="dropdown d-none d-md-block">
                            <a href="" class="dropdown-toggle nav-link" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="img/user-icon-white.png" alt="user icon"/>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end p-2" aria-labelledby="dropdownMenuButton1">
                                <c:if test="${!isSignedIn}">
                                    <li><a class="dropdown-item" href="" data-bs-toggle="modal" data-bs-target="#loginModal">Đăng nhập</a></li>
                                    <li><a class="dropdown-item" href="" data-bs-toggle="modal" data-bs-target="#registerModal">Đăng kí</a></li>
                                </c:if>
                                <c:if test="${isSignedIn}">
                                    <li><p class="ms-2 mt-2"><i>Xin chào <b>${appUser.username}</b>!</i></p></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${profileUrl}">Hồ sơ</a></li>
                                    <li><a class="dropdown-item" href="${myDonationsUrl}">Lịch sử quyên góp</a></li>
                                    <li><a class="dropdown-item" href="${settingsUrl}">Thiết đặt</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${signOutUrl}">Đăng xuất</a></li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <!-- login modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" data-bs-backdrop="static" data-show="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Đăng nhập</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="loginForm" action="" method="POST">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberCheck" name="rememberCheck">
                            <label class="form-check-label" for="rememberCheck">Nhớ thông tin</label>
                        </div>
                        <span id="loginError" class="form-text text-danger " hidden>Email hoặc mật khẩu không khớp</span>
                        <hr>
                        <span class="float-start">Bạn chưa có tài khoản? <a href="" data-bs-target="#registerModal" data-bs-toggle="modal" data-bs-dismiss="modal">Đăng kí</a></span>
                        <button type="submit" class="btn btn-primary float-end" >Đăng nhập</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- register modal -->
    <div class="modal fade" id="registerModal" tabindex="-1" data-bs-backdrop="static" data-show="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Đăng kí</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="registerForm" action="" method="POST">
                        <div class="mb-3">
                            <label for="resUsername" class="form-label">Username</label>
                            <input type="text" class="form-control" id="resUsername" name="resUsername">
                            <span id="resUsernameExistError" class="form-text text-danger" hidden>Username đã tồn tại<br></span>
                            <span id="resUsernameError" class="form-text text-danger" hidden>Username không chứa ký tự đặc biệt (độ dài từ 5-20)</span>
                        </div>
                        <div class="mb-3">
                            <label for="resEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="resEmail" name="resEmail">
                            <span id="resEmailExistError" class="form-text text-danger" hidden>Email đã tồn tại<br></span>
                            <span id="resEmailError" class="form-text text-danger" hidden>Email không hợp lệ</span>
                        </div>
                        <div class="mb-3">
                            <label for="resPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="resPassword" name="resPassword">
                            <span id="resPasswordError" class="form-text text-danger" hidden>Mật khẩu phải từ 8 - 20 ký tự, có chứa một ký tự số, một ký tự in hoa và một ký tự đặc biệt</span>
                        </div>
                        <div class="mb-3">
                            <label for="resRePassword" class="form-label">Re-Password</label>
                            <input type="password" class="form-control" id="resRePassword" name="rePassword">
                            <span id="resRePasswordError" class="form-text text-danger" hidden>Mật khẩu nhập lại không khớp</span>
                        </div>
                        <hr>
                        <span class="float-start">Bạn đã có tài khoản? <a href="" data-bs-target="#loginModal" data-bs-toggle="modal" data-bs-dismiss="modal">Đăng nhập</a></span>
                        <button type="submit" class="btn btn-primary float-end" >Đăng kí</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</header>