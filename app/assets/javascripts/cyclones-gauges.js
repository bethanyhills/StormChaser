
id = window.location.href.split("/").pop();
var url = "../api/v1/cyclones/" + id
google.load('visualization', '1', {packages:['gauge']});
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback($.get("/cyclones/" + id + "/histweather", function(data) {setTimeout(function(){drawChart(data)},500);}, "json"));


// ----------
// Gauges
// ----------
drawChart = function(histdata) {
  // console.log("ehh")
  window.x = histdata;
  console.log(histdata);
  var pressure = google.visualization.arrayToDataTable([
    ['Label', 'Value'],
    ['Pressure', histdata.currently.pressure],
  ]);
  // console.log(pressure)

  var temp = google.visualization.arrayToDataTable([
    ['Label', 'Value'],
    ['Temp', histdata.currently.temperature],
  ]);

  var wind_speed = google.visualization.arrayToDataTable([
    ['Label', 'Value'],
    ['Wind Speed', histdata.currently.windSpeed]
  ]);

  var pressure_options = {
    width: 400, height: 120,
    max: 1050, min: 900,
    redFrom: 1000, redTo: 1050,
    yellowFrom:975, yellowTo: 9999,
    minorTicks: 5
  };

  var temp_options = {
    width: 400, height: 120,
    max: 110, min:0,
    redFrom: 90, redTo: 110,
    yellowFrom:75, yellowTo: 89,
    minorTicks: 5
  };

  var wind_speed_options = {
    width: 400, height: 120,
    max: 70, min:0,
    redFrom: 40, redTo: 70,
    yellowFrom:20, yellowTo: 39,
    minorTicks: 5
  };

  var chart1 = new google.visualization.Gauge(document.getElementById('chart_div1'));
  chart1.draw(pressure, pressure_options);

  var chart2 = new google.visualization.Gauge(document.getElementById('chart_div2'));
  chart2.draw(temp, temp_options);

  var chart3 = new google.visualization.Gauge(document.getElementById('chart_div3'));
  chart3.draw(wind_speed, wind_speed_options);
}

// ----------
// Bar Charts
// ----------
drawBarChart = function(cyclone) {
    var data = google.visualization.arrayToDataTable([
      ['Item', 'Current Cyclone', 'Average Across All Cyclones'],
      ['Property Loss',  cyclone.loss.property_loss, 10],
      ['Crop Loss',  cyclone.loss.crop_loss,  50],
      ['Fatalities',  cyclone.loss.fatalities,  100],
      ['Injuries',  cyclone.loss.injuries,   25]
    ]);

    var options = {
      title: 'This Cyclone vs. Cyclone Average',
      vAxis: {title: 'Cyclone Stats',  titleTextStyle: {color: 'red'}}
    };

    var chart = new google.visualization.BarChart(document.getElementById('chart_div4'));
    chart.draw(data, options);
  }

// -------------
// Click Handler
// -------------

$("#myTab a:first").on("click", function (e) {
  e.preventDefault()
  google.load('visualization', '1', {packages:['gauge']});
  google.setOnLoadCallback($.get("/cyclones/" + id + "/histweather", function(data) {setTimeout(function(){drawChart(data)},500);}, "json"));
  $(this).tab('show')
})

$("#myTab li:eq(1) a").on("click", function (e) {
  e.preventDefault()
  drawBarChart(cyclone)
  $(this).tab('show')
})

$("#myTab a:last").on("click", function (e) {
  e.preventDefault()
  $(this).tab('show')
})
