<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:set var="donationEventsUrl" value="${pageContext.request.contextPath}/donation-events" />
<c:set var="contactUrl" value="#contact" />
<c:set var="userManagementUrl" value="${pageContext.request.contextPath}/user-management" />
<c:set var="donationEventManagementUrl" value="${pageContext.request.contextPath}/donation-event-management" />
<c:set var="donationManagementUrl" value="${pageContext.request.contextPath}/donation-management" />
<c:set var="signInUrl" value="${pageContext.request.contextPath}/sign-in" />
<c:set var="registerUrl" value="${pageContext.request.contextPath}/register" />
<c:set var="profileUrl" value="${pageContext.request.contextPath}/profile" />
<c:set var="myDonationsUrl" value="${pageContext.request.contextPath}/my-donations" />
<c:set var="signOutUrl" value="${pageContext.request.contextPath}/sign-out" />

<!--Header-->
<header>
    <!--Nav bar-->
    <div class="row">
        <div class="container">
            <nav class="navbar navbar-expand-md navbar-dark">
                <div class="container">
                    <!-- Brand logo -->
                    <a class="navbar-brand d-flex align-items-end" href="${pageContext.request.contextPath}/">
                        <img id="brand-logo" class="img-fluid" src="${pageContext.request.contextPath}/img/brand-icon.png" alt="logo">
                        <strong class="ps-1">DONATION</strong>
                    </a>
                    <!-- Mobile nav toggle button -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <!-- Nav items -->
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <c:if test="${not empty appUser}">
                                <li class="nav-item">
                                    <em class="d-md-none nav-link">Xin ch??o <strong>${appUser.username}</strong>!</em>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="${donationEventsUrl}"><strong>Quy??n g??p</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${contactUrl}"><strong>Li??n h???</strong></a>
                                </li>
                                <c:if test="${appUser.role == 'ADMIN'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${userManagementUrl}"><strong>QL Ng?????i d??ng</strong></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${donationEventManagementUrl}"><strong>QL S??? ki???n</strong></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${donationManagementUrl}"><strong>QL quy??n g??p</strong></a>
                                    </li>
                                </c:if>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${profileUrl}"><strong>H??? s??</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${myDonationsUrl}"><strong>L???ch s??? quy??n g??p</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${signOutUrl}"><strong>????ng xu???t</strong></a>
                                </li>
                            </c:if>
                            <c:if test="${empty appUser}">
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="" data-bs-toggle="modal" data-bs-target="#loginModal"><strong>????ng nh???p</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="" data-bs-toggle="modal" data-bs-target="#registerModal"><strong>????ng k??</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="${donationEventsUrl}"><strong>Quy??n g??p</strong></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${contactUrl}"><strong>Li??n h???</strong></a>
                                </li>
                            </c:if>
                        </ul>

                        <!-- User button -->
                        <div class="dropdown d-none d-md-block">
                            <a href="" class="dropdown-toggle nav-link" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="${pageContext.request.contextPath}/img/user-icon-white.png" alt="user icon"/>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end p-2" aria-labelledby="dropdownMenuButton1">
                                <c:if test="${empty appUser}">
                                    <li><a class="dropdown-item" href="" data-bs-toggle="modal" data-bs-target="#loginModal">????ng nh???p</a></li>
                                    <li><a class="dropdown-item" href="" data-bs-toggle="modal" data-bs-target="#registerModal">????ng k??</a></li>
                                </c:if>
                                <c:if test="${not empty appUser}">
                                    <li><p class="ms-2 mt-2"><em>Xin ch??o <strong>${appUser.username}</strong>!</em></p></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${profileUrl}">H??? s??</a></li>
                                    <li><a class="dropdown-item" href="${myDonationsUrl}">L???ch s??? quy??n g??p</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${signOutUrl}">????ng xu???t</a></li>
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
                    <h5 class="modal-title">????ng nh???p</h5>
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
                            <label class="form-check-label" for="rememberCheck">Nh??? th??ng tin</label>
                        </div>
                        <span id="loginError" class="form-text text-danger " hidden>Email ho???c m???t kh???u kh??ng kh???p</span>
                        <hr>
                        <span class="float-start">B???n ch??a c?? t??i kho???n? <a href="" data-bs-target="#registerModal" data-bs-toggle="modal" data-bs-dismiss="modal">????ng k??</a></span><br>
                        <span class="float-start">Qu??n m???t kh???u? <a href="" data-bs-target="#forgotPasswordModal" data-bs-toggle="modal" data-bs-dismiss="modal">?????t l???i m???t kh???u</a></span>
                        <button type="submit" class="btn btn-primary float-end" >????ng nh???p</button>
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
                    <h5 class="modal-title">????ng k??</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="registerForm" action="" method="POST">
                        <div class="mb-3">
                            <label for="resUsername" class="form-label">Username</label>
                            <input type="text" class="form-control" id="resUsername" name="resUsername">
                            <span id="resUsernameExistError" class="form-text text-danger" hidden>Username ???? t???n t???i<br></span>
                            <span id="resUsernameError" class="form-text text-danger" hidden>Username kh??ng ch???a k?? t??? ?????c bi???t (????? d??i t??? 5-20)</span>
                        </div>
                        <div class="mb-3">
                            <label for="resEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="resEmail" name="resEmail">
                            <span id="resEmailExistError" class="form-text text-danger" hidden>Email ???? ???????c ????ng k??, b???n c?? mu???n <a href="" data-bs-target="#loginModal" data-bs-toggle="modal" data-bs-dismiss="modal">????ng nh???p</a>?<br></span>
                            <span id="resEmailError" class="form-text text-danger" hidden>Email kh??ng h???p l???</span>
                        </div>
                        <div class="mb-3">
                            <label for="resPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="resPassword" name="resPassword">
                            <span id="resPasswordError" class="form-text text-danger" hidden>M???t kh???u ph???i t??? 8 - 20 k?? t???, c?? ch???a m???t k?? t??? s???, m???t k?? t??? in hoa v?? m???t k?? t??? ?????c bi???t</span>
                        </div>
                        <div class="mb-3">
                            <label for="resRePassword" class="form-label">Re-Password</label>
                            <input type="password" class="form-control" id="resRePassword" name="rePassword">
                            <span id="resRePasswordError" class="form-text text-danger" hidden>M???t kh???u nh???p l???i kh??ng kh???p</span>
                        </div>
                        <hr>
                        <span class="float-start">B???n ???? c?? t??i kho???n? <a href="" data-bs-target="#loginModal" data-bs-toggle="modal" data-bs-dismiss="modal">????ng nh???p</a></span>
                        <button type="submit" class="btn btn-primary float-end" >????ng k??</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Forgot password modal -->
    <div class="modal fade" id="forgotPasswordModal" tabindex="-1" data-bs-backdrop="static" data-show="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Qu??n m???t kh???u</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="forgetPasswordForm">
                        <div class="mb-3">
                            <label for="resetPasswordEmail" class="form-label">Nh???p email c???a b???n ????? nh???n m???t kh???u m???i</label>
                            <input type="email" class="form-control" id="resetPasswordEmail" name="resetPasswordEmail">
                        </div>
                        <span id="resetPasswordError" class="form-text text-danger " hidden>Kh??ng t??m th???y email</span>
                        <hr>
                        <span class="float-start">B???n ch??a c?? t??i kho???n? <a href="" data-bs-target="#registerModal"
                                data-bs-toggle="modal" data-bs-dismiss="modal">????ng k??</a></span>
                        <button type="submit" class="btn btn-primary float-end">X??c nh???n</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <input name="rootUrl" id="rootUrl" type="hidden" value="${pageContext.request.contextPath}"/>
</header>


