    $('#SignUpForm').submit(function (event) {
        //@*Validate form.*@
        var isValidForm = $('#SignUpForm').validate().form();

        //@*Form is invalid.*@
        if (!isValidForm) {

           // @*Prevent this form from being submitted*@
            event.preventDefault();

            //@*Display error panel*@
            $('#alertPanelId').show();

            return false;
        }

        return true;
    });

function OnSignUpRequestSucceeded(data) {
    if (data.state === 1) {
        $('#myModal2').modal('toggle');
        alert("Thank for registering our system! We have sent you an welcome email! Return home to start looking for events.");
        $('#SignUl').load(location.href + "#SignUl");
    } else {
        $('#alertPanelId').empty();
        $('#alertPanelId').append("<p>" + data.message + "</p>");
        $('#alertPanelId').show();
    }
    console.log('This event is fired when a request has been sent to server successfully');
    console.log(data);
}