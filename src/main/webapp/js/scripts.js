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
                
                if(response == true) {
                    window.location.replace("/");
                    alert("Login success!");
                } else {
                    $("#loginError").attr("hidden", false);
                }
            },
            error : function(e) {
                console.log("ERROR: ", e);
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
            error : function(e) {
                console.log("ERROR: ", e);
            }
        });
    });
});







