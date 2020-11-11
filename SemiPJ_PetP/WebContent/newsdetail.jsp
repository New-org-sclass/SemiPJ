<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8"); %>    
<%	response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petp.dto.NewsDto" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>newsdetail</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	
	
	
	
	</script>
	

</head>
	
<body>
<% String st1 = String.valueOf(session.getAttribute("test1")); %>
<% String st2 = (String)session.getAttribute("tre1"); %>
<% String st3 = (String)session.getAttribute("tre2"); %>
<br>
	testreturn1 : <%=st1 %>
	<br>testreturn2 : <%=st2 %> 
	<br>testreturn3 : <%=st3 %> 
	
	<br>
	<a href="Newscon.do?command=test1">test1으로..</a>
	


</body>
</html>