
$(document).ready(function() {
  // Create the map
  
	$(".submit").on("click", function (e) {
		e.preventDefault();
		var city = $("#city").val();
		var state = $("#state").val();
		var radius = $("#radius").val();
		var url = "/cyclones/radiussearch";
		$.get(url, {city: city, state: state, radius: radius}, function(data) {window.x = data; plotData(data)}, "json");
	})
})

var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l')
  .setView([38.5, -98.00], 4);
 
 var markerArray = [];
 var markers = new L.MarkerClusterGroup();

//On submit, iterate through returned search data and plot on map
function plotData(data) {
	// removes markers from array
	function deleteMarkers() {
    for(i=0;i<markerArray.length;i++) {
    markers.removeLayer(markerArray[i]);
    }  
	}
  deleteMarkers();
  //create tornado icon
var myIcon = L.icon({
  iconUrl: 'tornado-small.png'
  //create array to hold cluster group data
});

// Construct the lat and long for each tornado.
for (var i = 0; i < data.length; i++) {
  var start_lat = data[i]["start_lat"]
  var start_long = data[i]["start_long"]
  var id = data[i]["id"]
  var scale = data[i]["f_scale"]
  console.log(data[i]);

  // add icon to map for this tornado
  var marker = L.marker(new L.latLng(start_lat, start_long), {
      icon: myIcon}
  );
  //bind popup to show info and redirect link to individual cyclone dashboard
  marker.bindPopup('<p>Category ' + scale + ' Tornado</p><a href="/cyclones/'+id+'">Chase this Storm!</a>');
  markerArray.push(marker)
  //add marker to markers array
  markers.addLayer(marker);

  }//closes for loop

  //add markers to map for clustering effect

map.addLayer(markers);
};





