<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:set var="donationEventsUrl" value="${pageContext.request.contextPath}/donationEvents" />
<c:set var="contactUrl" value="${pageContext.request.contextPath}/contact" />
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
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <c:if test="${isSignedIn}">
                                <li class="nav-item">
                                    <i class="d-md-none nav-link">Xin chào <b>Tam Long</b>!</i>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="${donationEventsUrl}"><b>Quyên góp</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${contactUrl}"><b>Liên hệ</b></a>
                                </li>
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
                                    <a class="nav-link d-md-none" href="${signInUrl}"><b>Đăng nhập</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link d-md-none" href="${registerUrl}"><b>Đăng kí</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="${donationEventsUrl}"><b>Quyên góp</b></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${contactUrl}"><b>Liên hệ</b></a>
                                </li>
                            </c:if>
                        </ul>
                        <div class="dropdown d-none d-md-block">
                            <a href="" class="dropdown-toggle nav-link" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="img/user-icon-white.png" alt="user icon"/>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end p-2" aria-labelledby="dropdownMenuButton1">
                                <c:if test="${!isSignedIn}">
                                    <li><a class="dropdown-item" href="${signInUrl}">Đăng nhập</a></li>
                                    <li><a class="dropdown-item" href="${registerUrl}">Đăng kí</a></li>
                                </c:if>
                                <c:if test="${isSignedIn}">
                                    <li><p class="ms-2 mt-2"><i>Xin chào <b>Tam Long</b>!</i></p></li>
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
</header>