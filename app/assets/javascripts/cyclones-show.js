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

map.legendControl.addLegend(document.getElementById('legend-content').innerHTML);

//create tornado icon
var myIcon = L.icon({
  iconUrl: '../tornado-small.png',
  "iconAnchor": [12, 24]
});

var plotData = function(data) {
// Construct the lat and long for this tornado.
  var start_lat = data["location"]["start_lat"]
  var start_long = data["location"]["start_long"]
  var stop_lat = data["location"]["stop_lat"]
  if (stop_lat == 0) {
    stop_lat = start_lat;
  }
  var stop_long = data["location"]["stop_long"]
  if (stop_long == 0) {
    stop_long = start_long;
  }
  var id = data["id"]
  var scale = data["cyclone_strength"]["f_scale"]
  var month = data["date"]["month"]
  var day = data["date"]["day"]
  var year = data["date"]["year"]
  var hour = data["date"]["hour"]
  var minute = data["date"]["minute"]
  var width = data["cyclone_strength"]["width"]

  $("#date").text("Date: " + month +"/"+ day + "/" + year);
  $("#f_scale").text("F-Scale: " + scale);
  $("#start_time").text("Start Time:" + hour + ":" + minute);
  $("#width").text("Width: " + width + " meters");

polyline = L.polyline([[start_lat,start_long],[stop_lat, stop_long]], {color: '#000'})

  // add icon to map for this tornado, bind popup, and set url to redirect to specific storm dashboard.
L.marker([start_lat, start_long], {icon: myIcon, alt: id}).addTo(map)
polyline.addTo(map)

bounds = polyline.getBounds()
console.log(bounds)

if (bounds._northEast.lat - bounds._southWest.lat < 0.1) {
  map.setView([start_lat, start_long], 10);
} else {
  map.fitBounds(polyline.getBounds())
}


} //closes plotData function


