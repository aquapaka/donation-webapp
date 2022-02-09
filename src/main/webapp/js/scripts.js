$(document).ready(function () {
    
});

function doLogin() {
    var email = $("#email").val();
    var password = $("#password").val();

    $.ajax({
        type: "POST",
        url: "../doLogin",
        data: {
            email : email,
            password : password
        },
        dataType: "json",
        success: function (response) {
            console.log(response);
            if(response == true) {
                window.location.replace("..");
            } else {
                $("#loginError").removeAttr("hidden");
            }
        },
        error : function(e) {
            console.log("ERROR: ", e);
        }
    });

}