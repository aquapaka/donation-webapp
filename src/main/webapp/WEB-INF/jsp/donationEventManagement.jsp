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

                    <!-- Toasts -->
                    <div class="toast-container position-absolute top-0 end-0 m-2">          
                        <div id="errorToast" class="toast text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="d-flex">
                            <div class="toast-body">
                                ... message ...
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                            </div>
                        </div>
                        <div id="successToast" class="toast text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="d-flex">
                            <div class="toast-body">
                                ... message ...
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                            </div>
                        </div>
                    </div>

                    <!-- Donation event -->
                    <section id="donationEventManagement" class="container-fluid round-border py-3 mb-2">

                        <!-- Control buttons -->
                        <div class="container-fluid mb-5">
                            <button class="btn btn-primary float-start me-1" onclick="addDonationEvent()">Thêm sự kiện mới</button>
                            <button id="deleteAllButton" class="btn btn-danger float-start mx-1 " onclick="deleteDonationEvents()"
                                disabled>Xoá tất cả đã chọn</button>
                            <form id="searchForm" class="float-end row me-1"
                                action="${pageContext.request.contextPath}/donationEventManagement/search/1">
                                <div class="col-5">
                                    <input id="searchBox" name="searchText" value="" class="form-control"
                                        type="search" placeholder="Tìm kiếm" aria-label="Search">
                                </div>
                                <div class="col-3">
                                    <select id="searchType" name="searchType" class="form-select">
                                        <option value="title">Tìm theo tiêu đề</option>
                                        <option value="description">Tìm theo mô tả</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <select id="sortType" name="sortType" class="form-select">
                                        <option value="donationEventId" selected>Sắp xếp theo ID</option>
                                        <option value="title">Sắp xếp theo email</option>
                                        <option value="description">Sắp xếp theo username</option>
                                        <option value="totalDonationAmount">Sắp xếp theo mục tiêu</option>
                                        <option value="startTime">Sắp xếp theo thời gian bắt đầu</option>
                                        <option value="endTime">Sắp xếp theo thời gian kết thúc</option>
                                        <option value="createTime">Sắp xếp theo thời gian tạo</option>
                                    </select>
                                </div>
                                <div class="col-1">
                                    <button type="submit" class="btn btn-primary">Tìm</button>
                                </div>
                            </form>
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
                                            <td name="title" class="fixedCol">${donationEvent.title}</td>
                                            <td class="fixedCol">${donationEvent.description}</td>
                                            <td><img class="small-image" src="${donationEvent.image}" alt="" onclick="openBase64('${donationEvent.image}')"></td>
                                            <td>
                                                <fmt:formatNumber value="${donationEvent.currentDonationAmount}" type="number" />
                                                (<fmt:formatNumber value="${donationEvent.progressPercent/100}" type="percent" />)
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${donationEvent.totalDonationAmount}" type="number" />
                                            </td>
                                            
                                            <td>${donationEvent.startTime}</td>
                                            <td>${donationEvent.endTime}</td>
                                            <td>${donationEvent.createAppUser.username}</td>
                                            <td>${donationEvent.createTime} </td>
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

                        <!-- Pagination -->
                        <div aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                            <li class="page-item <c:if test='${currentPage <= 1}'>disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${currentPage-1}" tabindex="-1">Previous</a>
                            </li>
                            <li class="page-item" <c:if test='${currentPage <= 3}'>hidden</c:if>>
                                <a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/1" tabindex="-1">1</a>
                            </li>
                            <li class="page-item disabled" <c:if test='${currentPage-3 <= 1}'>hidden</c:if>>
                                <a class="page-link" href="" tabindex="-1">...</a>
                            </li>
                            <c:if test="${currentPage-2 >= 1}">
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${currentPage-2}">${currentPage-2}</a></li>
                            </c:if>
                            <c:if test="${currentPage-1 >= 1}">
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${currentPage-1}">${currentPage-1}</a></li>
                            </c:if>  
                            <li class="page-item active"><span class="page-link">${currentPage}</span></li>
                            <c:if test="${currentPage+1 <= totalPage}">
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${currentPage+1}">${currentPage+1}</a></li>
                            </c:if>
                            <c:if test="${currentPage+2 <= totalPage}">
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${currentPage+2}">${currentPage+2}</a></li>
                            </c:if>
                            <li class="page-item disabled" <c:if test='${currentPage+3 >= totalPage}'>hidden</c:if>>
                                <a class="page-link" href="" tabindex="-1">...</a>
                            </li>
                            <li class="page-item" <c:if test='${currentPage >= totalPage-2}'>hidden</c:if>>
                                <a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${totalPage}" tabindex="-1">${totalPage}</a>
                            </li>
                            <li class="page-item <c:if test='${currentPage >= totalPage}'>disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/donationEventManagement/${currentPage+1}">Next</a>
                            </li>
                            </ul>
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
                                <p>Bạn có chắc chắn muốn xoá sự kiện <strong id="donationEventDeleteInfo">...</strong> (id: <strong id="donationEventDeleteId">id</strong>)</p>
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
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Chỉnh sửa thông tin sự kiện</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body row">
                                <div class="mb-3 col-1">
                                    <label for="appUserId" class="form-label">Id</label>
                                    <input type="text" class="form-control" value="" id="donationEventId" readonly>
                                </div>
                                <div class="mb-3 col-8">
                                    <label for="donationEventTitle" class="form-label">Tiêu đề</label>
                                    <input type="text" class="form-control" value="" id="donationEventTitle">
                                    <span id="titleEmpty" class="form-text text-danger" hidden>Tiêu đề không được để
                                        trống</span>
                                </div>
                                <div class="mb-3 col-3">
                                    <label for="donationEventTotal" class="form-label">Số tiền mục tiêu</label>
                                    <input type="number" class="form-control" value="" id="donationEventTotal">
                                    <span id="totalDonationAmountEmpty" class="form-text text-danger" hidden>Số tiền
                                        không được để trống</span>
                                    <span id="totalDonationAmountError" class="form-text text-danger" hidden>Số tiền
                                        không hợp lệ</span>
                                </div>
                                <div class="mb-3 col-12">
                                    <label for="donationEventDescription" class="form-label">Mô tả ngắn</label>
                                    <input type="text" class="form-control" value="" id="donationEventDescription">
                                    <span id="descriptionEmpty" class="form-text text-danger" hidden>Mô tả ngắn không
                                        được để trống</span>
                                </div>
                                <div class="mb-3 col-12">
                                    <label for="donationEventDetail" class="form-label">Thông tin chi tiết</label>
                                    <div class="form-control border" id="donationEventDetail" style="min-height: 350px;"></div>
                                    <script>
                                        InlineEditor
                                            .create(document.querySelector('#donationEventDetail'))
                                            .then(newEditor => {
                                                editor = newEditor;
                                            })
                                            .catch(error => {
                                                console.error(error);
                                            });
                                    </script>
                                    <span id="detailEmpty" class="form-text text-danger" hidden>Thông tin chi tiết
                                        không được để trống</span>
                                </div>
                                <div class="mb-3 col-4">
                                    <label for="donationEventImage" class="form-label">Hình ảnh đại diện</label>
                                    <input type="file" class="form-control" id="donationEventImage" accept="image/*">
                                    <span id="imageEmpty" class="form-text text-danger" hidden>Cần tải lên một hình ảnh</span>
                                    <input id="imageData" type="text" hidden>
                                </div>
                                <div class="mb-3 col-3">
                                    <label for="donationEventStartTime" class="form-label">Thời gian bắt đầu</label>
                                    <input type="datetime-local" class="form-control" value="" id="donationEventStartTime">
                                    <span id="dateNotValid" class="form-text text-danger" hidden>Thời gian không hợp
                                        lệ</span>
                                </div>
                                <div class="mb-3 col-3">
                                    <label for="donationEventEndTime" class="form-label">Thời gian kết thúc</label>
                                    <input type="datetime-local" class="form-control" value="" id="donationEventEndTime">
                                    <span id="endDateSmallerThanStartDate" class="form-text text-danger" hidden>Thời gian
                                        kết thúc phải nằm sau thời gian bắt đầu</span>
                                </div>
                                <div class="mb-3 col-2">
                                    <label for="eventState" class="form-label">Trạng thái</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="eventState" id="inactive" value="INACTIVE">
                                        <label class="form-check-label" for="inactive">Chưa kích hoạt</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="eventState" id="active" value="ACTIVE">
                                        <label class="form-check-label" for="active">Kích hoạt</label>
                                    </div>
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
                                        .then(newAddEditor => {
                                                addEditor = newAddEditor;
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
                                    <label for="addEventState" class="form-label">Trạng thái</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addEventState" id="addInactive"
                                            value="INACTIVE" checked>
                                        <label class="form-check-label" for="addInactive">Chưa kích hoạt</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="addEventState" id="addActive"
                                            value="ACTIVE">
                                        <label class="form-check-label" for="addActive">Kích hoạt</label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                <button id="addSubmitBtn" type="text" class="btn btn-primary float-end"
                                    onclick="addDonationEventConfirm()">Thêm sự kiện</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <jsp:include page="footer.jsp" />
            </body>

            </html>