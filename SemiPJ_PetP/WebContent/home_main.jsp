<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 모바일 환경 지원 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>-->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
	
<style type="text/css">
.leftside {
  background-image: url(resources/images/logo02.png);
  background-repeat: no-repeat;
  height: 800px; /* You must set a specified height */
  background-position: center; /* Center the image */
  background-size: auto;
  opacity: 0.2;
}
.logo {
	text-center
}
.card-img2{
	width: 100px;
}
span{
	font-size: 60px;
}
</style>
<title>PETP</title>
</head>
<body>
	<div class="container-fluid" style="width: 100%; background-color: #f5f5dc;">
		<div class="row">
			<div class="col leftside"></div>
			
			<div class="col rightside" style="background-color: #fffff9;">
				
				<div class="card-section-2" align="center" style="margin-top: 250px;">
		    		<img src="resources/images/logo01.png" class="card-img2" alt="로고 사진2" >&nbsp;&nbsp;
		      		<span><strong>PETP</strong></span>
    			</div>
    			<br><br><br>
    			
    			<div class="card" id="card-section-3" style="background-color: #fffff9; border: none; width: 350px; margin: 0 auto;">
					<button type="button" class="btn btn-secondary btn-lg" style="border: none;" 
					onclick="location.href='home_register.jsp'">Sign Up</button> <br>
					
					<button type="button" class="btn btn-secondary btn-lg" style="background-color: silver; border: none;" 
					onclick="location.href='home_login.jsp'">Sign In</button>
    			</div>
				
			</div>
		</div>
	</div>
</body>
</html>