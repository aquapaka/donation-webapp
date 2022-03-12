$(document).ready(function () {
    $("#validateForm").submit(function (e) {
        e.preventDefault();
        var code = $("#activeCode").val();

        $.ajax({
            type: "POST",
            url: contextPath + "/validate-code",
            data: {
                code : code
            },
            dataType: "json",
            success: function (response) {
                if(response == true) {
                    showSuccessToast("Xác minh email thành công!");
                    window.location.replace(contextPath + "/");
                } else {
                    $("#wrongActiveCode").prop("hidden", false);
                }
            },
            error: function (error) {
                showErrorToast("Đã xảy ra lỗi!");
                console.log(+ error); 
            }
        });
    });
});