<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function idChkConfirm(){
		var chk=document.getElementsByName("memid")[0].title;
		if(chk=="n"){
			alert("아이디 중복체크를 해주세요");
			document.getElementsByName("memid")[0].focus();
		}
	}
	function idChk(){
		var doc=document.getElementsByName("memid")[0];
		
		if(doc.value.trim()==""||doc.value==null){
			alert("아이디를 입력해주세요");
		}else{
			var target="member.do?command=idchk&id="+doc.value.trim();
			open(target,"","width=200,height=200");
		}
	}
</script>
</head>
<body>
<jsp:include page="form/header_test.jsp" flush="true" />
	
	<main role="main" style="padding-top: 100px; padding-bottom: 100px; background-color: #fffff9; ">
	<h1>회원가입</h1>
	<form action="member.do" method="post">
		<input type="hidden" name="command" value="insert">
		<table border="1">
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="memid" title="n" required="required">
					<input type="button" value="중복체크" onclick="idChk();">		
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="mempw" onclick="idChkConfirm();" required="required"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="memname" onclick="idChkConfirm();" required="required"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="mememail" onclick="idChkConfirm();" required="required"></td>
			</tr>
			<tr>
				<th>프로필</th>
				<td><input type="text" name="mempro" onclick="idChkConfirm();" required="required"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="가입">
				</td>
			</tr>
		</table>
	</form>
	</main>	
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>