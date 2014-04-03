// Create the map
var map = L.mapbox.map('map', 'bethanynagel.hmm5bk2l',
  {center: [38.5, -98.00], 
  zoom: 4,
  doubleClickZoom: true,
  })

//create empty array to hold markers
markers = [];
//create tornado icon
var myIcon = L.icon({
  iconUrl: 'tornado-small.png'
  });
var id = []

// Construct the lat and long for each tornado.
for (var i = 0; i < gon.cyclones.length; i++) {
  var start_lat = gon.cyclones[i]["start_lat"]
  var start_long = gon.cyclones[i]["start_long"]
  id[i] = gon.cyclones[i]["id"]
  
  //add icon to map for this tornado
  L.marker([start_lat, start_long], {icon: myIcon}).addTo(map).addEventListener('click', function(e) {
    console.log(id[i])
    //window.location.href = "/cyclones/" + this["id"];
  });

}//closes for loop


  



  