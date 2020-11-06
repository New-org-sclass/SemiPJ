<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.petp.dto.BoardDto" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<title>PETP</title>

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
	
	body, wrapper {
   		min-height:100vh;
	}

	.flex-fill {
   		flex:1 1 auto;
	}
</style>
</head>
<body>
	<jsp:include page="form/header01.jsp" flush="true" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
			<c:forEach items="${list }" var="dto" >
			<div class="card" style="margin-bottom: 30px">
				
				<div class="card-header" style="background-color: white;" onclick="location.href='board_user.jsp'">
    				<img src="resources/images/profile.png">&nbsp;
    				<b>${dto.board_writer }</b>
  				</div>
  				
				<!-- 사용자가 업로드한 이미지 -->
				<img class = "uploadimg" src="" class="card-img-top">
				<div class="card-body">
					<b class="card-title">${dto.board_content }</b>
					<p class="card-text">${dto.board_hashtag }</p>
				</div>
				
				<div class="card-footer" style="background-color: white">
					<a href="#" ><img class="linkimg" src="resources/images/comment.png"></a>
					&nbsp
					<a href="#" ><img class="linkimg" src="resources/images/kakaoshare.png"></a>
  				</div>
				
			</div> <!-- end of card -->
			</c:forEach>

		</div> <!-- end of container -->
	</main>

	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>