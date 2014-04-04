// Create the map
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l',
  {center: [38.5, -98.00], 
  zoom: 4,
})

//create tornado icon
var myIcon = L.icon({
  iconUrl: '../tornado-small.png'
});

// Construct the lat and long for this tornado.
  var start_lat = gon.cyclones["start_lat"]
  var start_long = gon.cyclones["start_long"]
  var id = gon.cyclones["id"]
  var scale = gon.cyclones["f_scale"]

  // add icon to map for this tornado, bind popup, and set url to redirect to specific storm dashboard.
L.marker([start_lat, start_long], {icon: myIcon, alt: id})
  .addTo(map)

