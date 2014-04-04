//specify map bounds

var southWest = L.latLng(24.396308, -124.848974),
    northEast = L.latLng(49.384358, -66.885444),
    bounds = L.latLngBounds(southWest, northEast);

// Create the map
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l')
  .setMaxBounds(bounds)

//create tornado icon
var myIcon = L.icon({
  iconUrl: 'tornado-small.png'
  });

//create array to hold cluster group data
var markers = new L.MarkerClusterGroup();

// Construct the lat and long for each tornado.
for (var i = 0; i < gon.cyclones.length; i++) {
  var start_lat = gon.cyclones[i]["start_lat"]
  var start_long = gon.cyclones[i]["start_long"]
  var id = gon.cyclones[i]["id"]
  var scale = gon.cyclones[i]["f_scale"]

  // add icon to map for this tornado
  var marker = L.marker(new L.latLng(start_lat, start_long), {
      icon: myIcon}
  );
  //bind popup to show info and redirect link to individual cyclone dashboard
  marker.bindPopup('<p>Category ' + scale + ' Tornado</p><a href="/cyclones/'+id+'">Chase this Storm!</a>');
  //add marker to markers array
  markers.addLayer(marker);

}//closes for loop

//add markers to map for clustering effect
map.addLayer(markers);







  



  