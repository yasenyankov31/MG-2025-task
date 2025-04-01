<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Users table</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head>
<body>
	  <ul class="navbar">
	    <li style="padding-left:100px"><a class="active" href="/">Home</a></li>
	    <li><a href="/notCompletedGames">Not completed games</a></li>
	    <li><a href="/users">Users</a></li>
	  </ul>
    <div class="container" style="padding-top:100px;">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
     </div>
     <div class="col-sm-6">
      <a href="#deleteEmployeeModal" onclick="getSelectedCheckboxIds()" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>     
      <a href="#addEmployeeModal" id="openAddModal"  class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add new player</span></a> 
     </div>
           </div>
            </div>
			<table class="table table-striped table-hover">
			  <thead>
			    <tr>
			      <th>
			        <span class="custom-checkbox">
			          <input type="checkbox" id="selectAll">
			          <label for="selectAll"></label>
			        </span>
			      </th>
			      <th>Username</th>
			      <th>Password</th>
			      <th>Age</th>
			      <th>Birth Date</th>
			      <th>Actions</th>
			      <th>View profile</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach var="data" items="${usersData.content }">
			    <tr>
			      <td>
			        <span class="custom-checkbox">
			          <input type="checkbox" id="checkbox${data.getId() }" name="options[]" value="${data.getId()}">
			          <label for="checkbox${data.getId() }"></label>
			        </span>
			      </td>
			      <td id="username">${data.getUsername()}</td>
			      <td id="password">${data.getPassword()}</td>
			      <td id="age">${data.getAge()}</td>
			      <td id="birthDate">${data.getBirthDate()}</td>
			      <td>
			        <a href="#editEmployeeModal " class="edit" data-toggle="modal">
			          <i class="material-icons" onclick="selectEditUserId('${data.getId()}','${data.getUsername()}','${data.getPassword()}','${data.getAge()}','${data.getBirthDate()}')" data-toggle="tooltip" title="Edit">&#xE254;</i>
			        </a>
			        <a href="#deleteEmployeeModal" class="delete" data-toggle="modal">
			          <i class="material-icons" data-toggle="tooltip" onclick="selectDeleteUserId(${data.getId()})" title="Delete">&#xE872;</i>
			        </a>
			      </td>
			    	   <td>
  			      	<a href="/userProfile?username=${data.getUsername()}" class="view" >
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
						  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
						</svg>
			        </a>
			      </td>
			    </tr>
			   </c:forEach>
			  </tbody>
			</table>
			
			<div class="clearfix">
			    <div class="hint-text">Showing <b>${usersData.content.size()}</b> out of <b id="totalUsers">${usersData.getTotalElements()}</b> entries</div>
			    <ul class="pagination" id="pagination">
			        <li class="page-item ${pageNum < 1 ? 'disabled' : ''}">
			            <a href="/users?pageNum=${pageNum-1<0?0:pageNum-1}">Previous</a>
			        </li>
			        <c:forEach var="data" begin="1" end="${usersData.totalPages}" step="1">
			            <li class="page-item ${data == usersData.number + 1 ? 'active' : ''}">
			                <a href="/users?pageNum=${data-1}" class="page-link">${data}</a>
			            </li>
			        </c:forEach>
			        <li class="page-item ${pageNum == usersData.totalPages-1 ? 'disabled' : ''}">
			            <a href="/users?pageNum=${pageNum+1>usersData.totalPages-1?usersData.totalPages-1:pageNum+1}">Next</a>
			        </li>
			    </ul>
			</div>

        </div>
    </div>
 <!-- Edit Modal HTML -->
 <div id="addEmployeeModal" class="modal fade">
  <div class="modal-dialog">
   <div class="modal-content">
    <form action="updateUser" method="post">
     <div class="modal-header">      
      <h4 class="modal-title">Add new player</h4>
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
     </div>
     <div class="modal-body">     
      <div class="form-group">
       <label>Username</label>
        <input type="hidden" id="pageNum" name="pageNum" value="${pageNum}" required>
       <input name="username" id="addUsernameInput"  type="text" class="form-control" value="" required>
      </div>
      <div class="form-group">
       <label>Password</label>
       <input  name="password" id="addPasswordInput" type="text" class="form-control" value="" required>
      </div>
      <div class="form-group">
       <label>Age</label>
       <input   name="age" id="addAgeInput" type="number" class="form-control" value="" required>
      </div>
      <div class="form-group">
       <label>Birth Date</label>
       <input   name="birthDate" id="addDateInput" type="date" class="form-control" value="" required>
      </div>     
     </div>
     <div class="modal-footer">
      <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
      <input type="submit" id="addUserBtn" class="btn btn-success" value="Add">
     </div>
    </form>
   </div>
  </div>
 </div>
 <!-- Edit Modal HTML -->
 <div id="editEmployeeModal" class="modal fade">
  <div class="modal-dialog">
   <div class="modal-content">
    <form action="updateUser" method="post">
     <div class="modal-header">      
      <h4 class="modal-title">Edit player</h4>
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
     </div>
     <div class="modal-body">     
      <div class="form-group">
       <label>Username</label>
       <input type="hidden" id="pageNum" name="pageNum" value="${pageNum}" required>
       <input name="username" id="updateUsernameInput" type="text" class="form-control" required>
      </div>
      <div class="form-group">
       <label>Password</label>
       <input name="password" id="updatePasswordInput" type="text" class="form-control" required>
      </div>
      <div class="form-group">
       <label>Age</label>
       <input name="age" id="updateAgeInput" type="number" class="form-control" required>
      </div>
      <div class="form-group">
       <label>Birth Date</label>
       <input name="birthDate" id="updateDateInput" type="date" class="form-control" required>
      </div>     
     </div>
     <div class="modal-footer">
      <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
      <input type="hidden" name="id" id="userEditId" value="">
      <input type="submit" id="updateUserBtn" class="btn btn-info" value="Save">
     </div>
    </form>
   </div>
  </div>
 </div>
 <!-- Delete Modal HTML -->
 <div id="deleteEmployeeModal" class="modal fade">
  <div class="modal-dialog">
   <div class="modal-content">
    <div>
     <div class="modal-header">      
      <h4 class="modal-title">Delete Employee</h4>
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
     </div>
     <div class="modal-body">     
      <p>Are you sure you want to delete these Records?</p>
      <p class="text-warning"><small>This action cannot be undone.</small></p>
     </div>
     <div class="modal-footer">
      <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
      <input type="hidden" name="userDeleteId" id="userDeleteId" value="">
      <input type="submit" id="deleteConfirm" onclick="deleteUsers()" class="btn btn-danger" value="Delete">
     </div>
    </div>
   </div>
  </div>
 </div>
