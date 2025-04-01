<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Username form</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
    grid-gap: 10px; /* Adjust the gap between items here */
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
</style>
</head>
<body>
  <ul class="navbar">
    <li style="padding-left:100px"><a class="active" href="/">Home</a></li>
    <li><a href="/notCompletedGames">Not completed games</a></li>
    <li><a href="/users">Users</a></li>
  </ul>
  <div class="grid-container">
     <div class="grid-item">
         <form action="endingResult" method="get">
	      <input required type="text" id="username" name="username">
	      <input value="${gameId}" type="hidden" id="gameId" name="gameId">
	      <button id="submitButton">Enter your username</button>
	    </form>
    </div>


  </div>
</body>
</html>