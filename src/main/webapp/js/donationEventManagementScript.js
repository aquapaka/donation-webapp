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
            if(response.totalDonationCount > 0) {
                showErrorToast("Không thể xoá, sự kiện đã có lượt quyên góp");
                return;
            }
            $("#donationEventDeleteInfo").html(response.title);
            $("#donationEventDeleteId").html(id);

            deleteDonationEventModal.show();
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi!");
            console.log(error);
            return;
        }
    });
}

function deleteDonationEventConfirm() {
    var id = $("#donationEventDeleteId").html();

    $.ajax({
        type: "DELETE",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            showSuccessToast("Xoá sự kiện thành công");
            bootstrap.Modal.getInstance(document.querySelector('#deleteDonationEventModal')).hide();
            setTimeout(function() {
                window.location.replace("/donation-event-management");
            }, 3000);
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi");
            console.log(error);
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
        deleteInfo += "<li>id = "+id+"</li>";
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
            showSuccessToast("Xoá các sự kiện thành công");
            bootstrap.Modal.getInstance(document.querySelector('#deleteAllDonationEventModal')).hide();
            setTimeout(function() {
                window.location.replace("/donation-event-management");
            }, 3000);
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi!");
            console.log(error);
        }
    });
}

let editor;

function editDonationEvent(id) {
    var editDonationEventModal = new bootstrap.Modal(document.getElementById('editDonationEventModal'), true);

    $(".text-danger").attr("hidden", true);

    $.ajax({
        type: "GET",
        url: "/DonationEvent/" + id,
        dataType: "json",
        success: function (response) {
            $("#donationEventId").val(response.donationEventId);
            $("#donationEventDescription").val(response.description);
            $("#donationEventTitle").val(response.title);
            editor.setData(response.detail);
            $("#imageData").val(response.image);
            $("#donationEventTotal").val(response.totalDonationAmount);
            $("#donationEventStartTime").val(response.startTime);
            $("#donationEventEndTime").val(response.endTime);
            $("input:radio[value="+response.eventState+"]").prop("checked", true);
        },
        error: function (error) {
            showErrorToast("Đã xảy ra lỗi!");
            console.log(error); 
        }
    });

    editDonationEventModal.show();
}

function editDonationEventConfirm() {
    var donationEventId = $("#donationEventId").val();
    var title = $("#donationEventTitle").val();
    var description = $("#donationEventDescription").val();
    var detail = editor.getData();
    var imageFiles = $('#donationEventImage').prop("files");
    var total = $("#donationEventTotal").val();
    var startTime = $("#donationEventStartTime").val();
    var endTime = $("#donationEventEndTime").val();
    var eventState = $("input:radio[name=eventState]:checked").val();

    var image = "";
    getBase64(imageFiles[0])
    .then(data => image = data)
    .finally(() => {
        if(imageFiles.length == 0) image = $("#imageData").val();

        $.ajax({
            type: "PUT",
            url: "/DonationEvent/" + donationEventId,
            data: {
                title : title,
                description : description,
                detail : detail,
                image : image,
                total : total,
                startTime : startTime,
                endTime : endTime,
                eventState : eventState
            },
            dataType: "json",
            success: function (response) {
                if(response.titleEmpty) $("#titleEmpty").attr("hidden", false);
                else $("#titleEmpty").attr("hidden", true);
                if(response.descriptionEmpty) $("#descriptionEmpty").attr("hidden", false);
                else $("#descriptionEmpty").attr("hidden", true);
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
                    showSuccessToast("Chỉnh sửa thành công");
                    bootstrap.Modal.getInstance(document.querySelector('#editDonationEventModal')).hide();
                    setTimeout(function() {
                        window.location.replace("/donation-event-management");
                    }, 3000);
                }
            },
            error: function (error) {
                showErrorToast("Đã xảy ra lỗi!");
                console.log(error);
            }
        });
    });
}

let addEditor;

function addDonationEvent() {
    var addDonationEventModal = new bootstrap.Modal(document.getElementById('addDonationEventModal'), true);

    addDonationEventModal.show();
}

function addDonationEventConfirm() {
    $("#addSubmitBtn").prop("disabled", true);
    var title = $("#addDonationEventTitle").val();
    var description = $("#addDonationEventDescription").val();
    var detail = addEditor.getData();
    var imageFiles = $('#addDonationEventImage').prop("files");
    var total = $("#addDonationEventTotal").val();
    var startTime = $("#addDonationEventStartTime").val();
    var endTime = $("#addDonationEventEndTime").val();
    var eventState = $("input:radio[name=addEventState]:checked").val();

    if(imageFiles.length == 0) $("#addImageEmpty").attr("hidden", false);
    
    // Convert image data
    var image = "";
    getBase64(imageFiles[0])
    .then(data => image = data)
    .finally( () => {
        $.ajax({
            type: "POST",
            url: "/DonationEvent/",
            data: {
                title : title,
                description : description,
                detail : detail,
                image : image,
                total : total,
                startTime : startTime,
                endTime : endTime,
                eventState : eventState
            },
            dataType: "json",
            success: function (response) {
                console.log(response);
                if(response.titleEmpty) $("#addTitleEmpty").attr("hidden", false);
                else $("#addTitleEmpty").attr("hidden", true);
                if(response.detailEmpty) $("#addDetailEmpty").attr("hidden", false);
                else $("#addDetailEmpty").attr("hidden", true);
                if(response.descriptionEmpty) $("#addDescriptionEmpty").attr("hidden", false);
                else $("#addDescriptionEmpty").attr("hidden", true);
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
                    showSuccessToast("Đã thêm sự kiện " + title);
                    bootstrap.Modal.getInstance(document.querySelector('#addDonationEventModal')).hide();
                    setTimeout(function() {
                        window.location.replace("/donation-event-management");
                    }, 3000);
                } else {
                    $("#addSubmitBtn").prop("disabled", false);
                }
            },
            error: function (error) {
                $("#addSubmitBtn").prop("disabled", false);
                showErrorToast("Đã xảy ra lỗi!");
                console.log(error);
            }
        });
    });
}

function getBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);  
    reader.onload = () => resolve(reader.result);
    reader.onerror = error => reject(error);
  });
}

function openBase64(base64URL){
    var win = window.open();
    win.document.write('<iframe src="' + base64URL  + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>');
}
