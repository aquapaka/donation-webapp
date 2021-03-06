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
    <script src="${pageContext.request.contextPath}/js/donationEventScripts.js"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
    <title>Donation</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="components/header.jsp"/>
    <main id="donationEvent" class="container-fluid py-3 py-md-4 position-relative">

        <jsp:include page="components/toasts.jsp"/>

        <section class="container donationEventCard py-3">
            <h2><strong>${donationEvent.title}</strong></h2>
            <h3>${donationEvent.description}</h2>
            <div class="row">
                <div class="col-12 col-md-8">
                    <img class="img-fluid round-border" src="${donationEvent.image}" alt="${donationEvent.title}">
                    <h3 class="mt-4"><strong>Th??ng tin chi ti???t</strong></h3>
                    <p>${donationEvent.detail}</p>
                </div>
                <div class="col-12 col-md-4">
                    <div class="donationEventCard overflow-hidden p-3">
                        <h3 class=""><strong>Th??ng tin quy??n g??p</strong></h3>
                        <!-- Time left -->
                        <p class="text-end">
                            <em>
                                <c:choose>
                                    <c:when test="${donationEvent.isCompleted}">
                                        ???? ho??n th??nh
                                    </c:when>
                                    <c:when test="${donationEvent.isEnded}">
                                        ???? k???t th??c
                                    </c:when>
                                    <c:otherwise>
                                        C??n ${donationEvent.daysLeft} ng??y
                                    </c:otherwise>
                                </c:choose>
                            </em>
                        </p>
                        <!-- Progress bar -->
                        <div class="w-100">
                            <strong><fmt:formatNumber value="${donationEvent.currentDonationAmount}" type="number"/></strong> / <fmt:formatNumber value="${donationEvent.totalDonationAmount}" type="number"/>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-animated <c:if test="${donationEvent.isCompleted}">bg-success</c:if>" role="progressbar" style="width: ${donationEvent.progressPercent}%"></div>
                            </div>
                        </div>
                        <!-- Small info and button -->
                        <div class="d-flex justify-content-between align-items-end mt-2">
                            <div>
                                T???ng s??? l?????t<br>
                                <strong><fmt:formatNumber value="${donationEvent.totalDonationCount}" type="number"/></strong>
                            </div>
                            <div>
                                Ti???n ?????<br>
                                <strong>${donationEvent.progressPercent}%</strong>
                            </div> 
                            <div>
                                <input id="isSignedIn" type="text" value="${isSignedIn}" hidden>
                                <button id="donateBtn" type="button" class="btn 
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
                                        <c:when test="${donationEvent.isCompleted}">???? ho??n th??nh</c:when>
                                        <c:when test="${donationEvent.isEnded}">???? k???t th??c</c:when>
                                        <c:otherwise>Quy??n g??p</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>  
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- donation modal -->
    <div class="modal fade" id="donateModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <form id="donateForm" action="/asdasd">
                    <input id="eventId" type="text" value="${eventId}" hidden>
                    <div class="modal-header">
                        <h5 class="modal-title">Quy??n g??p</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body row">
                        <div class="mb-3 col-12">
                            <label for="donateAmount" class="form-label">Nh???p s??? ti???n b???n mu???n quy??n g??p</label>
                            <input type="number" class="form-control" class="form-control" value="0" id="donateAmount">
                            <span id="donateAmountEmpty" class="form-text text-danger" hidden>S??? ti???n kh??ng ???????c b??? tr???ng<br></span>
                            <span id="donateAmountError" class="form-text text-danger" hidden>S??? ti???n kh??ng h???p l???</span>
                            <span id="donateAmountTooSmall" class="form-text text-danger" hidden>S??? ti???n quy??n g??p cho m???i ?????t ph???i t??? <fmt:formatNumber value="${minAmount}" type="number"/> tr??? l??n</span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hu???</button>
                        <button type="submit" class="btn btn-primary float-end">Quy??n g??p</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="components/footer.jsp"/>
</body>
</html>