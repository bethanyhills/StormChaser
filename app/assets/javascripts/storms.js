// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// var citymap = {};
// citymap['chicago'] = {
  // center: new google.maps.LatLng(41.878113, -87.629798),
//   population: 2842518
// };
// citymap['newyork'] = {
//   center: new google.maps.LatLng(40.714352, -74.005973),
//   population: 8143197
// };
// citymap['losangeles'] = {
//   center: new google.maps.LatLng(34.052234, -118.243684),
//   population: 3844829
// };
// var tornadoCircle=[];

function initialize() {
  // Create the map.
  var mapOptions = {
    zoom: 4,
    center: new google.maps.LatLng(39.5, -98.35),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  if (!gon.storms.length) {
    holder = gon.storms
    gon.storms = [holder]
  }

  // Construct the circle for each value in citymap.
	for (var i = 0; i < gon.storms.length; i++) {
    var stormOptions = {
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: '#FF0000',
      fillOpacity: 0.35,
      map: map,
      center: new google.maps.LatLng(gon.storms[i]["start_lat"], gon.storms[i]["start_long"]),
      id: gon.storms[i]["id"],
      radius: 142000
    };
    // Add the circle for this city to the map.
    var tornadoCircle = new google.maps.Circle(stormOptions);


		google.maps.event.addListener(tornadoCircle, "click", function() {
  		window.location.href = "/storms/" + tornadoCircle["id"];
 		});
	}
}


google.maps.event.addDomListener(window, 'load', initialize);
