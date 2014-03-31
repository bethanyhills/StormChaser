//create guages for individual storms

google.load('visualization', '1', {packages:['gauge']});
google.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Label', 'Value'],
    ['Pressure', 80],
    ['Temp', 55],
    ['Wind Speed', 68]
  ]);

  var options = {
    width: 400, height: 120,
    redFrom: 90, redTo: 100,
    yellowFrom:75, yellowTo: 90,
    minorTicks: 5
  };

  var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
  chart.draw(data, options);
}
    