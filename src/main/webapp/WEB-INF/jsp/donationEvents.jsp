<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="vi_VN" scope="session"/>

<section id="donationEvents" class="container-fluid py-5">
    <div class="container">
        <h2 class="text-center pb-3"><b>Các sự kiện quyên góp</b></h2>
        <div class="row g-3 d-flex justify-content-center">
            <c:forEach var="donationEvent" items="${donationEvents}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="donationEventCard overflow-hidden p-0 h-100 d-flex flex-column justify-content-between">
                        <img class="" src="${donationEvent.images}" alt="${donationEvent.title}">
                        <h3 class="px-3 pt-3"><b>${donationEvent.title}</b></h3>
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
                </div>
            </c:forEach>
        </div>
    </div>
</section>