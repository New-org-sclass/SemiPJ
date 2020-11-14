<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
	function registForm(){
		location.href="Member.do?command=regist";
	}
</script>


<style type="text/css">
main > div.container {
	postion: absolute;
	width: 600px;
	top: 50%;
	left: 50%;
	background-color: #f5f5dc;
	padding: 5%;
	border-radius: 100px;
}

#span {
	font-size: 60px;
	font-weight: bold;
}
</style>

<title>PETP</title>
</head>
<body>
<jsp:include page="form/header02.jsp" flush="false" />

	<main role="main" style="padding-top: 250px; padding-bottom: 250px; background-color: #fffff9; ">
		<div class="container">
		
			<div align="center">
		    	<img src="resources/images/logo01.png" class="card-img2" style="width: 80px;">&nbsp;&nbsp;
		    	<span id="span">PETP</span>
    		</div>
		
			<form action="Member.do" method="post">
				<input type="hidden" name="command" value="login">
				  <div class="form-group">
				    <label for="exampleInputPassword1">ID</label>
				    <input type="text" class="form-control" id="exampleInputPassword1" name="id">
				  </div>
				  
				  <div class="form-group">
				    <label for="exampleInputPassword1">Password</label>
				    <input type="password" class="form-control" id="exampleInputPassword1" name="pw">
				  </div>
				  
				  <div align="center" style="margin-top:50px;">
				  	<button type="submit" class="btn btn-secondary btn-lg btn-block" style="border: none;  height: 50px;">Sign In</button>
				  </div>
				  <div align="center" style="margin-top:50px;">
				  	<button type="button" class="btn btn-secondary btn-lg btn-white" style="border: none;  height: 50px;" onclick="registForm();">Sign Up</button>
				  </div>
			</form>

		</div>
	</main>
<jsp:include page="form/footer.jsp" flush="false" />
</body>
</html>