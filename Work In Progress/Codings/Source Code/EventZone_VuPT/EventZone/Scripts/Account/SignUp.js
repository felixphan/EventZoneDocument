$("#SignUpForm").submit(function(event) {
    //@*Validate form.*@
    var isValidForm = $("#SignUpForm").validate().form();

    //@*Form is invalid.*@
    if (!isValidForm) {
        $("#signup-Password").val("");
        $("#signup-ConfirmPassword").val("");
        return false;
    }
    //hash password
    $("#signup-Password").val($.md5($("#signup-Password").val()));
    $("#signup-ConfirmPassword").val($.md5($("#signup-ConfirmPassword").val()));
    return true;
});

function OnSignUpRequestSucceeded(data) {
    if (data.state === 1) {
        $("#myModal2").modal("toggle");
        $(".modal-backdrop").remove();
        $("#SignUl").load(location.href + " #SignUl");
        alert("Thank for signing up for our system! We sent you an welcome email! Return home to start looking for events.");
    } else {
        $("#alertPanelSignUp").empty();
        $("#alertPanelSignUp").append("<p>" + data.message + "</p>");
        $("#alertPanelSignUp").show();
    }
    console.log("This event is fired when a request has been sent to server successfully");
    console.log(data);
}