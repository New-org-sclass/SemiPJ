<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetP</title>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<style type="text/css">
	.profileimg {
		width: 100px;
		height: 100px;
	}

	td{
		padding: 5px;
		text-align: center;
	}
	
	#aboutProfile{ 
		width: 300px;
	}

</style>


</head>
<body>
	<jsp:include page="form/header03.jsp" flush="true" />
	<main role="main" style="padding-top: 120px; padding-bottom: 70px; background-color: #fffff9; ">
	
	<div class="container" >
			<div class="card" style="background-color: #fffff9; border: none;">
				<div class="card-section-1" style="margin: 0 auto;">
					<table id="aboutProfile"> 
						<tr>
							<td rowspan="2"><img class="profileimg" src="resources/images/profile.png"></td>
							<td style="font-size: 25px;">프로필명</td>
						</tr>
						<tr>
							<td style="color: blue;"><a href="#" class="text-decoration-none">프로필 사진 바꾸기</a></td>
						</tr>
					</table>
				</div>
				<br><br>
				
				<div class="card-section-2" style="margin: 0 auto;">
						<!-- id -->
  						<div class="form-group row">
    						<label for="inputId" class="col-sm-2 col-form-label">ID</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="inputId" placeholder="아이디" style="width: 400px;">
    						</div>
  						</div>
  						
  						<!-- email -->
  						<div class="form-group row">
    						<label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
    						<div class="col-sm-10">
      							<input type="email" class="form-control" id="inputEmail" placeholder="이메일" style="width: 400px;">
    						</div>
  						</div>
  						
  						<!-- password -->
  						<div class="form-group row">
    						<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
    						<div class="col-sm-10">
      							<input type="password" class="form-control" id="inputPassword" placeholder="비밀번호" style="width: 400px;">
    						</div>
  						</div>
  						
  						<!-- password-reconfirm -->
  						<div class="form-group row">
    						<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호 재확인</label>
    						<div class="col-sm-10">
      							<input type="password" class="form-control" id="inputPassword-re" placeholder="비밀번호 재확인" style="width: 400px;">
    						</div>
  						</div>
				</div>
				<br>
				
				<div class="card-section-3" style="margin: 0 auto;" >
					<table>
						<tr>
							<td colspan="2">
								<button type="button" class="btn btn-light" style="background-color: #f5f5dc; border: none; width: 400px;">프로필 수정</button>
							</td>
						</tr>
							<td><button type="button" class="btn btn-light" style="background-color: #f5f5dc; border: none; width: 195px;" onclick="#">로그아웃</button></td>
							<td><button type="button" class="btn btn-light" style="background-color: #f5f5dc; border: none; width: 195px;" onclick="#">계정 삭제</button></td>
					</table>
				</div>
		</div>
	</div>
	
	
	</main>
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>