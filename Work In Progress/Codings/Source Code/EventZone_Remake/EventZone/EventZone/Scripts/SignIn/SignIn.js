$('#SignInForm').submit(function (event) {
    //@*Validate form.*@
    var isValidForm = $('#SignInForm').validate().form();
    //@*Form is invalid.*@
    if (!isValidForm) {

        //@*Prevent this form from being submitted*@
        event.preventDefault();

        //@*Display error panel*@
        $('#alertPanelId').show();

        return false;
    }

    return true;
});

function OnSignInRequestSucceeded(data) {
    if (data.state === 1) {
        $('#myModal2').modal('toggle');
        $('.modal-backdrop').remove();
        $('#SignUl').load(location.href + " #SignUl");
    } else {
        $('#alertPanelId').empty();
        $('#alertPanelId').append("<p>Invalid username or password</p>");
        $('#alertPanelId').show();
    }
    console.log('This event is fired when a request has been sent to server successfully');
    console.log(data);
}