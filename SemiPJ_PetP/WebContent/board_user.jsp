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
			<img src="resources/images/profile.png" class="rounded mx-auto d-block profileimg" alt="profile_photo">
			<br>
			
			<!-- 프로필명 -->
			<p class="font-weight-bold text-center" style="font-size: 25px">User</p>
			<br>
			
			<!-- 업로드한 게시물들 -->
			<!-- 목록 없을경우 -->
			<c:if test="${empty list }">
				<p>현재 데이터가 없습니다.</p>
			</c:if>
			
			<c:forEach items="${list }" var="dto" >
			
				<div class="row row-cols-1 row-cols-md-3">
  					<div class="col mb-1">
					<div class="card board" >
				    	<!-- 사용자가 올린 사진만 보여줌? -->
				    	<img src="./resources/board_uploadimg/${dto.file_group }" class="card-img-top" alt="...">
				    </div>
				</div>
				</div>


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
		<li class="page-item"><a class="page-link text-warning" href="?command=boardmain&page=${startNum + i }">${startNum + i }</a></li>
		</c:forEach>
    			
    	<!-- 다음 버튼 -->
    	<c:if test="${startNum + 5 < lastNum }">
		    <li class="page-item">
		    	<a class="page-link text-warning" href="?page=${startNum + 5 }" aria-label="Next">
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

	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>