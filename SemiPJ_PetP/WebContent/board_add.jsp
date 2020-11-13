<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import = "com.petp.dto.MemberDto" %>

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

<script type="text/javascript">

	// 업로드 이미지 미리보기 처리	
	var selfile;
	window.onload = function () {
		$("#input_img").on("change", handleImgFileSelect);
	}
	
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
</script>

</head>
<body>
<%
	MemberDto member = (MemberDto)session.getAttribute("memberDto");

	if(session.getAttribute("memberDto") == null) {
		response.sendRedirect("home_main.jsp");
	} else {
%>

	<jsp:include page="form/header01.jsp" flush="true" />

	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
		<div class="card">
			<!-- 사진 업로드 -->
			<form action="BoardServlet.do" method="post" enctype="multipart/form-data">  			
  				<input type="hidden" name="command" value="boardadd">
  				<input type="hidden" name="memno" value="<%= member.getMemno() %>"> 
  				
  				
	  			<div class="card-header" style="background-color: white;">
	    			<img src="resources/images/profile.png"> 
	    			<input type="text" name="memid" value="<%=member.getMemid()%>" readonly style="border: none; outline: none;">
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
	
	  			
	  			<div class="card-footer justify-content-around" style="background-color: white">
					<button type="submit" class="btn btn-lg" style="background-color: #f5f5dc;" >Upload</button>
	  			</div>
  			
			</form> <!-- end of form -->
  		</div> <!-- end of card -->
  		
		</div> <!-- end of container -->
	</main>

	<jsp:include page="form/footer.jsp" flush="true" />
<%
	}
%>
</body>
</html>