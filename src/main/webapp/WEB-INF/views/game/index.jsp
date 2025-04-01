<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hangman</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

</head>
<body>

  <ul class="navbar">
    <li style="padding-left:100px"><a class="active" href="/">Home</a></li>
    <li><a href="/notCompletedGames">Not completed games</a></li>
    <li><a href="/users">Users</a></li>
  </ul>
  
  <div class="grid-container">
    <div class="grid-item canvas-item">
      <h1 id="chart-title">Top 10 players of all time</h1>
    </div>
    <div class="grid-item canvas-item">
      <canvas id="myChart" style="width:100%;max-width:800px"></canvas>
      <div class="tab">
        <button class="tablinks" onclick="updateChart(this)">Top 10 players of all time</button>
        <button class="tablinks" onclick="updateChart(this)">Top 10 players of the month</button>
      </div>
    </div>
    <div class="grid-item"></div>
    <div class="grid-item">
      <form action="new" method="get">
        <button>Start single game</button>
      </form>
    </div>
    <div class="grid-item"></div>
  </div>
</body>
<style>
body {
  display: grid;
  place-items: center;
  font-family: 'Varela Round', sans-serif;
  height: 100vh;
  margin: 0; /* Remove default body margin */
}

.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  margin: 0;
  padding: 0;
  list-style-type: none;
  background-color: #333;
  overflow: hidden;
}

.navbar li {
  float: left;
}

.navbar li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size:30px;
}

.navbar li a:hover {
  background-color: #111;
}

.grid-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr); /* Adjust the number of columns here */
  grid-gap: 10px; /* Adjust the gap between items here */
  margin-top: 40px; /* Add margin-top to move the container below the navbar */
}

.grid-item {
  background-color: #f2f2f2;
  padding: 20px;
  text-align: center;
}

form {
  display: block;
  margin-bottom: 10px;
}

.canvas-item {
  grid-column: 1 / span 3; /* Make the canvas item span across 3 columns */
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative; /* Add position relative to the canvas item */
}

.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  position: absolute;
  top: -15px;
  left: 0px; /* Adjust the right position of the button */
  z-index: 1; /* Ensure the button is on top of the canvas */
}

.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

</style>
<script>
const canvas = document.getElementById('myChart');
var xValues = ${userAllTime};
var yValues = ${winAllTime};
var barColors = ["red", "blue", "green", "yellow", "orange", "purple", "pink", "brown", "gray", "black", "white"];

let myChart =new Chart("myChart", {
  type: "bar",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
	    legend: {display: false},
	    title: {
	      display: true,
	      
	    },
	    scales: {
	        yAxes: [{
	          ticks: {
	            beginAtZero: true,
	            callback: function(value) {if (value % 1 === 0) {return value;}}
	          }
	        }]
	      }
	  }
  
});
canvas.onclick = (evt) => {
	  const res = myChart.getElementAtEvent(evt);
	  if (res.length === 0) {
	    return;
	  }
	  let domain =location.protocol + '//' + location.host;
	  window.location.href =domain+"/userProfile?username="+myChart.data.labels[res[0]._index]
	};
	
function updateChart(button) {
    // Generate new xValues and yValues (replace with your logic)
    const btn_text=button.innerText;
    document.getElementById("chart-title").innerText=btn_text
    
    if(btn_text==="Top 10 players of the month"){
    	 xValues = ${userForMonth};
    	 yValues = ${winsForMonth};
    }
    else{
    	 xValues = ${userAllTime};
    	 yValues = ${winAllTime};
    }

    // Update the chart data
    myChart.data.labels = xValues;
    myChart.data.datasets[0].data = yValues;

    // Update the chart
    myChart.update();
  }
</script>
</html>
