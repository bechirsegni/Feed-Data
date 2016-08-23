const CHART = document.getElementById('lineChart');

var keys = [];
var values = [];

$.getJSON("vox.json", function(json) {
  $.each(json, function(k, v) {
    keys.push(k);
    values.push(v);
  });

var lineChart = new Chart(CHART, {
    type: 'bar',
    data: data = {
        labels: keys,
        datasets: [
            {
                label: "Words frequency in Rss Feed",
                backgroundColor: "#e74c3c",
                borderColor: "#e74c3c",
                pointBackgroundColor: "rgba(179,181,198,1)",
                pointBorderColor: "#fff",
                pointHoverBackgroundColor: "#fff",
                pointHoverBorderColor: "rgba(179,181,198,1)",
                data: values
            }

        ]
    }
});
});
