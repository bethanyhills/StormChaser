
//Javascript to use Google Maps Javascript API to create map and plot our tornadoes.
function initialize() {
  // Create the map.
  var mapOptions = {
    zoom: 4,
    center: new google.maps.LatLng(39.5, -98.35),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

    if (!gon.storms.length) {
    holder = gon.storms
    gon.storms = [holder]
    start_lat = gon.storms[0]["start_lat"]
    stop_lat = gon.storms[0]["stop_lat"]
    start_long = gon.storms[0]["start_long"]
    stop_long = gon.storms[0]["stop_long"]
    mapOptions.zoom = 6
    if (stop_lat == 0) {
      stop_lat = start_lat
      stop_long = start_long
    }
    var bounds = new google.maps.LatLngBounds();
    bounds.extend(new google.maps.LatLng(start_lat*0.98, start_long*0.98));
    bounds.extend(new google.maps.LatLng(stop_lat*1.02, stop_long*1.02));
    mapOptions.center = bounds.getCenter()
  }
  //instantiate the map
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  if (!gon.storms.length) {
    map.fitBounds(bounds);
  }

  // Construct the circle for each value in tornado.
	for (var i = 0; i < gon.storms.length; i++) {
      var start_loc = new google.maps.LatLng(gon.storms[i]["start_lat"], gon.storms[i]["start_long"])
      if (gon.storms[i]["stop_lat"] == 0) {
        var stop_loc = start_loc
      } else {
        var stop_loc = new google.maps.LatLng(gon.storms[i]["stop_lat"], gon.storms[i]["stop_long"])
      }
      //specifications for tornado circl
    var stormCircleOptions = {
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: '#FF0000',
      fillOpacity: 0.35,
      map: map,
      center: start_loc,
      id: gon.storms[i]["id"],
      radius: 20000
    };
    //specifications for tornado line
    var stormLineOptions = {
      path: [start_loc, stop_loc],
      geodesic: true,
      strokeColor: '#FF0000',
      strokeOpacity: 1.0,
      strokeWeight: 2,
      map: map
    };

    // Add the circle for this tornado to the map.
    var tornadoCircle = new google.maps.Circle(stormCircleOptions);
    var tornadoLine = new google.maps.Polyline(stormLineOptions)

    //Listens for a click event on a specific tornado and redirects to that specific tornadoe's show page.
		google.maps.event.addListener(tornadoCircle, "click", function() {
  		window.location.href = "/storms/" + this.id;
 		});
	}
}


google.maps.event.addDomListener(window, 'load', initialize);
