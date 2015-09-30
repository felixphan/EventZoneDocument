$(document).ready(function(){
	
/*** xử lý khi Load trang ***/
	var windows_height = $(window).height();	// Lấy chiều cao Browser
	var windows_width = $(window).width();	// Lấy chiều ngang Browser
	$('.d_bottom_3_column_container').css("top", windows_height);	// che 3 cột bằng chiều cao Browser
	$('.d_bottom_3_column_container').transition({ y: '-50px' });	// cho 3 columns nhô lên
	$('#i_bg_video_blur').transition({ opacity: 0 }, 200);		// Blur nền khi hiện 3 cột
	$('#i_btn_Cate').css("top", "-20px");	// Hide Category đi	//
	$('.text1_container').transition({scale: 0}, 0); // Đưa ra ngoài để trôi vào //
	$('.text2_container').transition({scale: 0}, 0);
	$('.cate_container').transition({scale: 0}, 0);
	$('.text1_container').transition({ scale: 1 }, 600, 'ease');
	$('.text2_container').transition({ scale: 1 }, 1000, 'ease');
	$('.cate_container').transition({ scale: 1 }, 1800, 'ease');

/*** Xử lý tích chọn All Category thì tất cả Category khác đều được tích ***/
	var item_All_is_checked = false;
	$('#i_chbox_All').click(function(){
		if($('#i_chbox_All').prop('checked')){
			$('.item_checked').prop('checked', true);
		} else {
			$('.item_checked').prop('checked', false);
		};
	});
	/*** End of Xử lý tích chọn All Category thì tất cả Category khác đều được tích ***/
    
/*** Nâng cấp tắt, mở Category ***/
	$('#i_btn_Cate').click(function(){
		$('#i_Cate_dropdown').slideToggle();
	});
	/*** End of Nâng cấp tắt, mở Category ***/

/*** Kích hoạt Sign In, Sign Up tương ứng
	$('#i_btn_signin').click(function(){
		$('.d_signup_tab').removeClass('active');
		$('.d_signin_tab').addClass('active');
		$('#i_signin_section').addClass('active');
	});
	$('#i_btn_signup').click(function(){
		$('.d_signin_tab').removeClass('active');
		$('.d_signup_tab').addClass('active');
		$('#i_signup_section').addClass('active');
	}); ***/
	/*** End of Nâng cấp tắt, mở Category ***/

/*** Scroll 3 columns sự kiện lên/xuống ***/
    var lastScrollTop = 0;
    $(window).scroll(function(event){
   	var st = $(this).scrollTop();
	    if (st > lastScrollTop){
	        $('.d_bottom_3_column_container').transition({ y: '-500px' });
	        $('#i_bg_video_blur').transition({ opacity: 1 });
	        $('.d_middle_container').transition({ opacity: 0 }, 100);
	        $('body').css('height', windows_height);
	        $('#i_search').transition({x: "120px"}, 'ease');
	        $('#i_btn_Cate').transition({y: "36px"}, 'ease');
	    } else {
	        $('.d_bottom_3_column_container').transition({ y: '-50px' });
	        $('#i_bg_video_blur').transition({ opacity: 0, duration: 1000 });
	        $('.d_middle_container').transition({ opacity: 1, delay: 100});
	        $('#i_search').transition({x: "0px"}, 'ease');
	        $('#i_btn_Cate').transition({y: "0px"}, 'ease');
	        $('#i_Cate_dropdown').slideUp();
	    }
	    lastScrollTop = st;
	});
	/*** End of Scroll 3 columns sự kiện lên/xuống ***/

/*** OUTSOURCE: tùy chỉnh scroll bar ***/
	function changeSize() {
    var width = parseInt($("#Width").val());
    var height = parseInt($("#Height").val());

    $(".d_scrollbar_style").width(width).height(height);

    // update scrollbars
    $('.d_scrollbar_style').perfectScrollbar('update');

    // or even with vanilla JS!
    Ps.update(document.getElementById('.d_scrollbar_style'));
	}

	$(function() {
	    $('.d_scrollbar_style').perfectScrollbar();

	    // with vanilla JS!
	    Ps.initialize(document.getElementById('.d_scrollbar_style'));
	});
	/*** End of OUTSOURCE: tùy chỉnh scroll bar ***/

/***  ***/
	var logoHeight = $('#d_thumb img').height();
    if (logoHeight < 90) {
        var margintop = (90 - logoHeight) / 2;
        $('#d_thumb img').css('margin-top', margintop);
    }

/*** BOOTSTRAP: tooltip ***/
	$(document).ready(function(){
	    $('[data-toggle="tooltip"]').tooltip();   
	});
	/*** End of BOOTSTRAP: tooltip ***/
});

/*
	
	
	
*/