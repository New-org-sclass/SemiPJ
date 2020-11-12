<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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

.col {
	align: center;
	font-size: 60px;
	font-weight: bold;
}
.container > span {
	padding: 0;
}
</style>

<title>PETP</title>
</head>
<body>
<jsp:include page="form/header02.jsp" flush="false" />

	<main role="main" style="padding-top: 250px; padding-bottom: 250px; background-color: #fffff9; ">
		<div class="container">
		
			<span class="col" style="margin-left: 100px;">
		    	<img src="resources/images/logo01.png" style="width: 80px;">
    		</span>
    		<span class="col">
		    	PETP
		    </span>
		
			<form action="MemberServlet.do" method="post">
			<input type="hidden" name="command" value="login">
				  <div class="form-group" style="margin-top: 30px;">
				    <label for="email">Email address</label>
				    <input type="email" class="form-control" name="email" aria-describedby="emailHelp">
				  </div>
				  
				  <div class="form-group">
				    <label for="id">ID</label>
				    <input type="text" class="form-control" name="id">
				  </div>
				  
				  <div class="form-group">
				    <label for="password">Password</label>
				    <input type="password" class="form-control" name="password">
				  </div>
				  
				  <div align="center" style="margin-top:50px;">
				  	<button type="submit" class="btn btn-secondary btn-lg btn-block" style="border: none;  height: 50px;">Sign In</button>
				  </div>
			</form>

		</div>
	</main>
<jsp:include page="form/footer.jsp" flush="false" />
</body>
</html>