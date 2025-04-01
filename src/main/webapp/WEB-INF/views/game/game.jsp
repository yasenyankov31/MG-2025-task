<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"%>
<%@ page import=" java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Guess the word</title>
</head>
<body>
  <ul class="navbar">
    <li style="padding-left:100px"><a class="active" href="/">Home</a></li>
    <li><a href="/notCompletedGames">Not completed games</a></li>
    <li><a href="/users">Users</a></li>
  </ul>
 <div class="container" style="padding-top:100px">
 	<input id="word_num" type="hidden" value="${wordNum}">
 		 <div class="grid-container">
	  	<div class="keyboard-container item">
 	     <div id="progress">
 			<p class="text">${result}</p>
		  </div>
		  
	  		<c:choose>
		      <c:when test="${isGameOver}">
						<c:choose>
						  <c:when test="${empty opponentId}">
						   	<button onclick="newGameButton()">Try again</button>
						  </c:when>
						</c:choose>
			      
		      
					
		      </c:when>
		      <c:otherwise>
			      	<c:if test="${empty opponentId}">
			      		<button onclick="resetButton()">Reset word</button>
						<button onclick="newGameButton()">New game</button>
						<button onclick="copyGameId()">Copy game id</button>
					</c:if>
		      </c:otherwise>
		    </c:choose>
	  		  <form action="/" method="get">
			    <button>Back to index</button>
			  </form>
			<div id="keyboard-div">
				<div class="keyboard">
				    <button id="A" onclick="handleButtonClick(event)">A</button>
				    <button id="B" onclick="handleButtonClick(event)">B</button>
				    <button id="C" onclick="handleButtonClick(event)">C</button>
				    <button id="D" onclick="handleButtonClick(event)">D</button>
				    <button id="E" onclick="handleButtonClick(event)">E</button>
				    <button id="F" onclick="handleButtonClick(event)">F</button>
				    <button id="G" onclick="handleButtonClick(event)">G</button>
				    <button id="H" onclick="handleButtonClick(event)">H</button>
				    <button id="I" onclick="handleButtonClick(event)">I</button>
				    <button id="J" onclick="handleButtonClick(event)">J</button>
				    <button id="K" onclick="handleButtonClick(event)">K</button>
				    <button id="L" onclick="handleButtonClick(event)">L</button>
				    <button id="M" onclick="handleButtonClick(event)">M</button>
				    <button id="N" onclick="handleButtonClick(event)">N</button>
				    <button id="O" onclick="handleButtonClick(event)">O</button>
				    <button id="P" onclick="handleButtonClick(event)">P</button>
				    <button id="Q" onclick="handleButtonClick(event)">Q</button>
				    <button id="R" onclick="handleButtonClick(event)">R</button>
				    <button id="S" onclick="handleButtonClick(event)">S</button>
				    <button id="T" onclick="handleButtonClick(event)">T</button>
				    <button id="U" onclick="handleButtonClick(event)">U</button>
				    <button id="V" onclick="handleButtonClick(event)">V</button>
				    <button id="W" onclick="handleButtonClick(event)">W</button>
				    <button id="X" onclick="handleButtonClick(event)">X</button>
				    <button id="Y" onclick="handleButtonClick(event)">Y</button>
				    <button id="Z" onclick="handleButtonClick(event)">Z</button>
				</div>
				
			</div>
	
		</div>	
		<c:choose>
		      <c:when test="${not empty opponentId}">
			  	<div class="keyboard-container item">
		 	     <div id="progress">
		 			<p class="text">Player 2</p>
		 			<p class="text" id="opponent-text">${opponentInfo}</p>
				  </div>	
				</div>	
		      </c:when>
		 </c:choose>

	 </div>


</div>			


	  

</body>
  <script>
  	  const isError="${result}".includes("Game not found!")||"${result}".includes("Not existing 404!")
	  const isOver=${isGameOver};
	  const isMulti="${opponentId}"
  	  if(isError){
  		const keyboardDiv = document.getElementById('keyboard-div');
  		keyboardDiv.remove();
  	  }
	  const word="${result}".split(" ")[2]+"${lettersUsed}"
	  const btns = [];

	  for (let i = 0; i < word.length; i++) {
		  if(word.charAt(i)!='*'){
			 btns.push(word.charAt(i));
		  }
	  }
  
  
  	const keyboardElements = document.querySelectorAll('.keyboard > *');
	
	for (var i = 0; i < keyboardElements.length; i++) {
		  var button = keyboardElements[i];
		  var buttonInnerText = button.innerText.toLowerCase();
		  if (btns.includes(buttonInnerText)||isOver) {
		    button.disabled=true
		  }
	  }
	if(isMulti){
		setInterval(getOpponentInfo, 1000);
	}

	function getOpponentInfo(){
	  const url = location.protocol + '//' + location.host+'/getOpponentInfo?opponentId=${opponentId}';
	  fetch(url)
	    .then(function(response) {
	      if (response.ok) {
	        return response.text();
	      } else {
	        throw new Error('Error: ' + response.status);
	      }
	    })
	    .then(function(data) {
	    	document.getElementById("opponent-text").innerText=data;
	    	if(data.includes("Game won")||data.includes("Game over")){
	    		for (var i = 0; i < keyboardElements.length; i++) {
	    			  var button = keyboardElements[i];
					if(!button.disabled){
						button.disabled=true
					}
	    			  
	    		  }
	    	}
	    })
	    .catch(function(error) {
	      // Handle error
	      console.error('Error making the API call:', error);
	    });
	}

  
  function handleButtonClick(event) {
	  var letter = event.target.innerHTML.toLowerCase();
	  window.location.href = "/guess?gameId=${gameId}&letter="+letter;
	}
  function resetButton() {
	  window.location.href = "/reset?gameId=${gameId}&letter=0";
	}
  function newGameButton() {
	  window.location.href = "/new";
	}
  function copyGameId() {
	  navigator.clipboard.writeText("${gameId}");

	}
  </script>
<style>
	<c:choose>
	  <c:when test="${empty opponentId}">
		.grid-container{
		  display: flex;
		  grid-template-columns: 1fr 1fr; /* Two columns with equal width */
		  grid-gap: 10px; /* Gap between grid items */
		}
	  </c:when>
	  <c:otherwise>
		.grid-container{
		  display: grid;
		  grid-template-columns: 1fr 1fr; /* Two columns with equal width */
		  grid-gap: 10px; /* Gap between grid items */
		}
	  </c:otherwise>
	</c:choose>
	
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
	.item {
	  background-color: #80808085;
	  padding: 10px;
	}
    .container {
       	display: grid;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .keyboard-container {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .keyboard {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-gap: 5px;
        margin: 20px;
    }
    .keyboard button {
        width: 60px;
        height: 60px;
        font-size: 20px;
    }
    .text {
        font-size: 40px;
    }
    .restart-btn {
        margin-top: 20px;
        font-size: 40px;
    }
</style>
</html>