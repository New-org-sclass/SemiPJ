<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 모바일 환경 지원 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   
   	<!-- jQuery and Bootstrap Bundle (includes Popper) -->
   	<!--  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
   	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
	
	<title>Insert title here</title>

	<style type="text/css">
		.navbar-nav { 
            margin-left: auto; 
        } 
	</style>
   
</head>
<body>
   <header>
      <nav class="navbar navbar-expand-lg navbar-light fixed-top" style="background-color: #f5f5dc;">
         
         <!-- 로고 클릭시 마이페이지로 이동 -->
         <a class="navbar-brand" href="">
             <img src="resources/images/logo01.png" width="30" height="30" class="d-inline-block align-top" alt="">
             PetP
         </a>

      </nav>
   </header>
</body>

</html>