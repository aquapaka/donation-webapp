
$(document).ready(function () {
    
    $("#donateBtn").click(function () {
        var donateModal = new bootstrap.Modal(document.getElementById("donateModal"), true);
        var loginModal = new bootstrap.Modal(document.getElementById("loginModal"), true);

        if ($("#isSignedIn").val() == "true") {
            donateModal.show();
        } else {
            loginModal.show();
        }
    });

    $("#donateForm").submit(function donate(e) {
        e.preventDefault();

        var eventId = $("#eventId").val();
        var donateAmount = $("#donateAmount").val();

        $.ajax({
            type: "POST",
            url: contextPath + "/donation/donate",
            data: {
                eventId: eventId,
                donateAmount: donateAmount
            },
            dataType: "json",
            success: function (response) {
                if (response.donateAmountEmpty) $("#donateAmountEmpty").prop("hidden", false);
                else $("#donateAmountEmpty").prop("hidden", true);
                if (response.donateAmountError) $("#donateAmountError").prop("hidden", false);
                else $("#donateAmountError").prop("hidden", true);
                if (response.donateAmountTooSmall) $("#donateAmountTooSmall").prop("hidden", false);
                else $("#donateAmountTooSmall").prop("hidden", true);

                if (response.validDonate) {
                    showSuccessToast("Quyên góp thành công số tiền " + donateAmount.toLocaleString());
                    bootstrap.Modal.getInstance(document.querySelector('#donateModal')).hide();
                    setTimeout(function () {
                        window.location.replace(contextPath + "/donation-event?id=" + eventId);
                    }, 3000);
                }
            },
            error: function (error, response) {
                showErrorToast("Đã xảy ra lỗi!");
                console.log(error);
                console.log(response);
            }
        });
    });
});