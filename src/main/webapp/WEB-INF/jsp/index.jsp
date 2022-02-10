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

        <!-- Big banner -->
        <img class="img-fluid" src="img/momo.jpg" alt="main-image">
        
        <!-- Introduction to the app -->
        <section id="introduction" class="container py-2 my-3 py-md-5 my-md-5">
            <div class="row">
                <div class="col-md-6">
                    <h1><b>Hệ thống quyên góp tiền từ thiện DONATION</b></h1>
                    <p>DONATION là hệ thống quyên góp trực tuyến nhằm mục đích giúp mọi người có thể dễ dàng quyên góp và ủng hộ cho những người có hoàn cảnh khó khăn ở mọi nơi.</p>
                    <a href="#donationEvents"><button class="btn btn-primary">Quyên góp ngay</button></a>
                </div>
                <div class="col-md-6">
                    <img class="img-fluid w-100" src="img/images.png" alt="">
                </div>
            </div>
        </section>

        <!-- Donation Event -->
        <jsp:include page="donationEvents.jsp"/>

        <!-- Contact -->
        <section id="contact" class="container-fluid">
            <div class="container p-5">
                <div class="row">
                    <div class="col-12 col-md-4">
                        <h4><strong class="ps-1">Tổ chức hỗ trợ quyên góp từ thiện trực tuyến DONATION</strong></h4>
                        <span>70/21A13 Tân Hoà Đông, Phường 14, Quận 6, TP. Hồ Chí Minh</span>
                    </div>
                    <div class="col-12 col-md-4">
                        <h4><strong class="ps-1">LIÊN HỆ HỖ TRỢ</strong></h4>
                        <span>Hotline: <b>1900 1009</b> <i>(1000đ/phút)</i></span><br>
                        <span>Email: <b>hotro@donation.vn</b></span><br>
                    </div>
                    <div class="col-12 col-md-4">
                        <h4><strong class="ps-1">AQUAPAKA</strong></h4>
                        <span>Phone: <b>+8488 633 2278</b></span><br>
                        <span>Email: <b>aqua.tamlong@gmail.com</b></span><br>
                        <span>Website: <b><a href="https://aquapaka.github.io/">https://aquapaka.github.io/</a></b></span><br>
                    </div>
                </div>
            </div>
        </section>
    </main>
</body>
</html>