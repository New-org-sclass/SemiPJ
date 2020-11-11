<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.petp.dto.MemberDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#updateform").submit(function(){
			var count=0;
			$(".updateval").each(function(){
				if($(this).val()==""||$(this).val()==null){
					alert($(this).parent().prev("th").text()+" 입력하세요");
					$(this).focus();
					count++;
					return;
				}
			});
			if(count>0{
				return false;
			})
		}
	});
</script>
</head>
<% MemberDto dto = (MemberDto)request.getAttribute("dto"); %>
<body>
	<h1>내 정보 수정</h1>
	<form action="logincontroller.jsp" method="post" id="updateform">
		<input type="hidden" name="command" value="updateuser">
		<input type="hidden" name="myno" value="<%=dto.getMemno()%>">
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><%=dto.getMemid() %></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=dto.getMemname() %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" class="updateval" name="myaddr" value="<%=dto.getMememail() %>"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" class="updateval" name="myphone" value="<%=dto.getMyphone() %>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" class="updateval" name="myemail" value="<%=dto.getMyemail() %>"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="완료">
				</td>
			</tr>
		</table>
		
	</form>


</body>
</html>