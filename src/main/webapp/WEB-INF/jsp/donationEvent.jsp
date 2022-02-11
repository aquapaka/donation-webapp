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
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
    <title>Donation</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="header.jsp"/>
    <main id="donationEvent" class="container-fluid py-3 py-md-4">
        <section class="container donationEventCard py-3">
            <h2><b>${donationEvent.title}</b></h2>
            <div class="row">
                <div class="col-12 col-md-8">
                    <img class="img-fluid round-border" src="${donationEvent.images}" alt="${donationEvent.title}">
                    <h3 class="mt-3"><b>Thông tin chi tiết</b></h3>
                    <p>${donationEvent.detail}</p>
                </div>
                <div class="col-12 col-md-4">
                    <div class="donationEventCard overflow-hidden p-3">
                        <h3 class=""><b>Thông tin quyên góp</b></h3>
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
                            <b><fmt:formatNumber value="${donationEvent.currentDonationAmount}" type="number"/></b> / <fmt:formatNumber value="${donationEvent.totalDonationAmount}" type="number"/>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-animated <c:if test="${donationEvent.isCompleted}">bg-success</c:if>" role="progressbar" style="width: ${donationEvent.progressPercent}%"></div>
                            </div>
                        </div>
                        <!-- Small info and button -->
                        <div class="d-flex justify-content-between align-items-end mt-2">
                            <div>
                                Tổng số lượt<br>
                                <b><fmt:formatNumber value="${donationEvent.totalDonation}" type="number"/></b>
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
        </section>
    </main>
    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>