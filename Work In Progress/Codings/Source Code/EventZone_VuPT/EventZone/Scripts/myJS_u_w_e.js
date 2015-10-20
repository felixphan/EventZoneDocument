$(document).ready(function(){

	$('#i_comment_btn').click(function(){
		$('.d_comment_report').animate({
		    height: '500'
		}, {
		    duration: 500,
		    queue: false,   //queue: false giúp các Animation chạy đồng thời
		    complete: function() { /* Animation complete */ }
		});

		$('.d_comment_report').animate({
		    top: '-300'
		}, {
		    duration: 500,
		    queue: false,
		    complete: function() { /* Animation complete */ }
		});
		
		$('.d_cmt_content_cover').addClass('d_cmt_extend');
		$('.d_cmt_content_cover').addClass('d_cmt_extend_2');
	});
	

	/*** OUTSOURCE: tùy chỉnh scroll bar ***/
	function changeSize() {
    var width = parseInt($("#Width").val());
    var height = parseInt($("#Height").val());

    $(".d_scrollbar_style").width(width).height(height);

    // update scrollbars
    $('.d_scrollbar_style').perfectScrollbar('update');

    // or even with vanilla JS!
    Ps.update(document.getElementById('.d_scrollbar_style'));
	};

	$(function() {
	    $('.d_scrollbar_style').perfectScrollbar();

	    // with vanilla JS!
	    Ps.initialize(document.getElementById('.d_scrollbar_style'));
	});
	/*** End of OUTSOURCE: tùy chỉnh scroll bar ***/
});