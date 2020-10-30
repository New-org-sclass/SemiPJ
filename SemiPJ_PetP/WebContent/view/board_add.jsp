<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>petstagram</title>

<style type="text/css">
	.uploadimg {
		width: 500px;
		height: 500px;
	}
	
	img {
		width: 30px;
		height: 30px;
	}
</style>

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<script type="text/javascript">


</script>

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
				<!-- 내용 입력 -->
				<div class="input-group mb-3">
  					<input type="text" class="form-control" placeholder="content" aria-label="Recipient's username" aria-describedby="button-addon2">
				</div>
				
				<!-- 해쉬태그 입력 -->
				<div class="input-group mb-3">
  					<input type="text" class="form-control" placeholder="#hashtag" aria-label="Recipient's username" aria-describedby="button-addon2">
				</div>
				
				<!-- 사진 업로드 -->
				<!-- 
				<form>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<img src="../resources/images/camera.png">
							&nbsp;&nbsp;
						</div>
						
						<div class="custom-file">
							<input type="file" class="custom-file-input" id="inputGroupFile01">
							<label class="custom-file-label" for="inputGroupFile01">Choose file</label>
						</div>
					</div>
				</form>
				-->
				<div class="input-group">
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="inputGroupFile04">
						<label class="custom-file-label" for="inputGroupFile04"></label>
					</div>
					
					<div class="input-group-append">
				    	<button class="btn btn-outline-secondary" type="button">Upload</button>
				    </div>
				</div>
		
			</div>
  			
  			<div class="card-footer" style="background-color: white">
				<button type="button" class="btn btn-lg btn-block" style="background-color: #f5f5dc">Upload</button>
  			</div>
  		</div>

		</div>
	</main>

	<jsp:include page="../form/footer.jsp" flush="true" />
</body>
</html>