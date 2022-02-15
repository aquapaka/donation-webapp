$(document).ready(function () {
    $("#checkBoxAll").change(function() {
        // Change all other checkbox depend on checkBoxAll state
        if($(this).is(":checked")) {
            $("input:checkbox[name=checkBoxItem]").prop("checked", true);
        } else {
            $("input:checkbox[name=checkBoxItem]").prop("checked", false);
        }

        // Update delete all button
        if($("input:checkbox[name=checkBoxItem]:checked")[0]) {
            $("#deleteAllButton").prop("disabled", false);
        } else {
            $("#deleteAllButton").prop("disabled", true);
        }
    });

    $("input:checkbox[name=checkBoxItem]").change(function() {
        // Check checkBoxAll if all item check boxes are checked
        if($("input:checkbox[name=checkBoxItem]:checked").length == $("input:checkbox[name=checkBoxItem]").length) {
            $("#checkBoxAll").prop("checked", true);
        } else {
            $("#checkBoxAll").prop("checked", false);
        }

        // Update delete all button 
        if($("input:checkbox[name=checkBoxItem]:checked")[0]) {
            $("#deleteAllButton").prop("disabled", false);
        } else {
            $("#deleteAllButton").prop("disabled", true);
        }
    });

});

function deleteDonationEvent(id) {
    var deleteDonationEventModal = new bootstrap.Modal(document.getElementById("deleteDonationEventModal"), true);

    $.ajax({
        type: "GET",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            $("#donationEventDeleteInfo").html(response.title + "(id: " + id + ")");
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
            alert("Deleted user id " + id);
            window.location.replace("/donationEventManagement");
        },
        error: function (error) {
            alert("Error, can't delete donation event " + id);
            return;
        }
    });
}

function deleteDonationEvents() {
    var deleteAllDonationEventModal = new bootstrap.Modal(document.getElementById("deleteAllDonationEventModal"), true);
    var ids = [];

    $("input:checkbox[name=checkBoxItem]:checked").each(function() {
        ids.push($(this).val());
    });

    var deleteInfo = "<ul>";
    ids.forEach(function(id) {
        deleteInfo += "<li>id = "+id+"</li>"
    })
    deleteInfo += "</ul>";
    $("#donationEventDeleteAllInfo").html(deleteInfo);

    deleteAllDonationEventModal.show();
}

function deleteDonationEventsConfirm() {
    var ids = [];

    $("input:checkbox[name=checkBoxItem]:checked").each(function() {
        ids.push($(this).val());
    });
    
    $.ajax({
        traditional: true,
        type: "DELETE",
        url: "/DonationEvent",
        data: {
            ids : ids
        },
        dataType: "json",
        success: function (response) {
            alert("Deleted success!");
            window.location.replace("/donationEventManagement");
        },
        error: function (error) {
            alert("Error, can't delete donation events");
            return;
        }
    });
}

function editDonationEvent(id) {
    var editDonationEventModal = new bootstrap.Modal(document.getElementById('editDonationEventModal'), true);

    $(".text-danger").attr("hidden", true);

    $.ajax({
        type: "GET",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            $("#donationEventId").val(response.donationEventId);
            $("#donationEventTitle").val(response.title);
            $("#donationEventDetail").val(response.detail);
            $("#donationEventImage").val(response.images);
            $("#donationEventTotal").val(response.totalDonationAmount);
            $("#donationEventStartTime").val(response.startTime);
            $("#donationEventEndTime").val(response.endTime);
        },
        error: function (error, response) {
            alert("Not found donation event id " + id); 
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
            if(response.titleEmpty) $("#titleEmpty").attr("hidden", false);
            else $("#titleEmpty").attr("hidden", true);
            if(response.detailEmpty) $("#detailEmpty").attr("hidden", false);
            else $("#detailEmpty").attr("hidden", true);
            if(response.imageEmpty) $("#imageEmpty").attr("hidden", false);
            else $("#imageEmpty").attr("hidden", true);
            if(response.totalDonationAmountEmpty) $("#totalDonationAmountEmpty").attr("hidden", false);
            else $("#totalDonationAmountEmpty").attr("hidden", true);
            if(response.totalDonationAmountError) $("#totalDonationAmountError").attr("hidden", false);
            else $("#totalDonationAmountError").attr("hidden", true);
            if(response.dateNotValid) $("#dateNotValid").attr("hidden", false);
            else $("#dateNotValid").attr("hidden", true);
            if(response.endDateSmallerThanStartDate) $("#endDateSmallerThanStartDate").attr("hidden", false);
            else $("#endDateSmallerThanStartDate").attr("hidden", true);

            if(response.validDonationEvent) {
                window.location.replace("/donationEventManagement");
                    alert("Edited donation event id " + donationEventId);
                    return;
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

    $("#addDonationEventStartTime").val(getFormatedTodayTime());

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
            if(response.titleEmpty) $("#addTitleEmpty").attr("hidden", false);
            else $("#addTitleEmpty").attr("hidden", true);
            if(response.detailEmpty) $("#addDetailEmpty").attr("hidden", false);
            else $("#addDetailEmpty").attr("hidden", true);
            if(response.imageEmpty) $("#addImageEmpty").attr("hidden", false);
            else $("#addImageEmpty").attr("hidden", true);
            if(response.totalDonationAmountEmpty) $("#addTotalDonationAmountEmpty").attr("hidden", false);
            else $("#addTotalDonationAmountEmpty").attr("hidden", true);
            if(response.totalDonationAmountError) $("#addTotalDonationAmountError").attr("hidden", false);
            else $("#addTotalDonationAmountError").attr("hidden", true);
            if(response.dateNotValid) $("#addDateNotValid").attr("hidden", false);
            else $("#addDateNotValid").attr("hidden", true);
            if(response.endDateSmallerThanStartDate) $("#addEndDateSmallerThanStartDate").attr("hidden", false);
            else $("#addEndDateSmallerThanStartDate").attr("hidden", true);

            if(response.validDonationEvent) {
                window.location.replace("/donationEventManagement");
                    alert("Added new donation event " + title);
                    return;
            }
        },
        error: function (error) {
            console.log("ERROR" + error);
            return;
        }
    });
}

function getFormatedTodayTime() {
    // Get and set start time to today
    var date = new Date();
    var day, month, year;
    if(date.getDate() < 10) day = "0" + date.getDate();
    else day = date.getDate();
    if(date.getMonth() + 1 < 10) month = "0" + (date.getMonth() + 1);
    else month = date.getMonth() + 1;
    year = date.getFullYear();

    return year+"-"+month+"-"+day;
}