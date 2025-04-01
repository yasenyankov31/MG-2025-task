<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <title>Player ${username} statistics</title>

</head>
<body>
 <ul class="navbar">
   <li style="padding-left:100px"><a class="active" href="/">Home</a></li>
   <li><a href="/notCompletedGames">Not completed games</a></li>
   <li><a href="/users">Users</a></li>
 </ul>

<div class="container" style="padding-top: 100px;">
	<h1>Player ${username} statistics</h1>
    <div class="grid">
        <div style="margin-top:50px">
            <!-- Content for the first column of the grid -->
            <h2>Player progression</h2>
            <canvas id="lineChart" style="width:100%;max-width:600px;max-height:800px"></canvas>
        </div>
        <div  style="padding-left: 100px;padding-bottom: 20px;">
            <!-- Content for the second column of the grid -->
            <h2>Player win/lose ration</h2>
            <canvas id="pieChart" style="width:100%;max-width:300px"></canvas>
        </div>
    </div>
	<h1>All played games</h1>
    <table>
        <thead>
        <tr>
       		<th>Status of game</th>
            <th>Generated word</th>
            <th>Letters used</th>
            <th>Attempts used</th>
            <th>Game creation date </th>
        </tr>
        </thead>
        <tbody>
           <c:forEach var="data" items="${userRankDatas.content}">
                <tr>
                	 <td>${data.getGameStatus()}</td>
			         <td>${data.getWord()}</td>
			         <td>${data.getLettersUsed()}</td>
			         <td>${data.getAttemptsLeft()}</td>
			         <td>${data.getStartDate()}</td>
			     </tr>
            </c:forEach>

        </tbody>
    </table>
		<div class="clearfix">
		  <div class="hint-text">Showing <b>${userRankDatas.content.size()}</b> out of <b>${userRankDatas.getTotalElements()}</b> entries</div>
		  <ul class="pagination">
		      <li class="page-item ${pageNum < 1 ? 'disabled' : ''}">
		          <a href="/userProfile?username=${username}&pageNum=${pageNum-1<0?0:pageNum-1}">Previous</a>
		      </li>
		      <c:forEach var="data" begin="1" end="${userRankDatas.totalPages}" step="1">
		          <li class="page-item ${data == userRankDatas.number + 1 ? 'active' : ''}">
		              <a href="/userProfile?username=${username}&pageNum=${data-1}" class="page-link">${data}</a>
		          </li>
		      </c:forEach>
		      <li class="page-item ${pageNum == userRankDatas.totalPages-1 ? 'disabled' : ''}">
		          <a href="/userProfile?username=${username}&pageNum=${pageNum+1>userRankDatas.totalPages-1?userRankDatas.totalPages-1:pageNum+1}">Next</a>
		        </li>
		    </ul>
		</div>
</div>
</body>
  <style>
  body{
  font-family: 'Varela Round', sans-serif;
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
      .container {
          max-width: 800px;
          margin: 0 auto;
      }

      .grid {
          display: grid;
          grid-template-columns: 1fr 1fr;
          grid-gap: 10px;
      }

      table {
          width: 100%;
          border-collapse: collapse;
      }

      th, td {
          padding: 8px;
          border: 1px solid #ddd;
      }

      th {
          background-color: #f2f2f2;
      }
       .pagination {
        float: right;
        margin: 0 0 5px;
    }
    .pagination li a {
        border: none;
        font-size: 13px;
        min-width: 30px;
        min-height: 30px;
        color: #999;
        margin: 0 2px;
        line-height: 30px;
        border-radius: 1px !important;
        text-align: center;
        padding: 0 6px;
    }
    .pagination li a:hover {
        color: #666;
    } 
    .pagination li.active a, .pagination li.active a.page-link {
        background: #03A9F4;
    }
    .pagination li.active a:hover {        
        background: #0397d6;
    }
 .pagination li.disabled i {
        color: #ccc;
    }
    .pagination li i {
        font-size: 16px;
        padding-top: 6px
    }
    .hint-text {
        float: left;
        margin-top: 10px;
        font-size: 13px;
    }  
  </style>
<script>
function generateAscendingArray(highestNumber) {
	  var result = [];
	  for (var i = 1; i <= highestNumber; i++) {
	    result.push(i);
	  }
	  return result;
	}
const xValues = generateAscendingArray(${winCount}+${lossCount})

let lineChart=new Chart("lineChart", {
  type: "line",
  data: {
    labels: xValues,
    datasets: [ { 
      data: ${statusValues},
      borderColor: "blue",
      fill: false
    }]
  },
  options: {
	    legend: {display: false},
	    title: {
	      display: false,
	      
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
var gameStat = ["Wins", "Losses"];
var statValues = [${winCount},${lossCount}];
var barColors = [
	"#1e7145",
  "#b91d47"
];

let pieChart=new Chart("pieChart", {
  type: "pie",
  data: {
    labels: gameStat,
    datasets: [{
      backgroundColor: barColors,
      data: statValues
    }]
  }
});



</script>
</html>
