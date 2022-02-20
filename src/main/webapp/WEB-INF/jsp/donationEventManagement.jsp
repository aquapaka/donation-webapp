<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
                    crossorigin="anonymous">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                    crossorigin="anonymous"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
                    integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
                    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
                <script src="${pageContext.request.contextPath}/js/ckeditor5/ckeditor.js"></script>
                <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
                <script src="${pageContext.request.contextPath}/js/donationEventManagementScript.js"></script>
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">
                <title>Quản lý sự kiện</title>
            </head>

            <body>
                <fmt:setLocale value="vi_VN" scope="session" />

                <!-- Header -->
                <jsp:include page="header.jsp" />
                <main class="container-fluid py-3 py-md-4 min-vh-100">

                    <!-- Donation event -->
                    <section id="donationEventManagement" class="container-fluid round-border py-3 mb-2">
                        <!-- Control buttons -->
                        <div class="row">
                            <div class="col-6">
                                <button class="btn btn-primary" onclick="addDonationEvent()">Thêm sự kiện mới</button>
                                <button id="deleteAllButton" class="btn btn-danger" onclick="deleteDonationEvents()"
                                    disabled>Xoá sự kiện đã chọn</button>
                            </div>
                            <div class="col-6">
                                <form id="searchForm" class="d-flex align-items-end"
                                    action="${pageContext.request.contextPath}/donationEventManagement">
                                    <label for="searchBox" class="form-label text-nowrap me-2">Tìm kiếm</label>
                                    <input id="searchBox" name="searchText" value="" class="form-control me-2"
                                        type="search" placeholder="Nhập nội dung tìm kiếm..." aria-label="Search">
                                    <div class="d-flex w-50 align-items-end">
                                        <label for="searchSelect" class="form-label text-nowrap me-2"> theo</label>
                                        <select id="searchSelect" name="searchType" class="form-select">
                                            <option value="title" selected>Tiêu đề</option>
                                            <option value="id">Id</option>
                                        </select>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-sm">
                                <caption>Danh sách các sự kiện quyên góp</caption>
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" name="checkBoxAll" id="checkBoxAll"></th>
                                        <th>Id</th>
                                        <th>Tiêu đề</th>
                                        <th>Mô tả</th>
                                        <th>Hình đại diện</th>
                                        <th>Đã quyên góp</th>
                                        <th>Mục tiêu quyên góp</th>
                                        <th>Bắt đầu</th>
                                        <th>Kết thúc</th>
                                        <th>Người tạo</th>
                                        <th>Ngày tạo</th>
                                        <th>Trạng thái</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${donationEvents}" var="donationEvent">
                                        <tr>
                                            <td><input type="checkbox" name="checkBoxItem" value="${donationEvent.donationEventId}"></td>
                                            <td>${donationEvent.donationEventId}</td>
                                            <td name="title">${donationEvent.title}</td>
                                            <td>${donationEvent.description}</td>
                                            <td><a href="${donationEvent.image}"><img class="small-image" src="${donationEvent.image}" alt=""></a>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${donationEvent.currentDonationAmount}" type="number" />
                                                (<fmt:formatNumber value="${donationEvent.progressPercent/100}" type="percent" />)
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${donationEvent.totalDonationAmount}" type="number" />
                                            </td>
                                            <td><fmt:formatDate pattern="HH-mm dd-MM-yyyy" value="${donationEvent.startTime}" /></td>
                                            <td><fmt:formatDate pattern="HH-mm dd-MM-yyyy" value="${donationEvent.endTime}" /></td>
                                            <td>${donationEvent.createAppUser.username}</td>
                                            <td><fmt:formatDate type="both" pattern="HH-mm dd-MM-yyyy" value="${donationEvent.createTime}" /></td>
                                            <td>
                                                <c:if test="${donationEvent.eventState == 'INACTIVE'}"><span class="text-secondary">Chưa kích hoạt</span></c:if>
                                                <c:if test="${donationEvent.eventState == 'ACTIVE'}"><span class="text-success">Kích hoạt</span></c:if>
                                            </td>
                                            <td>
                                                <div class="d-flex">
                                                    <button class="btn btn-warning m-1" id=""
                                                        onclick="editDonationEvent(${donationEvent.donationEventId})">Edit</button>
                                                    <button class="btn btn-danger m-1"
                                                        onclick="deleteDonationEvent(${donationEvent.donationEventId})">Delete</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </section>
                </main>

                <!-- Delete donation event modal -->
                <div class="modal fade" id="deleteDonationEventModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xác nhận xoá sự kiện</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xoá sự kiện <strong id="donationEventDeleteInfo">...</strong></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                <button type="button" class="btn btn-danger"
                                    onclick="deleteDonationEventConfirm()">Xoá</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete ALL donation event modal -->
                <div class="modal fade" id="deleteAllDonationEventModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xác nhận xoá tất cả sự kiện</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xoá các sự kiện <strong id="donationEventDeleteAllInfo">...</strong></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                <button type="button" class="btn btn-danger"
                                    onclick="deleteDonationEventsConfirm()">Xoá</button>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body row">
                                <div class="mb-3 col-4">
                                    <label for="appUserId" class="form-label">Id</label>
                                    <input type="text" class="form-control" value="" id="donationEventId" readonly>
                                </div>
                                <div class="mb-3 col-8">
                                    <label for="donationEventTitle" class="form-label">Tiêu đề</label>
                                    <input type="text" class="form-control" value="" id="donationEventTitle">
                                    <span id="titleEmpty" class="form-text text-danger" hidden>Tiêu đề không được để
                                        trống</span>
                                </div>
                                <div class="mb-3 col-12">
                                    <label for="donationEventDetail" class="form-label">Thông tin chi tiết</label>
                                    <textarea class="form-control" id="donationEventDetail"></textarea>
                                    <span id="detailEmpty" class="form-text text-danger" hidden>Thông tin chi tiết không
                                        được để trống</span>
                                </div>
                                <div class="mb-3 col-8">
                                    <label for="donationEventImage" class="form-label">Url hình ảnh</label>
                                    <input type="text" class="form-control" value="" id="donationEventImage">
                                    <span id="imageEmpty" class="form-text text-danger" hidden>Url hình ảnh không được
                                        để trống</span>
                                </div>
                                <div class="mb-3 col-4">
                                    <label for="donationEventTotal" class="form-label">Tổng số tiền</label>
                                    <input type="number" class="form-control" value="" id="donationEventTotal">
                                    <span id="totalDonationAmountEmpty" class="form-text text-danger" hidden>Số tiền
                                        không được để trống</span>
                                    <span id="totalDonationAmountError" class="form-text text-danger" hidden>Số tiền
                                        không hợp lệ</span>
                                </div>
                                <div class="mb-3 col-6">
                                    <label for="donationEventStartTime" class="form-label">Thời gian bắt đầu</label>
                                    <input type="date" class="form-control" value="" id="donationEventStartTime"
                                        readonly>
                                </div>
                                <div class="mb-3 col-6">
                                    <label for="donationEventEndTime" class="form-label">Thời gian kết thúc</label>
                                    <input type="date" class="form-control" value="" id="donationEventEndTime">
                                    <span id="dateNotValid" class="form-text text-danger" hidden>Thời gian không hợp
                                        lệ</span>
                                    <span id="endDateSmallerThanStartDate" class="form-text text-danger" hidden>Thời
                                        gian kết thúc phải nằm sau thời gian bắt đầu</span>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                <button type="text" class="btn btn-primary float-end"
                                    onclick="editDonationEventConfirm()">Cập nhật</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add donation event modal -->
                <div class="modal fade" id="addDonationEventModal" tabindex="-1" data-bs-backdrop="static" data-bs-focus="false">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Thêm sự kiện mới</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body row">
                                <div class="mb-3 col-9">
                                    <label for="addDonationEventTitle" class="form-label">Tiêu đề</label>
                                    <input type="text" class="form-control" value="" id="addDonationEventTitle">
                                    <span id="addTitleEmpty" class="form-text text-danger" hidden>Tiêu đề không được để
                                        trống</span>
                                </div>
                                <div class="mb-3 col-3">
                                    <label for="addDonationEventTotal" class="form-label">Số tiền mục tiêu</label>
                                    <input type="number" class="form-control" value="" id="addDonationEventTotal">
                                    <span id="addTotalDonationAmountEmpty" class="form-text text-danger" hidden>Số tiền
                                        không được để trống</span>
                                    <span id="addTotalDonationAmountError" class="form-text text-danger" hidden>Số tiền
                                        không hợp lệ</span>
                                </div>
                                <div class="mb-3 col-12">
                                    <label for="addDonationEventDescription" class="form-label">Mô tả ngắn</label>
                                    <input type="text" class="form-control" value="" id="addDonationEventDescription">
                                    <span id="addDescriptionEmpty" class="form-text text-danger" hidden>Mô tả ngắn không
                                        được để trống</span>
                                </div>
                                <div class="mb-3 col-12">
                                    <label for="addDonationEventDetail" class="form-label">Thông tin chi tiết</label>
                                    <div class="form-control border" id="addDonationEventDetail" style="min-height: 350px;"></div>
                                    <script>
                                        InlineEditor
                                        .create( document.querySelector( '#addDonationEventDetail' ) )
                                        .then(newEditor => {
                                                editor = newEditor;
                                            })
                                        .catch( error => {
                                            console.error( error );
                                            } );
                                    </script>
                                    <span id="addDetailEmpty" class="form-text text-danger" hidden>Thông tin chi tiết
                                        không được để trống</span>
                                </div>
                                <div class="mb-3 col-4">
                                    <label for="addDonationEventImage" class="form-label">Hình ảnh đại diện</label>
                                    <input type="file" class="form-control" id="addDonationEventImage" accept="image/*">
                                    <span id="addImageEmpty" class="form-text text-danger" hidden>Cần tải lên một hình ảnh</span>
                                </div>
                                <div class="mb-3 col-3">
                                    <label for="addDonationEventStartTime" class="form-label">Thời gian bắt đầu</label>
                                    <input type="datetime-local" class="form-control" value="" id="addDonationEventStartTime">
                                    <span id="addDateNotValid" class="form-text text-danger" hidden>Thời gian không hợp
                                        lệ</span>
                                </div>
                                <div class="mb-3 col-3">
                                    <label for="addDonationEventEndTime" class="form-label">Thời gian kết thúc</label>
                                    <input type="datetime-local" class="form-control" value="" id="addDonationEventEndTime">
                                    <span id="addEndDateSmallerThanStartDate" class="form-text text-danger" hidden>Thời gian
                                        kết thúc phải nằm sau thời gian bắt đầu</span>
                                </div>
                                <div class="mb-3 col-2">
                                    <label for="eventState" class="form-label">Trạng thái</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="eventState" id="addDeactive"
                                            value="INACTIVE" checked>
                                        <label class="form-check-label" for="addDeactive">Chưa kích hoạt</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="eventState" id="addActive"
                                            value="ACTIVE">
                                        <label class="form-check-label" for="addActive">Kích hoạt</label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                <button type="text" class="btn btn-primary float-end"
                                    onclick="addDonationEventConfirm()">Thêm sự kiện</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <jsp:include page="footer.jsp" />
            </body>

            </html>