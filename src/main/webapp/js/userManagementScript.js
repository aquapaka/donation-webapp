
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

function editAppUser(id) {
    var editAppUserModal = new bootstrap.Modal(document.getElementById('editAppUserModal'), true);

    $.ajax({
        type: "GET",
        url: "/AppUser/" + id,
        dataType: "json",
        success: function (response) {
            console.log(response);
            $("#appUserId").val(response.appUserId);
            $("#appUserUsername").val(response.username);
            $("#appUserEmail").val(response.email);
            $("#appUserFullname").val(response.fullname);
            // Set date
            var year = response.dateOfBirth[0];
            var month = response.dateOfBirth[1];
            if(month < 10) month = "0" + month;
            var day = response.dateOfBirth[2];
            if(day < 10) day = "0" + day;
            $("#appUserDateOfBirth").val(year+"-"+month+"-"+day);
            // Set gender
            if(response.gender == false) {
                $("#male").prop("checked", true);
                $("#female").prop("checked", false);
            } else {
                $("#male").prop("checked", false);
                $("#female").prop("checked", true);
            }
            $("#appUserPhoneNumber").val(response.phoneNumber);
            if(response.role === "ADMIN") {
                $("#user").prop("checked", false);
                $("#admin").prop("checked", true);
            } else {
                $("#user").prop("checked", true);
                $("#admin").prop("checked", false);
            }
        },
        error: function () {
            return;
        }
    });

    editAppUserModal.show();
}

function editAppUserConfirm() {
    var appUserId = $("#appUserId").val();
    var fullname = $("#appUserFullname").val();
    var dateOfBirth = $("#appUserDateOfBirth").val();
    var gender = $("[name='gender']:checked").val();
    var phoneNumber = $("#appUserPhoneNumber").val();
    var role = $("[name='role']:checked").val();

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
            if(response == true) {
                alert("Updated user id " + appUserId);
                window.location.replace("/userManagement");
            } else {
                alert("Error, can't update app user " + appUserId);
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
            return;
        }
    });
}