</body>
<style type="text/css">
    body {
        color: #566787;
		 background: #f5f5f5;
		 font-family: 'Varela Round', sans-serif;
		 font-size: 13px;
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
 .table-wrapper {
        background: #fff;
        padding: 100px 25px;
        margin: 30px 0;
  border-radius:1px;
        box-shadow: 0 1px 1px rgba(0, 0, 0, 0.247);
    }
 .table-title {        
  padding-bottom: 15px;
  color: #fff;
  padding: 16px 30px;
  margin: -20px -25px 10px;
  border-radius: 1px 1px 0 0;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.247);
    }
    .table-title h2 {
  margin: 5px 0 0;
  font-size: 24px;
 }
 .table-title .btn-group {
  float: right;
 }
 .table-title .btn {
  color: #fff;
  float: right;
  font-size: 13px;
  border: none;
  min-width: 50px;
  border-radius: 1px;
  border: none;
  outline: none !important;
  margin-left: 10px;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.247);
 }
 .table-title .btn i {
  float: left;
  font-size: 21px;
  margin-right: 5px;
 }
 .table-title .btn span {
  float: left;
  margin-top: 2px;
 }
    table.table tr th, table.table tr td {
        border-color: #e9e9e9;
  padding: 12px 15px;
  vertical-align: middle;
    }
 table.table tr th:first-child {
  width: 60px;
 }
 table.table tr th:last-child {
  width: 100px;
 }
    table.table-striped tbody tr:nth-of-type(odd) {
     background-color: #fcfcfc;
 }
 table.table-striped.table-hover tbody tr:hover {
  background: #f5f5f5;
 }
    table.table th i {
        font-size: 13px;
        margin: 0 5px;
        cursor: pointer;
    } 
    table.table td:last-child i {
  opacity: 0.9;
  font-size: 22px;
        margin: 0 5px;
    }
 table.table td a {
  font-weight: bold;
  color: #566787;
  display: inline-block;
  text-decoration: none;
  outline: none !important;
 }
 table.table td a:hover {
  color: #2196F3;
 }
 table.table td a.edit {
        color: #FFC107;
    }
    table.table td a.delete {
        color: #F44336;
    }
    table.table td i {
        font-size: 19px;
    }
 table.table .avatar {
  border-radius: 1px;
  vertical-align: middle;
  margin-right: 10px;
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
 /* Custom checkbox */
 .custom-checkbox {
  position: relative;
 }
 .custom-checkbox input[type="checkbox"] {    
  opacity: 0;
  position: absolute;
  margin: 5px 0 0 3px;
  z-index: 9;
 }
 .custom-checkbox label:before{
  width: 18px;
  height: 18px;
 }
 .custom-checkbox label:before {
  content: '';
  margin-right: 10px;
  display: inline-block;
  vertical-align: text-top;
  background: white;
  border: 1px solid #bbb;
  border-radius: 1px;
  box-sizing: border-box;
  z-index: 2;
 }
 .custom-checkbox input[type="checkbox"]:checked + label:after {
  content: '';
  position: absolute;
  left: 6px;
  top: 3px;
  width: 6px;
  height: 11px;
  border: solid #000;
  border-width: 0 3px 3px 0;
  transform: inherit;
  z-index: 3;
  transform: rotateZ(45deg);
 }
 .custom-checkbox input[type="checkbox"]:checked + label:before {
  border-color: #03A9F4;
  background: #03A9F4;
 }
 .custom-checkbox input[type="checkbox"]:checked + label:after {
  border-color: #fff;
 }
 .custom-checkbox input[type="checkbox"]:disabled + label:before {
  color: #b8b8b8;
  cursor: auto;
  box-shadow: none;
  background: #ddd;
 }
 /* Modal styles */
 .modal .modal-dialog {
  max-width: 400px;
 }
 .modal .modal-header, .modal .modal-body, .modal .modal-footer {
  padding: 20px 30px;
 }
 .modal .modal-content {
  border-radius: 1px;
 }
 .modal .modal-footer {
  background: #ecf0f1;
  border-radius: 0 0 1px 1px;
 }
    .modal .modal-title {
        display: inline-block;
    }
 .modal .form-control {
  border-radius: 1px;
  box-shadow: none;
  border-color: #dddddd;
 }
 .modal textarea.form-control {
  resize: vertical;
 }
 .modal .btn {
  border-radius: 1px;
  min-width: 100px;
 } 
 .modal form label {
  font-weight: normal;
 } 
</style>
<script type="text/javascript">
	let deleteIds=[]
	function selectDeleteUserId(userId){
		var checkboxes = document.querySelectorAll('input[type="checkbox"]');
		checkboxes.forEach(function(checkbox) {
		  checkbox.checked = false;
		});
		deleteIds=[]
		deleteIds.push(userId)
	}
	function selectEditUserId(userId,username,password,age,birthDate){
		document.getElementById("userEditId").value=userId;
		
		document.getElementById("updateUsernameInput").value=username;
		document.getElementById("updatePasswordInput").value=password;
		document.getElementById("updateAgeInput").value=age;
		document.getElementById("updateDateInput").value=birthDate;
	}
	function getSelectedCheckboxIds() {
		  deleteIds=[]
		  var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		   Array.from(checkboxes).map(function(checkbox) {
		   if(checkbox.value!=="on"){
			   deleteIds.push(checkbox.value);
		   }
		  });
			  console.log("Selected Checkbox IDs:", deleteIds);
	}
	function deleteUsers(){
		var formData = new FormData();
		deleteIds.forEach(function(id) {
		  formData.append('ids', id);
		});
		formData.append('pageNum',${pageNum});

		// Make an AJAX POST request
		var xhr = new XMLHttpRequest();
		var url = '/deleteUsers'; // Replace with the actual URL of your controller method

		xhr.open('POST', url, true);

		xhr.onreadystatechange = function () {
		  if (xhr.readyState === 4 && xhr.status === 200) {
			  const nameAndPort=location.protocol + '//' + location.host
			  window.location.href = nameAndPort+"/users"
		  }
		};

		xhr.send(formData);
	}

	$(document).ready(function()
	{
	 // Activate tooltip
	 $('[data-toggle="tooltip"]').tooltip();
	 
	 // Select/Deselect checkboxes
	 var checkbox = $('table tbody input[type="checkbox"]');
	 $("#selectAll").click(function()
	 {
	  if(this.checked){
	   checkbox.each(function()
	   {
	    this.checked = true;                        
	   });
	  }
	  else
	  {
	   checkbox.each(function()
	   {
	    this.checked = false;                        
	   });
	  } 
	 });
	 checkbox.click(function()
	 {
	  if(!this.checked)
	  {
	   $("#selectAll").prop("checked", false);
	  }
	 });
	});
</script>
</html>     