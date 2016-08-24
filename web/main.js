const CHART = document.getElementById('lineChart');

var keys = [];
var values = [];

$.getJSON("vice.json", function(json) {
  $.each(json, function(k, v) {
    keys.push(k);
    values.push(v);
  });

var lineChart = new Chart(CHART, {
    type: 'line',
    data: data = {
        labels: keys.slice(0,9),
        datasets: [
            {
                label: "Words frequency in Rss Feed",
                fill: false,
                lineTension: 0.1,
                backgroundColor: "rgba(75,192,192,0.4)",
                borderColor: "rgba(75,192,192,1)",
                borderCapStyle: 'butt',
                borderDash: [],
                borderDashOffset: 0.0,
                borderJoinStyle: 'miter',
                pointBorderColor: "rgba(75,192,192,1)",
                pointBackgroundColor: "#fff",
                pointBorderWidth: 1,
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(75,192,192,1)",
                pointHoverBorderColor: "rgba(220,220,220,1)",
                pointHoverBorderWidth: 2,
                pointRadius: 1,
                pointHitRadius: 10,
                data: values.slice(0,9)
            }

        ]
    }
});
});
