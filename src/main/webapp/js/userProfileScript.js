$(document).ready(function () {
    $("#userProfileForm").change(function (e) { 
        e.preventDefault();
        $("#userProfileForm button:reset").prop("disabled", false);
        $("#userProfileForm button:submit").prop("disabled", false);
    });

    $("button:reset").click(function(e) {
        $("#userProfileForm button:reset").prop("disabled", true);
        $("#userProfileForm button:submit").prop("disabled", true);
        $('#userProfileForm').trigger("reset");
    });

    $("#userProfileForm").submit(function(e) {
        e.preventDefault();

        $("#submitBtn").prop("disabled", true);
        var appUserId = $("#appUserId").val();
        var fullname = $("#appUserFullname").val();
        var dateOfBirth = $("#appUserDateOfBirth").val();
        var gender = $("input:radio[name='gender']:checked").val();
        var phoneNumber = $("#appUserPhoneNumber").val();
        var role = $("#appUserRole").val();

        $.ajax({
            type: "PUT",
            url: "/AppUser/" + appUserId,
            data: {
                fullname : fullname,
                dateOfBirth : dateOfBirth,
                gender : gender,
                phoneNumber : phoneNumber,
                role : role
            },
            dataType: "json",
            success: function (response) {
                if(response.fullnameError) $("#fullnameError").prop("hidden", false);
                else $("#fullnameError").prop("hidden", true);
                if(response.dobError) $("#dobError").prop("hidden", false);
                else $("#dobError").prop("hidden", true);
                if(response.phoneNumberError) $("#phoneNumberError").prop("hidden", false);
                else $("#phoneNumberError").prop("hidden", true);

                if(response.validAppUser) {
                    showSuccessToast("Đã cập nhật hồ sơ!");
                    setTimeout(function() {
                        window.location.replace("/profile");
                    }, 3000);
                } else {
                    $("#submitBtn").prop("disabled", false);
                }
            },
            error: function (error) {
                showErrorToast("Đã xảy ra lỗi");
                console.log(error);
                $("#submitBtn").prop("disabled", false);
            }
        });
    });

    $("#changePasswordForm").submit(function(e) {
        e.preventDefault();

        var oldPassword = $("#oldPassword").val();
        var newPassword = $("#newPassword").val();
        var reNewPassword = $("#reNewPassword").val();

        if(newPassword != reNewPassword) {
            $("#reNewPasswordError").prop("hidden", false);
            $("#oldPasswordError").prop("hidden", true);
            $("#newPasswordError").prop("hidden", true);
        } else {
            $("#reNewPasswordError").prop("hidden", true);

            $.ajax({
            type: "PUT",
            url: "/AppUser/changePassword",
            data: {
                oldPassword : oldPassword,
                newPassword : newPassword
            },
            dataType: "json",
            success: function (response) {
                if(response.oldPasswordError) $("#oldPasswordError").prop("hidden", false);
                else $("#oldPasswordError").prop("hidden", true);
                if(response.newPasswordError) $("#newPasswordError").prop("hidden", false);
                else $("#newPasswordError").prop("hidden", true);

                if(response.changePasswordSuccess) {
                    alert("Updated Password!");
                    window.location.replace("/profile");
                }
            },
            error: function (error) {
                alert("Error, can't update Password. Error: ", error);
            }
        });
        }       
    });
});