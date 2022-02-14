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
    <script src="${pageContext.request.contextPath}/js/donationEventManagementScript.js"></script>
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
            <!-- Control buttons -->
            <button class="btn btn-primary" onclick="addDonationEvent()">Thêm sự kiện mới</button>

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
                                <button class="btn btn-warning mb-1" id="" onclick="editDonationEvent(${donationEvent.donationEventId})">Edit</button>
                                <button class="btn btn-danger mb-1" onclick="deleteDonationEvent(${donationEvent.donationEventId})">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                
            </table>
        </section>
    </main>

    <!-- Delete donation event modal -->
    <div class="modal fade" id="deleteDonationEventModal" tabindex="-1" >
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xoá sự kiện</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xoá sự kiện <b id="donationEventDeleteName">...</b> (id: <b id="donationEventDeleteId">id</b>)</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="button" class="btn btn-danger" onclick="deleteDonationEventConfirm()">Xoá</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit donation event modal -->
    <div class="modal fade" id="editDonationEventModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa thông tin sự kiện</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body row">
                    <div class="mb-3 col-4">
                        <label for="appUserId" class="form-label">Id</label>
                        <input type="text" class="form-control" value="" id="donationEventId" readonly>
                    </div>
                    <div class="mb-3 col-8">
                        <label for="donationEventTitle" class="form-label">Tiêu đề</label>
                        <input type="text" class="form-control" value="" id="donationEventTitle">
                    </div>
                    <div class="mb-3 col-12">
                        <label for="donationEventDetail" class="form-label">Thông tin chi tiết</label>
                        <textarea class="form-control" id="donationEventDetail"></textarea>
                    </div>
                    <div class="mb-3 col-8">
                        <label for="donationEventImage" class="form-label">Url hình ảnh</label>
                        <input type="text" class="form-control" value="" id="donationEventImage">
                    </div>
                    <div class="mb-3 col-4">
                        <label for="donationEventTotal" class="form-label">Tổng số tiền</label>
                        <input type="number" class="form-control" value="" id="donationEventTotal">
                    </div>
                    <div class="mb-3 col-6">
                        <label for="donationEventStartTime" class="form-label">Thời gian bắt đầu</label>
                        <input type="date" class="form-control" value="" id="donationEventStartTime" readonly>
                    </div>
                    <div class="mb-3 col-6">
                        <label for="donationEventEndTime" class="form-label">Thời gian kết thúc</label>
                        <input type="date" class="form-control" value="" id="donationEventEndTime">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="text" class="btn btn-primary float-end" onclick="editDonationEventConfirm()">Cập nhật</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Add donation event modal -->
    <div class="modal fade" id="addDonationEventModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm sự kiện mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body row">
                    <div class="mb-3 col-8">
                        <label for="addDonationEventTitle" class="form-label">Tiêu đề</label>
                        <input type="text" class="form-control" value="" id="addDonationEventTitle">
                    </div>
                    <div class="mb-3 col-4">
                        <label for="addDonationEventTotal" class="form-label">Tổng số tiền</label>
                        <input type="number" class="form-control" value="" id="addDonationEventTotal">
                    </div>
                    <div class="mb-3 col-12">
                        <label for="addDonationEventDetail" class="form-label">Thông tin chi tiết</label>
                        <textarea class="form-control" id="addDonationEventDetail"></textarea>
                    </div>
                    <div class="mb-3 col-12">
                        <label for="addDonationEventImage" class="form-label">Url hình ảnh</label>
                        <input type="text" class="form-control" value="" id="addDonationEventImage">
                    </div>
                    <div class="mb-3 col-6">
                        <label for="addDonationEventStartTime" class="form-label">Thời gian bắt đầu</label>
                        <input type="date" class="form-control" value="" id="addDonationEventStartTime" readonly>
                    </div>
                    <div class="mb-3 col-6">
                        <label for="addDonationEventEndTime" class="form-label">Thời gian kết thúc</label>
                        <input type="date" class="form-control" value="" id="addDonationEventEndTime">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="text" class="btn btn-primary float-end" onclick="addDonationEventConfirm()">Thêm sự kiện</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>