$(document).ready(function () {
    $("#validateForm").submit(function (e) {
        e.preventDefault();
        var code = $("#activeCode").val();

        $.ajax({
            type: "POST",
            url: "/validateCode",
            data: {
                code : code
            },
            dataType: "json",
            success: function (response) {
                if(response == true) {
                    alert("Validate email success!");
                    window.location.replace("/");
                } else {
                    $("#wrongActiveCode").prop("hidden", false);
                }
            },
            error: function (error) {
                alert("Error submit code: " + error); 
            }
        });
    });
});