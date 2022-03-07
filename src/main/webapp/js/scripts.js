$(document).ready(function () {

    $("#loginForm").submit(function doLogin(e) {
        e.preventDefault();

        var email = $("#loginForm #email").val();
        var password = $("#loginForm #password").val();
    
        $.ajax({
            type: "POST",
            url: "/do-login",
            data: {
                email : email,
                password : password
            },
            dataType: "json",
            success: function (response) {
                
                if(response) {
                    showSuccessToast("Đăng nhập thành công. Đang chuyển hướng...")
                    bootstrap.Modal.getInstance(document.querySelector('#loginModal')).hide();
                    setTimeout(function() {
                        window.location.replace("/");
                    }, 3000);
                } else {
                    $("#loginError").attr("hidden", false);
                }
            },
            error : function(error) {
                showErrorToast("Đã xảy ra lỗi!");
                console.log(error);
            }
        });
    });

    $("#registerForm").submit(function doRegister(e) {
        e.preventDefault();
        
        var username = $("#resUsername").val();
        var email = $("#resEmail").val();
        var password = $("#resPassword").val();
        var rePassword = $("#resRePassword").val();
    
        if(password !== rePassword) {
            $("#resRePasswordError").attr("hidden", false);
            return;
        } else {
            $("#resRePasswordError").attr("hidden", true);
        }
    
        $.ajax({
            type: "POST",
            url: "/do-register",
            data: {
                username : username,
                email : email,
                password : password
            },
            dataType: "json",
            success: function (response) {
    
                if(response.registerSuccess) {
                    showSuccessToast("Đăng kí thành công, mã xác minh đã được gửi tới email của bạn")
                    bootstrap.Modal.getInstance(document.querySelector('#registerModal')).hide();
                    setTimeout(function() {
                        window.location.replace("/");
                    }, 3000);
                    return;
                }
    
                if(response.resEmailError) $("#resEmailError").attr("hidden", false);
                else $("#resEmailError").attr("hidden", true);
                if(response.resEmailExistError) $("#resEmailExistError").attr("hidden", false);
                else $("#resEmailExistError").attr("hidden", true);
                if(response.resUsernameError) $("#resUsernameError").attr("hidden", false);
                else $("#resUsernameError").attr("hidden", true);
                if(response.resUsernameExistError) $("#resUsernameExistError").attr("hidden", false);
                else $("#resUsernameExistError").attr("hidden", true);
                if(response.resPasswordError) $("#resPasswordError").attr("hidden", false);
                else $("#resPasswordError").attr("hidden", true);
    
            },
            error : function(error) {
                showErrorToast("Đã xảy ra lỗi!");
                console.log(error);
            }
        });
    });

    $("#forgetPasswordForm").submit(function doResetPassword(e) {
        e.preventDefault();
        var email = $("#resetPasswordEmail").val();

        $.ajax({
            type: "PUT",
            url: "/AppUser/resetPassword",
            data: {
                email : email
            },
            dataType: "json",
            success: function (response) {
                $("#resetPasswordError").prop("hidden", true);
                if(response) {
                    showSuccessToast("Đã đặt lại mật khẩu, hãy kiểm tra email của bạn!");
                    bootstrap.Modal.getInstance(document.querySelector('#forgotPasswordModal')).hide();
                    setTimeout(function() {
                        window.location.replace("/");
                    }, 3000);
                    return;
                } else {
                    $("#resetPasswordError").prop("hidden", false);
                }
            },
            error : function(error) {
                showErrorToast("Đã xảy ra lỗi");
                console.log(error);
            }
        });
    });

    $(".page-link").on("click", function(e) {
        e.preventDefault(); // cancel the link itself

        $("#page").val($(this).prop("tabindex"));

        var searchText = $("#searchText").val();
        var searchType = $("#searchType").val();
        var sortType = $("#sortType").val();
        var page = $("#page").val();

        console.log({
            searchText : searchText,
            searchType : searchType,
            sortType : sortType,
            page : page
        });

        $("#searchForm").submit();
    });
});

function showErrorToast(message) {
    let errorToast = new bootstrap.Toast(document.getElementById('errorToast'));
    $("#errorToast .toast-body").html(message);
    errorToast.show();
}

function showSuccessToast(message) {
    let successToast = new bootstrap.Toast(document.getElementById('successToast'));
    $("#successToast .toast-body").html(message);
    successToast.show();
}



