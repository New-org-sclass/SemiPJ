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
// 이미지의 크기만큼 div의 maxheight 설정
function getSize(obj) {
	var imgheight = obj.height;
	
	document.getElementsByClassName('card')[0].style.setProperty ("max-height", imgheight+"px");
}

// httpRequest 객체 생성
function getXMLHttpRequest(){
    var httpRequest = null;

    if(window.ActiveXObject){
        try{
            httpRequest = new ActiveXObject("Msxml2.XMLHTTP");    
        } catch(e) {
            try{
                httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e2) { httpRequest = null; }
        }
    }
    else if(window.XMLHttpRequest){
        httpRequest = new window.XMLHttpRequest();
    }
    return httpRequest;    
}

</script>
</head>

<body>
	<jsp:include page="form/header01.jsp" flush="true" />
	
	<main role="main" style="padding-top: 150px; padding-bottom: 100px; background-color: #fffff9; ">
	<div class="container">	

			<c:if test="${list ne null }">
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
                     	<!-- 댓글 작성자만 삭제 가능하도록 
                     	<c:if test="${list.board_writer == session.sessionID }"></c:if>
                     	-->
                     	<form action="BoardServlet.do" method="post">
		          			<div class="card-answer-user" id="comments" style="background-color: #f5f5dc;">
		    					<img src="resources/images/profile.png" class="profileimg">&nbsp; 
		  						<!-- 댓글 주인 -->
		  						<input type="text" value="${list.board_writer }" readonly style="border: none; outline: none; ">
		  						<input type="text" value="${list.board_content }" readonly style="border: none; outline: none; display: block; margin-left: 40px;">
		  						<input type="hidden" name="boardNo" value="${list.board_no }">
		  						<input type="hidden" name="groupNo" value="${list.group_no }">
		  						<input type="hidden" name="command" value="delComment">
		  						<input type="submit" value="댓글 삭제">
		  					</div>
	  					</form>
	  				</c:forEach>
          			</div>	
          			
	    		<!-- 댓글 입력 부분 -->
	    		<div class="card-footer">
                  <form id="commentForm" action="BoardServlet.do" method="post">
                  <div class="input-group">
                  	
                  	<!-- 서블릿으로 보내야할 값 boardNo, memNo, Comment -->
                  	<input type="hidden" name="command" value="addComment">
                  	<input type="hidden" name="memNo" value="1">
                  	<input type="hidden" name="boardNo" value="${board.board_no}">
                  	<input type="hidden" name="groupNo" value="${board.group_no }">
                  	
                  	<input id="commentInput" type="text" class="form-control" placeholder="댓글 달기.." aria-label="Recipient's username" aria-describedby="button-addon2" name="comment">
  						<div class="input-group-append">
    						<button class="btn btn-outline-secondary" type="submit"><img class="linkimg" src="resources/images/send.png"></button>
  						</div>
					</div>
          			</form>
          			</div>
	    		</div> <!-- end of card -->
	  		</div> <!-- end of card-group -->
	  		</c:if>
	</div> <!-- end of container -->

	
	</main>
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>