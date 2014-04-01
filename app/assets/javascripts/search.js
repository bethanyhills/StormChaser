
$(document).ready(function() {
	$(".submit").on("click", function (e) {
		e.preventDefault();
		var city = $("#city").val();
		var state = $("#state").val();
		var radius = $("#radius").val();
		var url = "/storms/radiussearch";
		$.get(url, {city: city, state: state, radius: radius}, function(data) {plotData(data)}, "json");
	})
})

//Javascript to use Google Maps Javascript API to create map and plot our tornadoes.
function initialize() {
	//Create markers array
	markers = [];
  polylines = [];
  // Create the map.
  var mapOptions = {
    zoom: 4,
    center: new google.maps.LatLng(39.5, -98.35),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };
  //create map on page load
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

//On submit, iterate through returned search data and plot on map
function plotData(data) {
		//removes markers from array
		function deleteMarkers() {
  		setAllMap(null);
  		markers = [];
      polylines = [];
		}

		function setAllMap(map) {
		  for (var i = 0; i < markers.length; i++) {
		    markers[i].setMap(map);
	  	}
      for (var i = 0; i < polylines.length; i++) {
        polylines[i].setMap(map);
      }
		}

	deleteMarkers();

	// Construct the lat and long for each tornado.
	for (var i = 0; i < data.length; i++) {
      var start_loc = new google.maps.LatLng(data[i]["start_lat"], data[i]["start_long"])
      if (data[i]["stop_lat"] == 0) {
        var stop_loc = start_loc
      } else {
        var stop_loc = new google.maps.LatLng(data[i]["stop_lat"], data[i]["stop_long"])
      }
      //specifications for tornado icon
    var image = '../tornado-small.png';
    var stormIconOptions = {
      icon: image,
      map: map,
      position: start_loc,
      id: data[i]["id"],
    };
    //specifications for tornado line
    var stormLineOptions = {
      path: [start_loc, stop_loc],
      geodesic: true,
      strokeColor: '#2E2E2E',
      strokeOpacity: 1.0,
      strokeWeight: 2,
      map: map
    };

    // Add the icon for this tornado to the map.
    markers.push(new google.maps.Marker(stormIconOptions));
    polylines.push(new google.maps.Polyline(stormLineOptions));

		//Listens for a click event on a specific tornado and redirects to that specific tornadoe's show page.
		google.maps.event.addListener(markers[i], "click", function() {
  		window.location.href = "/storms/" + this.id;
 		});
 		}
	}

google.maps.event.addDomListener(window, 'load', initialize);
