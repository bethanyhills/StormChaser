$(document).ready(function() {  
    id = window.location.href.split("/").pop();
    var url = "../api/v1/cyclones/" + id
    $.get(url, function(data) {window.cyclone = data, plotData(data), drawChart(data)}, "json");
  })

//specify map bounds
var southWest = L.latLng(24.396308, -124.848974),
    northEast = L.latLng(49.384358, -66.885444),
    bounds = L.latLngBounds(southWest, northEast);

// Create the map
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l')
  .setMaxBounds(bounds)

//create tornado icon
var myIcon = L.icon({
  iconUrl: '../tornado-small.png'
});

var plotData = function(data) {
// Construct the lat and long for this tornado.
  var start_lat = data["location"]["start_lat"]
  var start_long = data["location"]["start_long"]
  var id = data["id"]
  var scale = data["f_scale"]

  // add icon to map for this tornado, bind popup, and set url to redirect to specific storm dashboard.
L.marker([start_lat, start_long], {icon: myIcon, alt: id})
  .addTo(map)
} //closes plotData function


