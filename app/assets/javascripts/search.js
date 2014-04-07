$(document).ready(function() {  
	$(".submit").on("click", function (e) {
		e.preventDefault();
		var city = $("#city").val();
		var state = $("#state").val();
		var radius = $("#radius").val();
		var url = "../api/v1/cyclones/radius_search,city:"+city + ",state:" + state + ",radius:" + radius;
		$.get(url, function(data) {window.x = data; plotData(data)}, "json");
	})
})


//specify map bounds
var southWest = L.latLng(24.396308, -124.848974),
    northEast = L.latLng(49.384358, -66.885444),
    bounds = L.latLngBounds(southWest, northEast);

//create map and set bounds
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l')
.setMaxBounds(bounds)
 
//array to hold markers, resets to empty with each submit
var markerArray = [];
//create cluster group data
var markers = new L.MarkerClusterGroup();
//create tornado icon
var myIcon = L.icon({
  iconUrl: 'tornado-small.png'
});

//On submit, iterate through returned search data and plot on map
var plotData = function(data) {
// removes markers from array
  var deleteMarkers = function() {
    for(i=0;i<markerArray.length;i++) {
    markers.removeLayer(markerArray[i]);
    }  
  } 
  //call deleteMarkers to clear map on submit
  deleteMarkers();

  // Construct the lat and long for each tornado.
  for (var i = 0; i < data.length; i++) {
    var start_lat = data[i]["start_lat"]
    var start_long = data[i]["start_long"]
    var id = data[i]["id"]
    var scale = data[i]["f_scale"]
    console.log(data[i]);

    // add icon to map for this tornado
    var marker = L.marker(new L.latLng(start_lat, start_long), {icon: myIcon});

    //bind popup to show info and redirect link to individual cyclone dashboard
    marker.bindPopup('<p>Category ' + scale + ' Tornado on </p><a href="/cyclones/'+id+'">Chase this Storm!</a>');
    //add marker to holding array
    markerArray.push(marker)
    //add marker to markers layer
    markers.addLayer(marker);

  }//close for loop

  //add markers to map for clustering effect
  map.addLayer(markers);
}; //close plotData function





