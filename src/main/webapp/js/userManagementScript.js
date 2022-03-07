
function addAppUser() {
    var addAppUserModal = new bootstrap.Modal(document.getElementById('addAppUserModal'), true);
    
    addAppUserModal.show();
}

function addAppUserConfirm() {
    $("#addSubmitBtn").prop("disabled", true);
    var username = $("#addUsername").val();
    var email = $("#addEmail").val();
    var fullname = $("#addFullname").val();
    var dateOfBirth = $("#addDateOfBirth").val();
    var gender = $("input:radio[name='addGender']:checked").val();
    var phoneNumber = $("#addPhoneNumber").val();
    var role = $("input:radio[name='addRole']:checked").val();
    
    $.ajax({
        type: "POST",
        url: "/AppUser",
        data: {
            username : username,
            email : email,
            fullname : fullname,
            dateOfBirth : dateOfBirth,
            gender : gender,
            phoneNumber : phoneNumber,
            role : role
        },
        dataType: "json",
        success: function (response) {
            console.log(response);
            if(response.usernameExistError) $("#addUsernameExistError").prop("hidden", false);
            else $("#addUsernameExistError").prop("hidden", true);
            if(response.usernameError) $("#addUsernameError").prop("hidden", false);
            else $("#addUsernameError").prop("hidden", true);
            if(response.emailExistError) $("#addEmailExistError").prop("hidden", false);
            else $("#addEmailExistError").prop("hidden", true);
            if(response.emailError) $("#addEmailError").prop("hidden", false);
            else $("#addEmailError").prop("hidden", true);
            if(response.fullnameError) $("#addFullnameError").prop("hidden", false);
            else $("#addFullnameError").prop("hidden", true);
            if(response.dobError) $("#addDobError").prop("hidden", false);
            else $("#addDobError").prop("hidden", true);
            if(response.phoneNumberError) $("#addPhoneNumberError").prop("hidden", false);
            else $("#addPhoneNumberError").prop("hidden", true);

            if(response.validAppUser) {
                showSuccessToast("Đã thêm người dùng " + username + ". Mật khẩu đã được gửi về email " + email);
                bootstrap.Modal.getInstance(document.querySelector('#addAppUserModal')).hide();
                setTimeout(function() {
                    window.location.replace("/user-management");
                }, 5000);
            } else {
                $("#addSubmitBtn").prop("disabled", false);
            }
        },
        error: function (error) {
            showErrorToast("Lỗi, không thể thêm người dùng");
            console.log(error);
            $("#addSubmitBtn").prop("disabled", false);
        }
    });
}

function editAppUser(id) {
    var editAppUserModal = new bootstrap.Modal(document.getElementById('editAppUserModal'), true);

    $.ajax({
        type: "GET",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            $("#appUserId").val(response.appUserId);
            $("#appUserUsername").val(response.username);
            $("#appUserEmail").val(response.email);
            $("#appUserFullname").val(response.fullname);
            $("#appUserDateOfBirth").val(response.dateOfBirth);
            $("#appUserPhoneNumber").val(response.phoneNumber);
            $("input:radio[value="+response.gender+"]").prop("checked", true);
            if(response.role == "ADMIN") $("input:radio[value='USER']").prop("disabled", true);
            $("input:radio[value="+response.role+"]").prop("checked", true);
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi!");
            console.log(error);
            return;
        }
    });

    editAppUserModal.show();
}

function editAppUserConfirm() {
    var appUserId = $("#appUserId").val();
    var fullname = $("#appUserFullname").val();
    var dateOfBirth = $("#appUserDateOfBirth").val();
    var gender = $("input:radio[name='gender']:checked").val();
    var phoneNumber = $("#appUserPhoneNumber").val();
    var role = $("input:radio[name='role']:checked").val();
    
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
                showSuccessToast("Đã cập nhật người dùng id " + appUserId);
                bootstrap.Modal.getInstance(document.querySelector('#editAppUserModal')).hide();
                setTimeout(function() {
                    window.location.replace("/user-management");
                }, 3000);
            }
        },
        error: function (error) {
            showErrorToast("Lỗi, không thể cập nhật người dùng id " + appUserId);
            console.log(error);
        }
    });
}

function deleteAppUser(id) {
    var deleteAppUserModal = new bootstrap.Modal(document.getElementById("deleteAppUserModal"), true);

    $.ajax({
        type: "GET",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            if(response.role == 'ADMIN') {
                showErrorToast("Không thể xoá quản trị viên");
                return;
            }

            $("#appUserDeleteName").html(response.username + " (" + response.fullname + ")");
            $("#appUserDeleteId").html(id);

            deleteAppUserModal.show();
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi!");
            console.log(error);
            return;
        }
    });   
}

function deleteAppUserConfirm() {
    var id = $("#appUserDeleteId").html();

    $.ajax({
        type: "DELETE",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            if(response) {
                showSuccessToast("Đã xoá người dùng id " + id);
                bootstrap.Modal.getInstance(document.querySelector('#deleteAppUserModal')).hide();
                setTimeout(function() {
                    window.location.replace("/user-management");
                }, 3000);
            } else {
                showErrorToast("Lỗi, không thể xoá người dùng id " + id);
            }
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi!");
            console.log(error);
        }
    });
}

