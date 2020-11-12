<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	.uploadimg {
		width: 300px;
		height: 300px;
	}
	
	.card {
		width: 300px;
		height: 300px;
		margin: 10px;
	}
	
</style>

</head>
<body>
	<jsp:include page="form/header02.jsp" flush="false" />

	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
			
			<!-- 프로필 사진 -->
			<img src="resources/images/profile.png" class="rounded mx-auto d-block profileimg" alt="profile_photo">
			<br>
			
			<!-- 프로필명 -->
			<p class="font-weight-bold text-center" style="font-size: 25px" >${board_writer }</p>
			<br>
			
			<!-- 업로드한 게시물들 -->
			<!-- 목록 없을경우 -->
			<c:if test="${empty list }">
				<p>현재 데이터가 없습니다.</p>
			</c:if>
			
			<div class="row" >
				<c:forEach items="${list }" var="dto" >
					<div class="col" style="margin-top: 30px;">
				    	<!-- 사용자가 올린 사진만 보여줌 -->
				    	<a href="BoardServlet.do?command=detail&groupNo=${dto.group_no }" >
				    		<img src="./resources/board_uploadimg/${dto.file_group }" class="uploadimg" >
				    	</a>
				    </div>
				</c:forEach>
			</div>
		</div> <!-- end of container -->
		
		
		<!-- start of paging -->
		<div class="container ml-auto" align="center" style="margin-top: 100px">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">

		<c:set var="page" value="${(empty param.page) ? 1 : param.page}"></c:set>
		<c:set var="startNum" value="${page - (page-1) % 5}"></c:set>
		<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(count/10), '.')}"></c:set>
		
		<!-- 이전 버튼 -->
		<c:if test="${startNum > 1 }">
			<li class="page-item">
				<a class="page-link text-warning" href="?command=userBoard&page=${startNum - 1 }&boardwriter=${board_writer}" aria-label="Previous">
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
		<c:if test="${(startNum + i ) <= lastNum }"></c:if>
		<li class="page-item"><a class="page-link text-warning" href="?command=userBoard&page=${startNum + i }&boardwriter=${board_writer}">${startNum + i }</a></li>
		</c:forEach>
    			
    	<!-- 다음 버튼 -->
    	<c:if test="${startNum + 4 < lastNum }">
		    <li class="page-item">
		    	<a class="page-link text-warning" href="?command=userBoard&page=${startNum + i }&boardwriter=${board_writer}" aria-label="Next">
		    		<span aria-hidden="true">&raquo;</span>
		      	</a>
		   	</li>
	   	</c:if>
	   	
	   	<c:if test="${startNum + 4 >= lastNum }">
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