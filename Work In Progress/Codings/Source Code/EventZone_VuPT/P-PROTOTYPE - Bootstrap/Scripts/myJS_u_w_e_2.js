$(document).ready(function(){


	if($('#i_event_thumbnail').width() < $('#i_event_thumbnail').height()){
		$('.crop img').addClass('portrait');
	}

/*
if($('.crop_2 img').width() < $('.crop_2 img').height()){
	$('.crop_2 img').addClass('portrait');
}*/

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