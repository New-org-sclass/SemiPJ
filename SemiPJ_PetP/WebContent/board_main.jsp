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

<!-- kakao share -->
<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript">
	function formAction() {
		var form = document.getElementById('searchForm');
		var command = document.getElementsByName("command");
		command[0].setAttribute("value","boardmain");
		
		//BoardServlet.do?search=
		form.action;	
	}
	
	function sendLinkCustom() {
	       Kakao.init("8beadd0ec13f943b2e3c8d21a0f51bd0");
	       Kakao.Link.sendCustom({
	           templateId: 39929
	       });
	   }
	
</script>
<script>	
	
	try {
			function sendLinkDefault(boardNo, boardImg) {
				alert(boardNo);
				alert(boardImg);
				
			Kakao.init('8beadd0ec13f943b2e3c8d21a0f51bd0')
			Kakao.Link.sendDefault({
  				objectType: 'feed',
  				content: {
    				title: '[PetP]',
    				description: '#귀여운 댕댕이 #펫스타그램',
    				imageUrl: 'localhost:8787/SemiPJ_PetP/resources/board_uploadimg/' + boardImg,
    				link: {
      					mobileWebUrl: 'http://localhost:8787/SemiPJ_PetP/BoardServlet.do?command=detail&board_no=' + boardNo,
      					webUrl: 'http://localhost:8787/SemiPJ_PetP/BoardServlet.do?command=detail&board_no=' + boardNo,
    				},
  				},
  				buttons: [{
      				title: '자세히 보기',
      				link: {
        				mobileWebUrl: 'http://localhost:8787/SemiPJ_PetP/BoardServlet.do?command=detail&board_no=' + boardNo,
        				webUrl: 'http://localhost:8787/SemiPJ_PetP/BoardServlet.do?command=detail&board_no=' + + boardNo,
      				},
    			}],
				})
			}
	; window.kakaoDemoCallback && window.kakaoDemoCallback() }
	catch(e) { window.kakaoDemoException && window.kakaoDemoException(e) }

</script>

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
	
	#card-image{
		padding: 20px;
		margin: 0 auto;
	}
	
	#kakao-link-btn{
		cursor: pointer;
	}
	
	body {
   		min-height:100vh;
   		height: 100%;
   		width: 100%;
	}
</style>

<title>PETP</title>
</head>
<body>
	<jsp:include page="form/header_test.jsp" flush="true" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">

			<!-- 목록 없을경우 -->
			<c:if test="${empty list }">
				<p>현재 데이터가 없습니다.</p>
			</c:if>
		
			<c:forEach items="${list }" var="dto" >
				<div class="card" style="margin-bottom: 30px; width: 500px">
					
					<div class="card-header" style="background-color: white;" onclick="location.href='BoardServlet.do?command=userBoard&board_writer=${dto.board_writer}'">
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
						<!-- 개인 게시글 댓글창으로 넘어가는 버튼-->
						<a href="BoardServlet.do?command=detail&groupNo=${dto.group_no }" ><img class="linkimg" src="resources/images/comment.png"></a>&nbsp;
						<!-- 카카오톡 공유 버튼-->
						<a id="kakao-link-btn" onClick="sendLinkDefault('${dto.board_no}', '${dto.file_group}');"><img class="linkimg" src="resources/images/kakaoshare.png"></a>
	  				</div>
					
				</div> <!-- end of card -->
			</c:forEach>

		</div> <!-- end of container -->
		
		
		<!-- start of paging -->
		<div class="container ml-auto" align="center">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">

		<c:set var="page" value="${(empty param.page) ? 1 : param.page}"></c:set>
		<c:set var="startNum" value="${page - (page-1) % 5}"></c:set>
		<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(count/10), '.')}"></c:set>
		<!-- 10.2 => 11 : Math.ceil(10.2) => 11 -->
		
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
		<c:if test="${(startNum + i ) <= lastNum }"></c:if>
		<li class="page-item"><a class="page-link text-warning" href="?command=boardmain&page=${startNum + i }&search=${param.search}">${startNum + i }</a></li>
		</c:forEach>
    			
    	<!-- 다음 버튼 -->
    	<c:if test="${startNum + 4 < lastNum }">
		    <li class="page-item">
		    	<a class="page-link text-warning" href="?command=boardmain&page=${startNum + i }&search=${param.search}" aria-label="Next">
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
	
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>



