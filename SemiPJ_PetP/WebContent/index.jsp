<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetP</title>
</head>
<body>
<% session.setAttribute("test1", 0); %>

	<a href="">나의 작업 페이지로 이동</a>
	<a href="">나의 작업 페이지로 이동</a>
	<a href="newsdetail.jsp">session test</a>
  <br>
	<a href="BoardServlet.do?command=boardmain">펫스타그램</a>
	<a href="Newscon.do?command=news">news test page</a>
	


</body>
</html>