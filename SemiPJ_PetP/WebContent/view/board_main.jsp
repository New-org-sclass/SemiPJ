<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<title>petstagram</title>

<style type="text/css">
	.uploadimg {
		width: 300px;
		height: 300px;
	}
	
	.linkimg {
		width: 20px;
		height: 20px;
	}
	
	img {
		width: 30px;
		height: 30px;
	}
</style>
</head>

<body>
	<jsp:include page="../form/header01.jsp" flush="true" />

	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
			<div class="card">
				
				<div class="card-header" style="background-color: white;">
    				<img src="../resources/images/profile.png">
    				User name
  				</div>
  				
				<!-- 사용자가 업로드한 이미지 -->
				<img class = "uploadimg" src="..." class="card-img-top" alt="...">
				<div class="card-body">
					<b class="card-title">Card content</b>
					<p class="card-text">#hashtag #hashtag #hastag</p>
				</div>
				
				<div class="card-footer" style="background-color: white">
					<a href="#" ><img class="linkimg" src="../resources/images/comment.png"></a>
					&nbsp
					<a href="#" ><img class="linkimg" src="../resources/images/kakaoshare.png"></a>
  				</div>
				
			</div>

		</div>
	</main>

	<jsp:include page="../form/footer.jsp" flush="true" />
</body>
</html>