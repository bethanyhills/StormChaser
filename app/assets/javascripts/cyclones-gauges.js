
id = window.location.href.split("/").pop();
var url = "../api/v1/cyclones/" + id
google.load('visualization', '1', {packages:['gauge']});
google.setOnLoadCallback($.get("/cyclones/" + id + "/histweather", function(data) {setTimeout(function(){drawChart(data)},500);}, "json"));




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

// $("#tab2").on("click", function (e) {
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawBarChart);
  function drawBarChart() {
    var data = google.visualization.arrayToDataTable([
      ['Item', 'Current Cyclone', 'Average Across All Cyclones'],
      ['Property Loss',  1000,      400],
      ['Crop Loss',  1170,      460],
      ['Fatalities',  660,       1120],
      ['Injuries',  1030,      540]
    ]);

    var options = {
      title: 'This Cyclone vs. Cyclone Average',
      vAxis: {title: 'Cyclone Stats',  titleTextStyle: {color: 'red'}}
    };

    var chart = new google.visualization.BarChart(document.getElementById('chart_div4'));
    chart.draw(data, options);
  }
// })
