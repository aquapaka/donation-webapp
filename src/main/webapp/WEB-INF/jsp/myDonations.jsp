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
    <title>Lịch sử quyên góp</title>
</head>
<body>
    <fmt:setLocale value="vi_VN" scope="session"/>

    <!-- Header -->
    <jsp:include page="components/header.jsp"/>
    <main class="container-fluid py-3 py-md-4 min-vh-100 position-relative">

        <jsp:include page="components/toasts.jsp"/>

        <!-- Donation -->
        <section id="donationManagement" class="container-fluid round-border py-3 mb-2">

            <h3 class="text-center mb-3"><strong>Lịch sử quyên góp</strong></h3>

            <!-- Control buttons -->
            <div class="container-fluid">
                <form id="searchForm" class="row me-1"
                    action="${pageContext.request.contextPath}/my-donations">
                    <input id="page" name="page" value="" class="form-control" hidden>
                    <div class="col-12 col-lg-5 mb-1">
                        <input id="searchText" name="searchText" value="${searchText}" class="form-control"
                            type="search" placeholder="Tìm kiếm" aria-label="Search">
                    </div>
                    <div class="col-6 col-lg-3 mb-1">
                        <select id="searchType" name="searchType" class="form-select">
                            <option value="donationEventTitle" <c:if test="${searchType == 'donationEventTitle'}">selected</c:if>>Tìm theo tiêu đề sự kiện</option>
                            <option value="donationEventId" <c:if test="${searchType == 'donationEventId'}">selected</c:if>>Tìm theo ID sự kiện</option>
                        </select>
                    </div>
                    <div class="col-6 col-lg-3 mb-2">
                        <select id="sortType" name="sortType" class="form-select">
                            <option value="donationId" <c:if test="${sortType == 'donationId'}">selected</c:if>>Sắp xếp theo ID</option>
                            <option value="donationTime" <c:if test="${sortType == 'donationTime'}">selected</c:if>>Sắp xếp theo thời gian quyên góp</option>
                            <option value="donationAmount" <c:if test="${sortType == 'donationAmount'}">selected</c:if>>Sắp xếp theo số tiền quyên góp</option>
                        </select>
                    </div>
                    <div class="col-lg-1">
                        <button type="submit" class="btn btn-primary w-100">Tìm</button>
                    </div>
                </form>
            </div>
        </div>

            <table class="table">
                <caption>Danh sách các sự kiện quyên góp</caption>
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Sự kiện quyên góp</th>
                        <th>Thời gian</th>
                        <th>Số tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${donations}" var="donation">
                        <tr>
                            <td>${donation.donationId}</td>
                            <td>${donation.donationEvent.title} (Id: ${donation.donationEvent.donationEventId})</td>
                            <td>${donation.donationTime}</td>
                            <td><fmt:formatNumber value="${donation.donationAmount}" type="number"/></td>
                        </tr>
                    </c:forEach>
                </tbody>           
            </table>

            <!-- Pagination -->
            <div aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                <li class="page-item <c:if test='${currentPage <= 1}'>disabled</c:if>">
                    <a class="page-link" href="#" tabindex="${currentPage-1}">Previous</a>
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
                    <a class="page-link" href="#" tabindex="${currentPage+1}">Next</a>
                </li>
                </ul>
            </div>
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
    <jsp:include page="components/footer.jsp"/>
</body>
</html>