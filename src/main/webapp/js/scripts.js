$(document).ready(function () {
    
});

function doLogin() {
    var email = $("#email").val();
    var password = $("#password").val();

    $.ajax({
        type: "POST",
        url: "/doLogin",
        data: {
            email : email,
            password : password
        },
        dataType: "json",
        success: function (response) {
            console.log(response);
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

}

function doRegister() {
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
}

function deleteAppUser(id) {
    var deleteDonationEventModal = new bootstrap.Modal(document.getElementById('deleteDonationEventModal'), true);

    $.ajax({
        type: "GET",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            $("#appUserDeleteName").html(response.username + " (" + response.fullname + ")");
            $("#appUserDeleteId").html(id);
        },
        error: function () {
            return;
        }
    });

    deleteDonationEventModal.show();
}

function deleteAppUserConfirm() {
    var deleteDonationEventModal = new bootstrap.Modal(document.getElementById('deleteDonationEventModal'), true);
    var id = $("#appUserDeleteId").html();

    $.ajax({
        type: "DELETE",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            if(response == true) {
                alert("Deleted user id " + id);
                window.location.replace("/userManagement");
            } else {
                alert("Error, can't delete app user " + id);
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
            return;
        }
    });
}