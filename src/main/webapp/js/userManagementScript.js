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
            $("input:radio[value="+response.role+"]").prop("checked", true);
        },
        error: function (error) {
            console.log("Error: ", error);
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
                alert("Updated user id " + appUserId);
                window.location.replace("/userManagement");
            }
        },
        error: function (error) {
            alert("Error, can't update app user " + appUserId + ". Error: ", error);
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
            $("#appUserDeleteName").html(response.username + " (" + response.fullname + ")");
            $("#appUserDeleteId").html(id);
        },
        error: function () {
            return;
        }
    });

    deleteAppUserModal.show();
}

function deleteAppUserConfirm() {
    var id = $("#appUserDeleteId").html();

    $.ajax({
        type: "DELETE",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            if(response) {
                alert("Deleted user id " + id);
                window.location.replace("/userManagement");
            } else {
                alert("Error, can't delete app user " + id + ". Maybe user has admin role");
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
        }
    });
}

