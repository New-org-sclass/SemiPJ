<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

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
    		<div class="col-md-4" style="margin: 25px 80px 20px 60px;" >
      			<img src="resources/images/dog_ex.png" class="card-img" alt="#게시글  이미지" style="width: 350px; height: 430px;">
    		</div>
    		
    		<!-- 댓글 다는 부분 -->
    		<div class="card my-4" id="content" style="width: 400px; height: 430px">
          		<div class="card-header">
    				<img src="resources/images/profile.png">&nbsp; User1
  				</div> 
          		
          		<div class="card-body">
          			<div class="card-answer-user" style="background-color: #fff;">
    					<img src="resources/images/profile.png">&nbsp; User2
  					</div>
						<c:forEach var="dto" items="${list }" >
							<tr>
								<td>${dto.board_content }</td>
							</tr>
						</c:forEach>

  					<!-- 
  					<div id="card-content">&emsp;&emsp;&nbsp; Content</div><br>
  					 -->
          		</div>	
          		
				<div class="input-group mb-3" style="width: 350px; margin: 0 auto;">
  					<form action="BoardServlet.do" method="post">
  						<input type="hidden" name="command" value="boardwrite">
  						<table>
  							<col width="300">
  							<tr>
  								<td><textarea class="form-control" id="chatContent" aria-label="Recipient's username" aria-describedby="button-addon2" placeholder="댓글 달기.." style="resize: none; font-size: 15px;"></textarea></td>
  							</tr>
  						</table>
  						<div class="input-group-append">
    						<button class="btn btn-outline-secondary" type="submit" id="button-addon2"><img class="linkimg" src="resources/images/send.png"></button>
  						</div>
					</form>
				</div>

        	</div>
        </div>
        	
  	</div>








	
	
	</main>
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>