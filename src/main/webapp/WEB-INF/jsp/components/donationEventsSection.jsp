<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="vi_VN" scope="session"/>

<section id="donationEvents" class="container-fluid py-4">
    <div class="container">
        <h2 class="text-center pb-3"><b>Các sự kiện quyên góp</b></h2>

        <div class="row">
            <!-- Control buttons -->
            <div class="container-fluid mb-5">
                <form id="searchForm" class="row me-1"
                    action="${pageContext.request.contextPath}/donation-events">
                    <input id="page" name="page" value="" class="form-control" hidden>
                    <div class="col-12 col-lg-5 mb-1">
                        <input id="searchText" name="searchText" value="${searchText}" class="form-control"
                            type="search" placeholder="Tìm kiếm" aria-label="Search">
                    </div>
                    <div class="col-6 col-lg-3 mb-1">
                        <select id="searchType" name="searchType" class="form-select">
                            <option value="title" <c:if test="${searchType == 'title'}">selected</c:if>>Tìm theo tiêu đề</option>
                            <option value="description" <c:if test="${searchType == 'description'}">selected</c:if>>Tìm theo mô tả</option>
                        </select>
                    </div>
                    <div class="col-6 col-lg-3 mb-2">
                        <select id="sortType" name="sortType" class="form-select">
                            <option value="donationEventId" <c:if test="${sortType == 'donationEventId'}">selected</c:if>>Sắp xếp theo ID</option>
                            <option value="title" <c:if test="${sortType == 'title'}">selected</c:if>>Sắp xếp theo tiêu đề</option>
                            <option value="description" <c:if test="${sortType == 'description'}">selected</c:if>>Sắp xếp theo mô tả</option>
                            <option value="totalDonationAmount" <c:if test="${sortType == 'totalDonationAmount'}">selected</c:if>>Sắp xếp theo mục tiêu</option>
                            <option value="startTime" <c:if test="${sortType == 'startTime'}">selected</c:if>>Sắp xếp theo thời gian bắt đầu</option>
                            <option value="endTime" <c:if test="${sortType == 'endTime'}">selected</c:if>>Sắp xếp theo thời gian kết thúc</option>
                            <option value="createTime" <c:if test="${sortType == 'createTime'}">selected</c:if>>Sắp xếp theo thời gian tạo</option>
                        </select>
                    </div>
                    <div class="col-lg-1">
                        <button type="submit" class="btn btn-primary w-100">Tìm</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="row g-3 d-flex justify-content-center">
            <c:forEach var="donationEvent" items="${donationEvents}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="donationEventCard overflow-hidden p-0 h-100 d-flex flex-column justify-content-between">
                        <img class="" src="${donationEvent.image}" alt="${donationEvent.title}">
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
                                        <b><fmt:formatNumber value="${donationEvent.totalDonationCount}" type="number"/></b>
                                    </div>
                                    <div>
                                        Tiến độ<br>
                                        <b>${donationEvent.progressPercent}%</b>
                                    </div> 
                                    <div>
                                        <a href="${pageContext.request.contextPath}/donation-event?id=${donationEvent.donationEventId}"
                                        class="
                                        <c:choose>
                                            <c:when test="${donationEvent.isCompleted}">disabled</c:when>
                                            <c:when test="${donationEvent.isEnded}">disabled</c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>
                                        ">
                                            <button type="button" class="btn 
                                                <c:choose>
                                                    <c:when test="${donationEvent.isCompleted}">btn-outline-success</c:when>
                                                    <c:when test="${donationEvent.isEnded}">btn-outline-secondary</c:when>
                                                    <c:otherwise>btn-outline-primary</c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${donationEvent.isCompleted}">disabled</c:when>
                                                    <c:when test="${donationEvent.isEnded}">disabled</c:when>
                                                    <c:otherwise></c:otherwise>
                                                </c:choose>
                                            ">
                                                <c:choose>
                                                    <c:when test="${donationEvent.isCompleted}">Đã hoàn thành</c:when>
                                                    <c:when test="${donationEvent.isEnded}">Đã kết thúc</c:when>
                                                    <c:otherwise>Chi tiết quyên góp</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </a>
                                    </div>  
                                </div>
                            </div>                                        
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Pagination -->
    <div aria-label="Page navigation example">
        <ul class="pagination justify-content-center pt-3">
            <li class="page-item <c:if test='${currentPage <= 1}'>disabled</c:if>">
                <a class="page-link" href="#" tabindex="${currentPage-1}">&lt;</a>
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
                <a class="page-link" href="#" tabindex="${currentPage+1}">&gt;</a>
            </li>
        </ul>
    </div>
</section>