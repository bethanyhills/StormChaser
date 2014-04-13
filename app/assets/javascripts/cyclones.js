$(document).ready(function() {
    var url = "../api/v1/search/strongest/only_map_data:true"
    $.get(url, function(data) {window.x = data, plotData(data)}, "json");
  })

// Create the map
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l', {
        minZoom: 4,
        maxBounds: [[24.396308,-124.848974],[49.384358, -66.885444]]})

map.scrollWheelZoom.disable();
map.legendControl.addLegend(document.getElementById('legend-content').innerHTML);

//create tornado icon
var myIcon = L.icon({
  iconUrl: '../tornado-small.png',
  "iconAnchor": [12, 24]
  });

//array to hold markers, resets to empty with each submit
var markerArray = [];
var lineArray = [];

//create array to hold cluster group window.x
var markers = new L.MarkerClusterGroup({disableClusteringAtZoom: 7});

//function to draw cyclone paths on map
var plotPaths = function(data) {
  //iterate through window.x for path info
  for (var i = 0; i < window.x.length; i++) {
  var start_lat = window.x[i]["location"]["start_lat"]
  var start_long = window.x[i]["location"]["start_long"]
  var stop_lat = window.x[i]["location"]["stop_lat"]
  if (stop_lat == 0) {
    stop_lat = start_lat;
  }
  var stop_long = window.x[i]["location"]["stop_long"]
  if (stop_long == 0) {
    stop_long = start_long;
  }
  //specify path properties
  var polyline_options = {
    color: '#0B610B',
    weight: 1
  };
  //create a path for each cyclone
  var line = L.polyline([[start_lat,start_long],[stop_lat, stop_long]], polyline_options)
  lineArray.push(line);
  markers.addLayer(line);
  }
  // add paths to map
  map.addLayer(markers);
}

//delete cyclone paths
var deleteLines = function() {
    for(i=0;i<lineArray.length;i++) {
    markers.removeLayer(lineArray[i])
  }
}

//Function for 5-Scale Cyclones
var plotData = function(data) {
// Construct the lat and long for each tornado.
  var deleteMarkers = function() {
    for(i=0;i<markerArray.length;i++) {
    markers.removeLayer(markerArray[i]);
    }
  }
  //call deleteMarkers to clear map on submit
  deleteMarkers();

  var total_fatalities = 0
  var total_crop_loss = 0
  var total_prop_loss = 0
  var strongest_tornado = 0

for (var i = 0; i < window.x.length; i++) {
  var start_lat = window.x[i]["location"]["start_lat"]
  var start_long = window.x[i]["location"]["start_long"]
  var stop_lat = window.x[i]["location"]["stop_lat"]
  if (stop_lat == 0) {
    stop_lat = start_lat;
  }
  var stop_long = window.x[i]["location"]["stop_long"]
  if (stop_long == 0) {
    stop_long = start_long;
  }
  var id = window.x[i]["id"]
  var scale = window.x[i]["cyclone_strength"]["f_scale"]
  var month = window.x[i]["date"]["month"]
  var day = window.x[i]["date"]["day"]
  var year = window.x[i]["date"]["year"]
  total_fatalities += window.x[i]["loss"]["fatalities"]
  total_crop_loss += window.x[i]["loss"]["crop_loss"]
  total_prop_loss += window.x[i]["loss"]["property_loss"]
  if (strongest_tornado < window.x[i]["cyclone_strength"]["f_scale"]) {
    strongest_tornado += window.x[i]["cyclone_strength"]["f_scale"]
  };

  // add icon to map for this tornado
  var marker = L.marker(new L.latLng(start_lat, start_long), {
      icon: myIcon}
  );


  //bind popup to show info and redirect link to individual cyclone dashboard
  marker.bindPopup('<p>Category ' + scale + ' Tornado </br>on ' + month + '/' + day + '/' + year + '</p><a href="/cyclones/'+id+'">Chase this Storm!</a>');
  //add marker to markers array
  markerArray.push(marker)
  //add marker to markers layer
  markers.addLayer(marker);

}//closes for loop

$("#fatalities").text(total_fatalities);
$("#proploss").text(Math.ceil(total_prop_loss));
$("#croploss").text(Math.ceil(total_crop_loss));
$("#highestfscale").text(strongest_tornado);
//add markers to map for clustering effect
map.addLayer(markers);

}//closes plotwindow.x function


//get zoom level on each click
map.on('zoomend', function(e) {
  //if map is zoomed in past 6, show cyclone paths
  if (map.getZoom() > 6) {
    plotPaths();
  }
  //if map is zoomed out past 6, remove cyclone paths
  if (map.getZoom() <= 6) {
    deleteLines();
  }
});


//5-Scale Cyclones
$("#index_tab a:first").on("click", function (e) {
  e.preventDefault()
  map.setZoom(4);
  var url = "../api/v1/search/strongest/only_map_data:true"
  $.get(url, function(data) {window.x = data; plotData(data)}, "json");
  $(this).tab('show');
})
//Costliest Cyclones
$("#index_tab li:eq(1) a").on("click", function (e) {
  e.preventDefault()
  map.setZoom(4);
  var url = "../api/v1/search/costliest/only_map_data:true"
  $.get(url, function(data) {window.x = data; plotData(data)}, "json");
  $(this).tab('show');
})
//Deadliest Cyclones
$("#index_tab li:eq(2) a").on("click", function (e) {
  e.preventDefault()
  map.setZoom(4);
  var url = "../api/v1/search/deadliest/only_map_data:true"
  $.get(url, function(data) {window.x = data; plotData(data)}, "json");
  $(this).tab('show')
})
//Past Year
$("#index_tab a:last").on("click", function (e) {
  e.preventDefault()
  map.setZoom(4);
  var url = "../api/v1/search/strongest/year:2013,only_map_data:true"
  $.get(url, function(data) {window.x = data; plotData(data)}, "json");
  $(this).tab('show')
})





