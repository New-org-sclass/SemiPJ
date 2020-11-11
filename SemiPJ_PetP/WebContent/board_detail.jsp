<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "com.petp.dto.BoardDto" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>PetP</title>
<style type="text/css">
	.linkimg {
		width: 20px;
		height: 20px;
		background-color: #fffff9;
		padding: 0px;
		margin: 0px;
	}
	
	.profileimg {
		width: 30px;
		height: 30px;
	}
	
	body {
   		min-height:100vh;
   		height: 100%;
   		width: 100%;
   		
	}
	.uploadimg {
		width: 400px;
		height: auto;
		margin: auto;
	}
</style>
<script type="text/javascript">
function getSize(obj) {
	var imgheight = obj.height;
	
	document.getElementsByClassName('card')[0].style.setProperty ("max-height", imgheight+"px");
}
</script>
</head>

<body>
	<jsp:include page="form/header01.jsp" flush="true" />
	
	<main role="main" style="padding-top: 150px; padding-bottom: 100px; background-color: #fffff9; ">
	<div class="container">	
			<div class="card-group">
				<!-- 게시글 보여주는 부분 -->
				<div class="col-mb-3">
			    <img src="./resources/board_uploadimg/${board.file_group }"  class="uploadimg" alt="#게시글  이미지" onload="javascript:getSize(this);">
	   			</div>
	   			
	   			<!-- 댓글 보여주는 부분 -->
	    		<div class="card">
		    		<div class="card-header">
    					<img src="resources/images/profile.png" class="profileimg ">&nbsp; 
    					<!-- 게시글 주인 -->
    					<input class="bg-light font-weight-bold" type="text" name="memno" value="${board.board_writer }" readonly style="border: none; outline: none;">
  					</div> 
          		
          			<div class="card-body overflow-auto">
          			<c:forEach items="${list }" var="list" >
                        &nbsp;&nbsp;
                     
	          			<div class="card-answer-user" id="comments" style="background-color: #f5f5dc;">
	    					<img src="resources/images/profile.png" class="profileimg">&nbsp; 
	  						<!-- 댓글 주인 -->
	  						<input type="text" value="${list.board_writer }" readonly style="border: none; outline: none; ">
	  						<input type="text" value="${list.board_content }" readonly style="border: none; outline: none; display: block; margin-left: 40px;">
	  					</div>
	  				</c:forEach>
          			</div>	
	    		
	    		<!-- 댓글 입력 부분 -->
	    		<div class="card-footer">
                  <form action="BoardServlet.do" method="post">
                  <div class="input-group">
                  	
                  	<!-- 서블릿으로 보내야할 값 boardNo, memNo, Comment -->
                  	<input type="hidden" name="command" value="addComment">
                  	<input type="hidden" name="memNo" value="1">
                  	<input type="hidden" name="boardNo" value="${board.board_no}">
                  	<input type="hidden" name="groupNo" value="${board.group_no }">
                  	
                  	<input type="text" class="form-control" placeholder="댓글 달기.." aria-label="Recipient's username" aria-describedby="button-addon2" name="comment">
  						<div class="input-group-append">
    						<button class="btn btn-outline-secondary" type="submit"><img class="linkimg" src="resources/images/send.png"></button>
  						</div>
					</div>
          			</form>
          			</div>
	    		</div> <!-- end of card -->
	  		</div> <!-- end of card-group -->
	</div> <!-- end of container -->

	
	</main>
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>