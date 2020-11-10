<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "com.petp.dto.MemberDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function registForm(){
		location.href="member.do?command=registform";
	}
</script>
</head>
<body>
	<jsp:include page="form/header_test.jsp" flush="true" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
	<div style="width:300px" >
	<h1 style="text-align: center;">로그인</h1>
		<form action="member.do" method="post">
			<input type="hidden" name="command" value="login">
			<table border="1">
				<col width="100"><col width="100">
				<tr>
					<th>I D : </th>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<th>P W : </th>
					<td><input type="text" name="pw"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="LOGIN">
						<input type="button" value="REGIST" onclick="registForm();">
					</td>
				</tr>
			</table>
		</form>
	</div>

	</main>	
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>