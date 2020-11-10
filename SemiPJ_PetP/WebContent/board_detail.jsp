<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	
	img {
		width: 30px;
		height: 30px;
	}
	
	body {
   		min-height:100vh;
   		height: 100%;
   		width: 100%;
   		
	}
	
	#container{
		max-width: 900px;
		height: 480px;
		margin: 0 auto;
	}

</style>


</head>

<body>
	<jsp:include page="form/header01.jsp" flush="true" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		
	<div class="card mb-3" id="container">
  		<div class="row no-gutters">
  		
  			<!-- 사용자가 업로드한 이미지 -->
  			<!-- 목록 없을경우 -->
			<c:forEach items="${list }" var="dto" >
			<c:if test="${empty list }">
				<p>현재 데이터가 없습니다.</p>
			</c:if>
			
    		<div class="col-md-4" style="margin: 25px 80px 20px 60px;" >
      			<img src="./resources/board_uploadimg/${dto.file_group }" class="card-img" alt="#게시글  이미지" style="width: 350px; height: 430px;">
    		</div>
    		
			
			
    		<!-- 댓글 보여주는 부분 -->
    		<div class="card my-4" id="content" style="width: 400px; height: 430px">
          		<div class="card-header">
    				<img src="resources/images/profile.png">&nbsp; User1
  				</div> 
          		
          		<div class="card-body">
          			<div class="card-answer-user" style="background-color: #fff;">
    					<img src="resources/images/profile.png">&nbsp; User2
  					</div>
							<tr>
								<td>${dto.board_content }</td>
							</tr>
          		</div>	
  					<!-- 
  					<div id="card-content">&emsp;&emsp;&nbsp; Content</div><br>
  					 -->
        	</div>
			</c:forEach>
  					 
  					 
          		<!-- 댓글 입력부분 -->
				<div class="input-group mb-3" style="width: 350px; margin: 0 auto;">
  					<form action="BoardServlet.do" method="post">
  						<input type="hidden" name="command" value="boardwrite">
  						<table>
  							<col width="300">
  							<tr>
  								<td>
	  								<textarea class="form-control" id="chatContent" 
	  								aria-label="Recipient's username" aria-describedby="button-addon2" placeholder="댓글 달기.." 
	  								style="resize: none; font-size: 15px;"
	  								name="comment_context">
	  								</textarea>
  								</td>
  							</tr>
  						</table>
  						<div class="input-group-append">
    						<button class="btn btn-outline-secondary" type="submit" id="button-addon2"><img class="linkimg" src="resources/images/send.png"></button>
  						</div>
					</form>
				</div>

        </div>
        	
  	</div>

	
	</main>
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>