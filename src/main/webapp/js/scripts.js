$(document).ready(function () {

    $("#loginForm").submit(function doLogin(e) {
        e.preventDefault();

        var email = $("#loginForm #email").val();
        var password = $("#loginForm #password").val();
    
        $.ajax({
            type: "POST",
            url: "/doLogin",
            data: {
                email : email,
                password : password
            },
            dataType: "json",
            success: function (response) {
                
                if(response) {
                    window.location.replace("/");
                    alert("Login success!");
                } else {
                    $("#loginError").attr("hidden", false);
                }
            },
            error : function(error) {
                console.log("ERROR: ", error);
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
            url: "/doRegister",
            data: {
                username : username,
                email : email,
                password : password
            },
            dataType: "json",
            success: function (response) {
                console.log(response);
    
                if(response.registerSuccess) {
                    window.location.replace("/");
                    alert("Register success!");
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
                console.log("ERROR: ", error);
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
                    window.location.replace("/");
                    alert("Đã đặt lại mật khẩu, hãy kiểm tra email của bạn!");
                    return;
                } else {
                    $("#resetPasswordError").prop("hidden", false);
                }
            },
            error : function(error) {
                console.log("ERROR: ", error);
            }
        });
    });

});



