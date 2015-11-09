$(document).ready(function(){

	/*** SCRIPT xử lý ngay khi Load trang ***/
	if($('#i_event_thumbnail').width() < $('#i_event_thumbnail').height()){
		$('.crop img').addClass('portrait');
	}

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
	

	
});