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
    <title>Quản lý sự kiện</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="header.jsp"/>
    <main class="container-fluid py-3 py-md-4 min-vh-100">

        <!-- Donation event -->
        <section id="donationEventManagement" class="container-fluid round-border py-3 mb-2">
            <table class="table">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Tiêu đề</th>
                        <th>Thông tin chi tiết</th>
                        <th>Hình ảnh</th>
                        <th>Đã quyên góp</th>
                        <th>Mục tiêu quyên góp</th>
                        <th>Tiến độ</th>
                        <th>Bắt đầu</th>
                        <th>Kết thúc</th>
                        <th>Chức năng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${donationEvents}" var="donationEvent">
                        <tr>
                            <td>${donationEvent.donationEventId}</td>
                            <td>${donationEvent.title}</td>
                            <td>${donationEvent.detail}</td>
                            <td><img class="small-image" src="${donationEvent.images}" alt=""></td>
                            <td><fmt:formatNumber value="${donationEvent.currentDonationAmount}" type="number"/></td>
                            <td><fmt:formatNumber value="${donationEvent.totalDonationAmount}" type="number"/></td>
                            <td><fmt:formatNumber value="${donationEvent.progressPercent/100}" type="percent"/></td>
                            <td>${donationEvent.startTime}</td>
                            <td>${donationEvent.endTime}</td>
                            <td>
                                <button class="btn btn-warning mb-1" id="">Edit</button>
                                <button class="btn btn-danger mb-1">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                
            </table>
        </section>
    </main>

    <!-- Delete app user modal -->
    <div class="modal fade" id="deleteDonationEventModal" tabindex="-1" >
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xoá người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xoá người dùng <b id="appUserDeleteName">...</b></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Thoát</button>
                    <button type="button" class="btn btn-danger">Xoá</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>