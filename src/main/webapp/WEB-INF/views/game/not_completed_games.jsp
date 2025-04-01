<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Not finished games</title>
</head>

<body>
  <ul class="navbar">
    <li style="padding-left:100px"><a class="active" href="/">Home</a></li>
    <li><a href="/notCompletedGames">Not completed games</a></li>
    <li><a href="/users">Users</a></li>
  </ul>
  <div class="container">
  	<h1 style="padding-bottom:50px">All not finished games</h1>
    <table>
        <thead>
        <tr>
            <th>Attempts left</th>
            <th>Word progress</th>
        </tr>
        </thead>
		<tbody>
		  <c:forEach var="game" items="${unfinishedGames.content}">
		    <tr>
		      <td>${game.getAttemptsLeft()}</td>
		      <td>${game.getGuessedWord()}</td>
		      <td class="button-container">
		        <form action="/getGame" method="get">
		          <input type="hidden" value="1" name="letter">
		          <input type="hidden" value="${game.getId()}" name="gameId">
		          <button>Continue</button>
		        </form>
		      </td>
		    </tr>
		  </c:forEach>
		</tbody>
    </table>
    <div class="clearfix">
	    <div class="hint-text">Showing <b>${unfinishedGames.content.size()}</b> out of <b>${unfinishedGames.getTotalElements()}</b> entries</div>
	    <ul class="pagination">
	        <li class="page-item ${pageNum < 1 ? 'disabled' : ''}">
	            <a href="/notCompletedGames?pageNum=${pageNum-1<0?0:pageNum-1}">Previous</a>
	        </li>
	        <c:forEach var="data" begin="1" end="${unfinishedGames.totalPages}" step="1">
	            <li class="page-item ${data == unfinishedGames.number + 1 ? 'active' : ''}">
	                <a href="/notCompletedGames?pageNum=${data-1}" class="page-link">${data}</a>
	            </li>
	        </c:forEach>
	        <li class="page-item ${pageNum == unfinishedGames.totalPages-1 ? 'disabled' : ''}">
	            <a href="/notCompletedGames?pageNum=${pageNum+1>unfinishedGames.totalPages-1?unfinishedGames.totalPages-1:pageNum+1}">Next</a>
	        </li>
	    </ul>
	</div>
    
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
	.container {
	  max-width: 800px;
	  margin: 0 auto;
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
	  font-size: 30px;
	}
	.navbar li a:hover {
	  background-color: #111;
	}
	table {
	  width: 100%;
	  border-collapse: collapse;
	}
	th,
	td {
	  padding: 8px;
	  border: 1px solid #ddd;
	  text-align: center;
	}
	th {
	  background-color: #f2f2f2;
	}
	.button-container {
	  display: flex;
	  justify-content: center;
	}
	.button-container button {
	  margin: 5px;
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
</html>