<!-- 1101 form 태그 쓰면 왜 onchange가 안먹히는지 확인해보기. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PETP</title>

<!-- .uploadimg 현재 작동 안됨 -->
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
	//현재 화면에 존재하는 #fileArea의 수를 담는 변수
	var fileAreaCnt = null;
	
	$(function() {
		fileAreaCnt = fileArea.childElementCount - 1;
	});
	
	
	function addFileSelect() {
		
		var select = document.getElementById("fileOption");
		var index = select.selectedIndex;
		var selectVal = select.options[index].value;
	
		if(fileAreaCnt !== selectVal) {
			
			$("div#fileArea:not(:first)").remove();
			
			for(var i=0; i<selectVal-1; i++) {
				$("#empty").prepend($("#fileArea").clone());
			}
		} 
	}
</script>

</head>
<body>
	<jsp:include page="form/header01.jsp" flush="true" />

	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
		<div class="card">
		
		<form action="board_uploadaction.jsp" method="post" enctype="multipart/form-data">
  			<div class="card-header" style="background-color: white;">
    			<img src="resources/images/profile.png">
    			User name
  			</div>
  			
  			<!-- 사용자가 업로드한 이미지 -->
  			<img class = "uploadimg" src="..." class="card-img-top" alt="...">
  				
			<div class="card-body">
				<!-- 내용 입력 -->
				<div class="form-group">
					<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="content"></textarea>
				</div>
				
				<!-- 해쉬태그 입력 -->
				<div class="input-group mb-3">
  					<input type="text" class="form-control" placeholder="#hashtag" aria-label="Recipient's username" aria-describedby="button-addon2">
				</div>
				
					<!-- 업로드할 사진 갯수 정하기 -->
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<img src="resources/images/camera.png"> &nbsp;&nbsp;
						</div>
						
						<select class="custom-select" id="fileOption" onchange="addFileSelect();">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					
						<div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="submit">Upload</button>
						</div>
					</div>
				
					<!-- 사진 업로드 -->
					<div class="input-group" id="fileArea" style="margin-bottom:10px">
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="upfile1">
							<label class="custom-file-label" for="inputGroupFile04"></label>
						</div>
					</div>
					<div id="empty"></div>
				
				</div> <!-- end of card-body -->
			</form> <!-- end of 사진 업로드 form -->
  			
  			<div class="card-footer" style="background-color: white">
				<button type="button" class="btn btn-lg btn-block" style="background-color: #f5f5dc">Upload</button>
  			</div>
  			
  		</div> <!-- end of card -->
		</div> <!-- end of container -->
	</main>

	<jsp:include page="form/footer.jsp" flush="true" />

</body>
</html>