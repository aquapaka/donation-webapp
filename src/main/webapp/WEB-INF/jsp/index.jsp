<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
    <title>Donation</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <jsp:include page="header.jsp"/>
    <main class="container-fluid p-0">

        <img class="img-fluid" src="img/momo.jpg" alt="main-image">
        
        <!-- Introduction to the app -->
        <section id="introduction" class="container py-5">
            <div class="row">
                <div class="col-md-6">
                    <h1><b>Hệ thống quyên góp tiền từ thiện DONATION</b></h1>
                    <p>DONATION là hệ thống quyên góp trực tuyến nhằm mục đích giúp mọi người có thể dễ dàng quyên góp và ủng hộ cho những người có hoàn cảnh khó khăn ở mọi nơi.</p>
                </div>
                <div class="col-md-6">
                    <img class="img-fluid w-100" src="img/images.png" alt="">
                </div>
            </div>
        </section>

        <!-- Donation Event -->
        <section id="donationEvents" class="container-fluid py-5">
            <div class="container">
                <h2 class="text-center pb-3"><b>Các sự kiện quyên góp</b></h2>
                <div class="row g-2 g-md-3 d-flex justify-content-center">
                    <c:forEach var="donationEvent" items="${donationEvents}">
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="donationEventCard overflow-hidden p-0 h-100 d-flex flex-column justify-content-between">
                                <img class="" src="${donationEvent.images}" alt="${donationEvent.title}">
                                <h3 class="px-3 pt-3">${donationEvent.title}</h3>
                                <div class="p-2 p-md-3">  
                                    <div class="d-flex flex-column">
                                        <!-- Time left -->
                                        <p class="text-end">
                                            <i>
                                                <c:choose>
                                                    <c:when test="${donationEvent.isCompleted}">
                                                        Đã hoàn thành
                                                    </c:when>
                                                    <c:when test="${donationEvent.isEnded}">
                                                        Đã kết thúc
                                                    </c:when>
                                                    <c:otherwise>
                                                        Còn ${donationEvent.daysLeft} ngày
                                                    </c:otherwise>
                                                </c:choose>
                                            </i>
                                        </p>
                                        <!-- Progress bar -->
                                        <div class="w-100">
                                            <b>${donationEvent.currentDonationAmount}</b> / ${donationEvent.totalDonationAmount}
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-striped progress-bar-animated <c:if test="${donationEvent.isCompleted}">bg-success</c:if>" role="progressbar" style="width: ${donationEvent.progressPercent}%"></div>
                                            </div>
                                        </div>
                                        <!-- Small info and button -->
                                        <div class="d-flex justify-content-between align-items-end mt-2">
                                            <div>
                                                Tổng số lượt<br>
                                                <b>123.502</b>
                                            </div>
                                            <div>
                                                Tiến độ<br>
                                                <b>${donationEvent.progressPercent}%</b>
                                            </div> 
                                            <div>
                                                <a href="${pageContext.request.contextPath}/donationEvent?id=${donationEvent.donationEventId}"><button type="button" class="btn 
                                                    <c:choose>
                                                        <c:when test="${donationEvent.isCompleted}">
                                                            btn-outline-success
                                                        </c:when>
                                                        <c:when test="${donationEvent.isEnded}">
                                                            btn-outline-secondary
                                                        </c:when>
                                                        <c:otherwise>
                                                            btn-outline-primary     
                                                        </c:otherwise>
                                                    </c:choose>
                                                "
                                                    <c:choose>
                                                        <c:when test="${donationEvent.isCompleted}">
                                                            disabled
                                                        </c:when>
                                                        <c:when test="${donationEvent.isEnded}">
                                                            disabled
                                                        </c:when>
                                                        <c:otherwise>      
                                                        </c:otherwise>
                                                    </c:choose>
                                                >
                                                    <c:choose>
                                                        <c:when test="${donationEvent.isCompleted}">
                                                            Đã hoàn thành
                                                        </c:when>
                                                        <c:when test="${donationEvent.isEnded}">
                                                            Đã kết thúc
                                                        </c:when>
                                                        <c:otherwise>
                                                            Quyên góp
                                                        </c:otherwise>
                                                    </c:choose>
                                                </button></a>
                                            </div>  
                                        </div>
                                    </div>                                        
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </main>
</body>
</html>