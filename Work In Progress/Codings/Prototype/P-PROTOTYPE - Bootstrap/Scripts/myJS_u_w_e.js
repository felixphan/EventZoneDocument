$(document).ready(function(){

/******************************************** SCRIPT xử lý ngay khi Load trang ***/
	$('.d_cmt_after').css("display", "none");	//Hide Comment
	$('.d_reopen_map').css("display", "none"); //Hide nút Re-open Map

/******************************************** Animation Mở Comment, Hide Map ***/
	$('.d_txt_write_cmt').click(function(){
		$('.d_right_bottom').animate({
		    height: '550px'
		}, {
		    duration: 600,
		    queue: false,   //queue: false giúp các Animation chạy đồng thời
		    complete: function() { /* Animation complete */ }
		});
		$('.d_right_top').slideUp( "slow" ); //Hide Map đi
		$('.d_cmt_before').slideUp( "slow" ); //Hide Sample comment
		$('.d_cmt_after').slideDown( "slow" ); //Display Comment
		$('.d_reopen_map').slideDown( "slow" ); //Display nút Re-open Map
	});

/******************************************** Animation Hide Comment, Mở Map ***/
	$('.d_reopen_map').click(function(){
		$('.d_right_bottom').animate({
		    height: '230px'
		}, {
		    duration: 600,
		    queue: false,   //queue: false giúp các Animation chạy đồng thời
		    complete: function() { /* Animation complete */ }
		});
		$('.d_right_top').slideToggle( "slow" ); //Mở lại Map
		$('.d_cmt_before').slideToggle( "slow" ); //Mở lại Sample comment
		$('.d_cmt_after').slideToggle( "slow" ); //Hide Comment
		$('.d_reopen_map').slideToggle( "slow" ); //Hide nút Re-open Map
	});
	
	/*** OUTSOURCE: Google Map ***/
	function init_map() {
	var var_location = new google.maps.LatLng(21.013629,105.526556);

	var var_mapoptions = {
	  center: var_location,
	  zoom: 15
	};

	var var_marker = new google.maps.Marker({
		position: var_location,
		map: var_map,
		title:"Venice"});

	var var_map = new google.maps.Map(document.getElementById("map-container"),
	    var_mapoptions);

	var_marker.setMap(var_map);	

	}

	google.maps.event.addDomListener(window, 'load', init_map);
	/*** End of OUTSOURCE: Google Map ***/

	
});