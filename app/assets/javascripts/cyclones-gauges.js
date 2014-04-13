
id = window.location.href.split("/").pop();
var url = "../api/v1/cyclones/" + id

google.load('visualization', '1', {packages:['gauge']});
google.load("visualization", "1", {packages:["corechart"]});

// ----------
// Gauges
// ----------
var drawChart = function(cyclone) {
  // console.log(cyclone)
  var touchdown = cyclone.touchdown_weather;
  // console.log(touchdown)
  if (touchdown == null) {
    // console.log("Getting")
    $.get("/api/v1/cyclones/" + id + "/histweather", function(data) {gaugesData(data.currently)}, "json");
  } else {
    gaugesData(touchdown);
  }

  function gaugesData(touchdown) {
    // console.log(touchdown)
    var pressure = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Pressure', touchdown.pressure],
    ]);

    var temp = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Temp', touchdown.temperature],
    ]);

    var wind_speed = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Wind Speed', touchdown.windSpeed]
    ]);

    var wind_bearing = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Wind Bearing', touchdown.windBearing]
    ]);

    var pressure_options = {
      width: 270, height: 190,
      max: 1050, min: 900,
      redFrom: 1000, redTo: 1050,
      yellowFrom:975, yellowTo: 9999,
      minorTicks: 5
    };

    var temp_options = {
      width: 270, height: 190,
      max: 110, min:0,
      redFrom: 90, redTo: 110,
      yellowFrom:75, yellowTo: 89,
      minorTicks: 5
    };

    var wind_speed_options = {
      width: 270, height: 190,
      max: 70, min:0,
      redFrom: 40, redTo: 70,
      yellowFrom:20, yellowTo: 39,
      minorTicks: 5
    };

     var wind_bearing_options = {
      width: 270, height: 190,
      max: 360, min:0,
      minorTicks: 5
    };

    var chart1 = new google.visualization.Gauge(document.getElementById('chart_div1'));
    chart1.draw(pressure, pressure_options);

    var chart2 = new google.visualization.Gauge(document.getElementById('chart_div2'));
    chart2.draw(temp, temp_options);

    var chart3 = new google.visualization.Gauge(document.getElementById('chart_div3'));
    chart3.draw(wind_speed, wind_speed_options);

    var chart6 = new google.visualization.Gauge(document.getElementById('chart_div6'));
    chart6.draw(wind_bearing, wind_bearing_options);
  }
}

// ----------
// Bar Charts
// ----------
var drawBarChart = function(cyclone) {
  var data = google.visualization.arrayToDataTable([
    ['Type', 'Cyclone', 'Year', 'All'],
    ['Prop Loss', cyclone.loss.property_loss, Math.ceil(cyclone.average.year.property_loss), Math.ceil(cyclone.average.all.property_loss)],
    ['Crop Loss', cyclone.loss.crop_loss, Math.ceil(cyclone.average.year.crop_loss), Math.ceil(cyclone.average.all.crop_loss)]
  ]);


  var options = {
    title: 'Average Loss Comparison',
    hAxis: {title: 'Loss in Millions',  titleTextStyle: {color: 'black'}},
    colors: ['orange', 'gray', 'green'],
    width: 'auto',
    height: 300
  };

  var chart = new google.visualization.BarChart(document.getElementById('chart_div4'));
  chart.draw(data, options);
}


var drawPressureChart = function(cyclone) {
  var hourly_arr = cyclone.historical_weather;

  var arr = [['Hour', 'Pressure']];
  for (var i =0; i < hourly_arr.length; i++) {
       arr.push([cyclone.historical_weather[i].hour, cyclone.historical_weather[i].pressure]);
    }

  var data1 = google.visualization.arrayToDataTable(arr);

  var options_pressure = {
    title: 'Pressure over 24 Hours',
    hAxis: {title: 'Hour',  titleTextStyle: {color: 'black'}},
    width: 'auto',
    height: 300,
    legend: { position: 'none' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart_div5'));
  chart.draw(data1, options_pressure);
}


var drawTempChart = function(cyclone) {
  var temp_arr = cyclone.historical_weather;

  var arr2 = [['Hour', 'Temperature']];
  for (var i =0; i < temp_arr.length; i++) {
       arr2.push([cyclone.historical_weather[i].hour, cyclone.historical_weather[i].temperature]);
    }

  var data2 = google.visualization.arrayToDataTable(arr2);
  // console.log(data)

  var options_temp = {
    title: 'Temperature over 24 Hours',
    hAxis: {title: 'Hour',  titleTextStyle: {color: 'black'}},
    width: 'auto',
    height: 300,
    legend: { position: 'none' }
  };
  
  var chart = new google.visualization.LineChart(document.getElementById('chart_div7'));
  chart.draw(data2, options_temp);
}


var drawWindChart = function(cyclone) {
  var wind_arr = cyclone.historical_weather;

  var arr3 = [['Hour', 'Wind Speed']];
  for (var i =0; i < wind_arr.length; i++) {
       arr3.push([cyclone.historical_weather[i].hour, cyclone.historical_weather[i].windSpeed]);
    }

  var data3 = google.visualization.arrayToDataTable(arr3);
  // console.log(data)

  var options_wind = {
    title: 'Wind Speed over 24 Hours in MPH',
    hAxis: {title: 'Hour',  titleTextStyle: {color: 'black'}, maxValue:24},
    width: 'auto',
    height: 300,
    legend: { position: 'none' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart_div8'));
  chart.draw(data3, options_wind);
}


// -------------
// Click Handler
// -------------

$("#myTab a:first").on("click", function (e) {
  e.preventDefault();
  drawChart(cyclone);
  $(this).tab('show');
})

$("#myTab li:eq(1) a").on("click", function (e) {
  e.preventDefault();
  drawBarChart(cyclone);
  $(this).tab('show');
})

$("#myTab a:last").on("click", function (e) {
  e.preventDefault();
  drawPressureChart(cyclone);
  $(this).tab('show');
})

// --------------------
// Hourly Click Handler
// --------------------

$("#hourlyTab a:first").on("click", function (e) {
  e.preventDefault();
  drawPressureChart(cyclone);
  $(this).tab('show');
})

$("#hourlyTab li:eq(1) a").on("click", function (e) {
  e.preventDefault();
  drawTempChart(cyclone);
  $(this).tab('show');
})

$("#hourlyTab a:last").on("click", function (e) {
  e.preventDefault();
  drawWindChart(cyclone);
  $(this).tab('show');
})
