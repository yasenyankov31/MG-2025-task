<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lobby</title>
</head>
<body>
	<p class="text">Waiting for player 2</p>
	<div style="display: flex; justify-content: center;">
	  <button onclick="copyGameId()">Copy game id</button>
	</div>
	  <form class="text" action="/" method="get">
	    <button>Back to index</button>
	  </form>
	
</body>

<script>
	setInterval(checkIfGameStarted, 1000);

	function checkIfGameStarted(){
	  const nameAndPort=location.protocol + '//' + location.host
	  const url = nameAndPort+'/checkIfGameStarted?gameId=${gameId}';
	  fetch(url)
	    .then(function(response) {
	      if (response.ok) {
	        return response.text();
	      } else {
	        throw new Error('Error: ' + response.status);
	      }
	    })
	    .then(function(data) {
	      // Handle the API response data
	      if(data==="null"){
	    	  console.log("wait")
	      }
	      else{
	    	  window.location.href = nameAndPort+'/startMasterGame?gameId=${gameId}';
	      }
	    })
	    .catch(function(error) {
	      // Handle error
	      console.error('Error making the API call:', error);
	    });
	}
  function copyGameId() {
	  navigator.clipboard.writeText("${gameId}");

	}
</script>
<style>
	.text{
		text-align:center;
		font-size: 400%;
	}
</style>
</html>