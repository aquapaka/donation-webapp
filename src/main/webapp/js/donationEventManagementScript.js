
function deleteDonationEvent(id) {
    var deleteDonationEventModal = new bootstrap.Modal(document.getElementById("deleteDonationEventModal"), true);

    $.ajax({
        type: "GET",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            $("#donationEventDeleteName").html(response.title);
            $("#donationEventDeleteId").html(id);
        },
        error: function () {
            return;
        }
    });

    deleteDonationEventModal.show();
}

function deleteDonationEventConfirm() {
    var id = $("#donationEventDeleteId").html();

    $.ajax({
        type: "DELETE",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            if(response == true) {
                alert("Deleted user id " + id);
                window.location.replace("/donationEventManagement");
            } else {
                alert("Error, can't delete donation event " + id);
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
            return;
        }
    });
}

function editDonationEvent(id) {
    var editDonationEventModal = new bootstrap.Modal(document.getElementById('editDonationEventModal'), true);

    $.ajax({
        type: "GET",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            console.log(response);
            $("#donationEventId").val(response.donationEventId);
            $("#donationEventTitle").val(response.title);
            $("#donationEventDetail").html(response.detail);
            $("#donationEventImage").val(response.images);
            $("#donationEventTotal").val(response.totalDonationAmount);
            $("#donationEventStartTime").val(convertDate(response.startTime));
            $("#donationEventEndTime").val(convertDate(response.endTime));
        },
        error: function () {
            return;
        }
    });

    editDonationEventModal.show();
}

function editDonationEventConfirm() {
    var donationEventId = $("#donationEventId").val();
    var title = $("#donationEventTitle").val();
    var detail = $("#donationEventDetail").val();
    var image = $("#donationEventImage").val();
    var total = $("#donationEventTotal").val();
    var endTime = $("#donationEventEndTime").val();

    $.ajax({
        type: "PUT",
        url: "/DonationEvent/" + donationEventId,
        data: {
            title : title,
            detail : detail,
            image : image,
            total : total,
            endTime : endTime
        },
        dataType: "json",
        success: function (response) {
            if(response == true) {
                alert("Updated donation event id " + donationEventId);
                window.location.replace("/donationEventManagement");
            } else {
                alert("Error, can't update donation event " + donationEventId);
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
            return;
        }
    });
}

function addDonationEvent() {
    var addDonationEventModal = new bootstrap.Modal(document.getElementById('addDonationEventModal'), true);

    // Get and set start time to today
    var date = new Date();
    var dateArray = [date.getFullYear(), date.getMonth()+1, date.getDate()];
    $("#addDonationEventStartTime").val(convertDate(dateArray));

    addDonationEventModal.show();
}

function addDonationEventConfirm() {
    var title = $("#addDonationEventTitle").val();
    var detail = $("#addDonationEventDetail").val();
    var image = $("#addDonationEventImage").val();
    var total = $("#addDonationEventTotal").val();
    var startTime = $("#addDonationEventStartTime").val();
    var endTime = $("#addDonationEventEndTime").val();

    $.ajax({
        type: "POST",
        url: "/DonationEvent/",
        data: {
            title : title,
            detail : detail,
            image : image,
            total : total,
            startTime : startTime,
            endTime : endTime
        },
        dataType: "json",
        success: function (response) {
            if(response == true) {
                alert("Added donation event " + title);
                window.location.replace("/donationEventManagement");
            } else {
                alert("Error, can't add donation event " + donationEventId);
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
            return;
        }
    });
}

function convertDate(dateArray) {
    var year = dateArray[0];
    var month = dateArray[1];
    if(month < 10) month = "0" + month;
    var day = dateArray[2];
    if(day < 10) day = "0" + day;

    return year+"-"+month+"-"+day;
}