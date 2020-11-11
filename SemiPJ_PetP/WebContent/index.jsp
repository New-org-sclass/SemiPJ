<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetP</title>
</head>
<body>

	<a href="">나의 작업 페이지로 이동</a>
  <br>
  <!-- 
  memberDto 객체에서 mem_name 가져와서 작업. 
  ${dto.mem_name}		
  -->
	<a href="location.href='BoardServlet.do?command=userBoard&board_writer=관리자'">userMain</a>
	<a href="chat_main.jsp">petTalk</a>
	<a href="BoardServlet.do?command=boardmain">펫스타그램</a>
	<a href="Newscon.do?command=news">news test page</a>

</body>
</html>