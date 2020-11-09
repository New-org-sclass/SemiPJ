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

<script type="text/javascript">
	function formAction() {
		var form = document.getElementById('searchForm');
		var command = document.getElementsByName("command");
		command[0].setAttribute("value","boardmain");
		
		//BoardServlet.do?search=
		form.action;	
	}
</script>

<title>PETP</title>

<style type="text/css">
	.uploadimg {
		width: 500px;
		height: 100%;
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
</head>
<body>
	<jsp:include page="form/header_test.jsp" flush="false" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
			<!-- 목록 없을경우 -->
			<c:if test="${empty list }">
				<p>현재 데이터가 없습니다.</p>
			</c:if>
		
			<c:forEach items="${list }" var="dto" >
				<div class="card" style="margin-bottom: 30px">
					
					<div class="card-header" style="background-color: white;" onclick="location.href='board_user.jsp'">
	    				<img src="resources/images/profile.png">&nbsp;
	    				<b>${dto.board_writer }</b>
	  				</div>
	  				
					<!-- 사용자가 업로드한 이미지 -->
					<div class="img_wrap center-block">
						<img class = "uploadimg" src="./resources/board_uploadimg/${dto.file_group }" class="card-img-top">
					</div>
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
		
		
		<!-- start of paging -->
		<div class="container ml-auto" align="center">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">

		<c:set var="page" value="${(param.page == null) ? 1 : param.page}"></c:set>
		<c:set var="startNum" value="${page - (page-1) % 5}"></c:set>
		<c:set var="lastNum" value="23"></c:set>
		
		<!-- 이전 버튼 -->
		<c:if test="${startNum > 1 }">
			<li class="page-item">
				<a class="page-link text-warning" href="?command=boardmain&page=${startNum - 1 }&search=${param.search}" aria-label="Previous">
	  				<span aria-hidden="true" class="btn-prev">&laquo;</span>
	     		</a>
	    	</li>
		</c:if>		
		
		<c:if test="${startNum <= 1 }">
			<li class="page-item">
				<a class="page-link text-warning" aria-label="Previous">
	  				<span aria-hidden="true" class="btn-prev" onclick="alert('이전 페이지가 없습니다.');">&laquo;</span>
	     		</a>
	    	</li>
		</c:if>
		
		<c:forEach var="i" begin="0" end="4">
		<li class="page-item"><a class="page-link text-warning" href="?command=boardmain&page=${startNum + i }&search=${param.search}">${startNum + i }</a></li>
		</c:forEach>
    			
    	<!-- 다음 버튼 -->
    	<c:if test="${startNum + 5 < lastNum }">
		    <li class="page-item">
		    	<a class="page-link text-warning" href="?page=${startNum + 5 }&search=${param.search}" aria-label="Next">
		    		<span aria-hidden="true">&raquo;</span>
		      	</a>
		   	</li>
	   	</c:if>
	   	
	   	<c:if test="${startNum + 5 >= lastNum }">
		    <li class="page-item">
		    	<a class="page-link text-warning" aria-label="Next">
		    		<span aria-hidden="true" onclick="alert('다음 페이지가 없습니다.');">&raquo;</span>
		      	</a>
		   	</li>
	   	</c:if>				
		
		</ul>
		</nav>
		</div>
	</main>
	
	<jsp:include page="form/footer.jsp" flush="false" />
</body>
</html>