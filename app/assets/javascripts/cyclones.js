$(document).ready(function() {  
    var url = "./api/v1/cyclones/only_map_data:true"
    $.get(url, function(data) {window.x = data, plotData(data)}, "json");
  })

//specify map bounds
var southWest = L.latLng(24.396308, -124.848974),
    northEast = L.latLng(49.384358, -66.885444),
    bounds = L.latLngBounds(southWest, northEast);

// Create the map
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l')
  .setMaxBounds(bounds)
  
map.scrollWheelZoom.disable();
map.legendControl.addLegend(document.getElementById('legend-content').innerHTML);

//create tornado icon
var myIcon = L.icon({
  iconUrl: 'tornado-small.png'
  });

//array to hold markers, resets to empty with each submit
var markerArray = [];

//create array to hold cluster group data
var markers = new L.MarkerClusterGroup();

var plotData = function(data) {
// Construct the lat and long for each tornado.
  var deleteMarkers = function() {
    for(i=0;i<markerArray.length;i++) {
    markers.removeLayer(markerArray[i]);
    }
  }
  //call deleteMarkers to clear map on submit
  deleteMarkers();

for (var i = 0; i < data.length; i++) {
  var start_lat = data[i]["location"]["start_lat"]
  var start_long = data[i]["location"]["start_long"]
  var id = data[i]["id"]
  var scale = data[i]["cyclone_strength"]["f_scale"]

  // add icon to map for this tornado
  var marker = L.marker(new L.latLng(start_lat, start_long), {
      icon: myIcon}
  );
  //bind popup to show info and redirect link to individual cyclone dashboard
  marker.bindPopup('<p>Category ' + scale + ' Tornado</p><a href="/cyclones/'+id+'">Chase this Storm!</a>');
  //add marker to markers array
  markerArray.push(marker)
  //add marker to markers layer
  markers.addLayer(marker);

}//closes for loop


//add markers to map for clustering effect
map.addLayer(markers);
}//closes plotData function



$("#index_tab a:first").on("click", function (e) {
  e.preventDefault()
  var url = "./api/v1/cyclones/only_map_data:true"
  $.get(url, function(data) {window.x = data, plotData(data)}, "json");
})

$("#index_tab li:eq(1) a").on("click", function (e) {
  e.preventDefault()
  $(this).tab('show')
})

$("#index_tab li:eq(2) a").on("click", function (e) {
  e.preventDefault()
  $(this).tab('show')
})

$("#index_tab a:last").on("click", function (e) {
  e.preventDefault()
  $(this).tab('show')
})


  