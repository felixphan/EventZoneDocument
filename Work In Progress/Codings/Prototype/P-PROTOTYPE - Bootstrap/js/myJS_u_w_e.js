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