// simple smooth scrolling for bootstrap scroll spy nav
// credit http://stackoverflow.com/questions/14804941/how-to-add-smooth-scrolling-to-bootstraps-scroll-spy-function

$('a[href^="#"]').on('click', function(event) {
    var target = $(this.href);
    if( target.length ) {
        event.preventDefault();
        $('div').animate({
            scrollTop: target.offset().top
        }, 1000);
    }
});