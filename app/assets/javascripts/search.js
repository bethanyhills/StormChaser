
$(document).ready(function() {
	$(".submit").on("click", function (e) {
		e.preventDefault();
		var city = $("#citysearch").val();
		var state = $("#statesearch").val();
		var url = "../api/v1/search/radius_search,city:"+city + ",state:" + state + ",radius:25";
		$.get(url, function(data) {window.x = data; plotData(data)}, "json");
	})
})

//create map and set bounds
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l', {
  minZoom: 4,
  maxBounds: [[24.396308,-124.848974],[49.384358, -66.885444]]})

map.scrollWheelZoom.disable();
// map.legendControl.addLegend(document.getElementById('legend-content2').innerHTML);

//array to hold markers, resets to empty with each submit
var markerArray = [];
var lineArray = [];
//create cluster group data
var markers = new L.MarkerClusterGroup({disableClusteringAtZoom: 10});
//create tornado icon
var myIcon = L.icon({
  iconUrl: 'tornado-small.png',
  "iconAnchor": [12, 24]
});

//function to draw cyclone paths on map
var plotPaths = function(data) {
  //iterate through window.x for path info
  for (var i = 0; i < window.x.length; i++) {
  var start_lat = window.x[i]["location"]["startLat"]
  var start_long = window.x[i]["location"]["startLong"]
  var stop_lat = window.x[i]["location"]["stopLat"]
  if (stop_lat == 0) {
    stop_lat = start_lat;
  }
  var stop_long = window.x[i]["location"]["stopLong"]
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
  markers.removeLayer(lineArray[i]);
  }
}


//On submit, iterate through returned search data and plot on map
var plotData = function(data) {
// removes markers from array
  var deleteMarkers = function() {
    for(i=0;i<markerArray.length;i++) {
    markers.removeLayer(markerArray[i]);
    }
    markers.clearLayers();
  }
  //call deleteMarkers to clear map on submit
  deleteMarkers();

  // Construct the lat and long for each tornado.
  for (var i = 0; i < data.length; i++) {
    var start_lat = data[i]["location"]["startLat"]
    var start_long = data[i]["location"]["startLong"]
    var id = data[i]["id"]
    var scale = data[i]["cycloneStrength"]["fScale"]
    var month = data[i]["date"]["month"]
    var day = data[i]["date"]["day"]
    var year = data[i]["date"]["year"]

    // add icon to map for this tornado
    var marker = L.marker(new L.latLng(start_lat, start_long), {
      icon: myIcon,
      cyconeid: window.x[i]["id"],
      fatalities: window.x[i]["loss"]["fatalities"],
      crop_loss: window.x[i]["loss"]["cropLoss"],
      f_scale: window.x[i]["cycloneStrength"]["fScale"],
      prop_loss: window.x[i]["loss"]["propertyLoss"]
    });

    //bind popup to show info and redirect link to individual cyclone dashboard
    marker.bindPopup('<p>Category ' + scale + ' Tornado </br>on ' + month + '/' + day + '/' + year + '</p><a href="/cyclones/'+id+'">Chase this Storm!</a>');
    //add marker to holding array
    markerArray.push(marker)
    //add marker to markers layer
    markers.addLayer(marker);

  }//close for loop

  //add markers to map for clustering effect
  map.addLayer(markers);
  map.fitBounds(markers.getBounds())
}; //close plotData function

//get zoom level on each click
map.on('zoomend', function(e) {
  //if map is zoomed in past 6, show cyclone paths
  if (map.getZoom() > 9) {
    plotPaths();
  }
  //if map is zoomed out past 6, remove cyclone paths
  if (map.getZoom() <= 9) {
    deleteLines();
  }
});

map.on('move', function() {
  // construct an empty list to fill with onscreen markers
  var inBounds = [],
  // get the map bounds - the top-left and bottom-right locations
    bounds = map.getBounds();
  //set counters
  var total_fatalities = 0
  var total_crop_loss = 0
  var total_prop_loss = 0
  var strongest_tornado = 0

  // for each marker, check if lat/long is currently visible within bounds of map
  if (markerArray.length>0) {
   for (var i = 0; i < markerArray.length; i++) {
    //if marker is visible, push to inBounds array
      if (bounds.contains(markerArray[i].getLatLng())) {
        inBounds.push(markerArray[i]);
      }
    }
  }
  //iterate through inBounds to pull and aggregate data for markers in view
  for (var i = 0; i < inBounds.length; i++) {
    total_fatalities += inBounds[i]["options"]["fatalities"]
    total_crop_loss += inBounds[i]["options"]["crop_loss"]
    total_prop_loss += inBounds[i]["options"]["prop_loss"]
    if (strongest_tornado < inBounds[i]["options"]["f_scale"]) {
      strongest_tornado = inBounds[i]["options"]["f_scale"]
    }
  };
  //on each zoom, update legend based on data for cyclones in current view
  $("#fatalities").text(total_fatalities);
  $("#proploss").text(Math.ceil(total_prop_loss));
  $("#croploss").text(Math.ceil(total_crop_loss));
  $("#highestfscale").text(strongest_tornado);
}); //close map function



