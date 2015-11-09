function errorShow(title, message) {
    $("#error-title").text(title)
    console.log(title)
    $("#error-message").text(message)
    $("#error-modal").modal('show')
}