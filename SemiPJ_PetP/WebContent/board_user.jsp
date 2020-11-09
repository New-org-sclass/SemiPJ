<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PETP</title>

<style type="text/css">
	.profileimg {
		width: 200px;
		height: 200px;
	}
	.board {
		width: 300px;
		height: 300px;
	}

</style>

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</head>
<body>
	<jsp:include page="form/header01.jsp" flush="true" />

	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
			
			<!-- 프로필 사진 -->
			<img src="../resources/images/profile.png" class="rounded mx-auto d-block profileimg" alt="profile_photo">
			<br>
			
			<!-- 프로필명 -->
			<p class="font-weight-bold text-center" style="font-size: 25px">User</p>
			<br>
			
			<!-- 업로드한 게시물들 -->
			<div class="row row-cols-1 row-cols-md-3">
			
				<div class="col mb-4">
					<div class="card board" >
				    	<!-- 사용자가 올린 사진만 보여줌? -->
				    	<img src="..." class="card-img-top" alt="...">
				    </div>
				</div>
				
				<div class="col mb-4">
					<div class="card board" >
				    	<!-- 사용자가 올린 사진만 보여줌? -->
				    	<img src="..." class="card-img-top" alt="...">
				    </div>
				</div>
				
				<div class="col mb-4">
					<div class="card board" >
				    	<!-- 사용자가 올린 사진만 보여줌? -->
				    	<img src="..." class="card-img-top" alt="...">
				    </div>
				</div>
				
				<div class="col mb-4">
					<div class="card board" >
				    	<!-- 사용자가 올린 사진만 보여줌? -->
				    	<img src="..." class="card-img-top" alt="...">
				    </div>
				</div>
				
			</div> <!-- end of 업로드한 게시물들 -->
		</div> <!-- end of container -->
	</main>

	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>