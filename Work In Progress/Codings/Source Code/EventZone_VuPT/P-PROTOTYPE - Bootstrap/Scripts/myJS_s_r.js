$(document).ready(function(){
/*** xử lý khi Load trang ***/
	$('.d_user').hide();	// Tắt Inside User đi


/*** Tắt mở Sign In & User ***/
	$('#i_btn_ani').click(function(){
		$('#i_btn_signin').toggle();
		$('.d_user').toggle();
	});
	/*** End of Nâng cấp tắt, mở Category ***/

	/*$('#i_btn_signout').click(function(){
		$('#i_btn_signin').show();
		$('.d_user').hide();
	});*/
});