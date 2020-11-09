<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PETP</title>

<style type="text/css">
	img {
		width: 30px;
		height: 30px;
	}
	.uploadimg {
		width: 500px;
		height: 500px;
	}
	
	.img_wrap {
		width: 500px;
		height: 500px;
		margin: 10px;
	}
	
	.img_wrap img {
		max-width: 100%;
		max-height: 100%;
	}
	
	.center-block {
		display: block;
		margin-left: auto;
		margin-right: auto;
	}
</style>

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<script type="text/javascript">

	// 업로드 이미지 미리보기 처리	
	var selfile;
	$(document).ready(function() {
		$("#input_img").on("change", handleImgFileSelect);
	});
	
	function handleImgFileSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$(".uploadimg").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	// 업로드 이미지 이름 
	$(".custom-file-input").on("change", function() {
		  var fileName = $(this).val().split("\\").pop();
		  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
	});

</script>

</head>
<body>
	<jsp:include page="form/header01.jsp" flush="true" />

	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
		<div class="card">
			<!-- 사진 업로드 -->
			<form action="BoardServlet.do" method="post" enctype="multipart/form-data">  			
  				<input type="hidden" name="command" value="boardadd"> 
  				
  				
	  			<div class="card-header" style="background-color: white;">
	    			<img src="resources/images/profile.png"> 
	    			<input type="text" name="memno" value="1" readonly style="border: none;">
	    			<!-- 
	    			로그인 성공시 서블릿에서 세션 객체 생성
	    			HttpSession session = request.getSession(true);
            		session.setAttribute("userDto", userDto)
            		
            		board_add.jsp 에서 받기
            		${userDto.mem_no }
            		${userDto.mem_name }
            		${userDto.mem_profile }
	    			-->
	  			</div>
	  			
	  			<!-- 사용자가 업로드한 이미지 -->
	  			<div class="img_wrap center-block">
	  				<img id="photo" src=""  class="uploadimg" alt="...">
	  			</div>
	  				
				<div class="card-body">
					<!-- 내용 입력 -->
					<div class="form-group">
						<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="content" name="content"></textarea>
					</div>
					
					<!-- 해쉬태그 입력 -->
					<div class="input-group mb-3">
	  					<input type="text" class="form-control" placeholder="#hashtag" aria-label="Recipient's username" aria-describedby="button-addon2" name="hashtag">
					</div>
					<div class="input-group mb-3" id="fileArea" style="margin-bottom:10px">
						<div class="input-group-prepend">
							<img src="resources/images/camera.png"> &nbsp;&nbsp;
						</div>
						
						<div class="custom-file">
							<input type="file" class="custom-file-input" id="input_img" name="upfile" accept="image/*">
							<label class="custom-file-label" for="input_img" ></label>
						</div>
					</div>
				</div> <!-- end of card-body -->
	
	  			
	  			<div class="card-footer" style="background-color: white">
					<button type="submit" class="btn btn-lg btn-block" style="background-color: #f5f5dc" >Upload</button>
	  			</div>
  			
			</form> <!-- end of form -->
  		</div> <!-- end of card -->
  		
		</div> <!-- end of container -->
	</main>

	<jsp:include page="form/footer.jsp" flush="true" />

</body>
</html>