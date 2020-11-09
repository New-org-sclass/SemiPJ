<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<title>PetP</title>
<style type="text/css">
	.uploadimg {
		width: 300px;
		height: auto;
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
	
	#card-image{
		padding: 20px;
		margin: 0 auto;
	}
	
	#kakao-link-btn{
		cursor: pointer;
	}
</style>

<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>

<body>
	<jsp:include page="form/header01.jsp" flush="true" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
		<div class="container">
		
			<div class="card">
				<div class="card-header" style="background-color: white;">
    				<img src="resources/images/profile.png">&nbsp; User1
  				</div>
  				
				<!-- 사용자가 업로드한 이미지 -->
				<div class="card-body1" id="card-image">
					<img class = "uploadimg" src="resources/images/dog_ex.png" class="card-img-top" alt="#게시글 이미지">
				</div>
				
				<div class="card-body2">
					<b class="card-title"> Card content</b>
					<p class="card-text"> #hashtag #hashtag #hastag</p>
				</div>
				
				<div class="card-footer" style="background-color: white">
					<!-- 개인 게시글 댓글창으로 넘어가는 버튼-->
					<a href="BoardServlet.do?command=detail" ><img class="linkimg" src="resources/images/comment.png"></a>&nbsp;
					<!-- 카카오톡 공유 버튼-->
					<a id="kakao-link-btn" onClick="sendLinkDefault();"><img class="linkimg" src="resources/images/kakaoshare.png"></a>
  				</div>
			</div>
		</div>
	</main>

	<!-- 카카오톡 공유 -->
	<script type="text/javascript">
    	function sendLinkCustom() {
        	Kakao.init("8beadd0ec13f943b2e3c8d21a0f51bd0");
        	Kakao.Link.sendCustom({
            	templateId: 39929
        	});
    	}
	</script>
	<script>
		try {
  			function sendLinkDefault() {
    			Kakao.init('8beadd0ec13f943b2e3c8d21a0f51bd0')
    			Kakao.Link.sendDefault({
      				objectType: 'feed',
      				content: {
        				title: '[PetP]',
        				description: '#귀여운 댕댕이 #펫스타그램',
        				imageUrl: 'https://ppss.kr/wp-content/uploads/2018/09/gggg.png',
        				link: {
          					mobileWebUrl: 'https://developers.kakao.com',
          					webUrl: 'https://developers.kakao.com',
        				},
      				},
      				buttons: [{
          				title: '자세히 보기',
          				link: {
            				mobileWebUrl: 'https://developers.kakao.com',
            				webUrl: 'https://developers.kakao.com',
          				},
        			}],
   				})
  			}
		; window.kakaoDemoCallback && window.kakaoDemoCallback() }
		catch(e) { window.kakaoDemoException && window.kakaoDemoException(e) }
	</script>

	<jsp:include page="form/footer.jsp" flush="true" />

</body>
</html>



