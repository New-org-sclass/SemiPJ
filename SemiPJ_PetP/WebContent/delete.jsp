<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
    <%@page import="com.petp.dto.MemberDto" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function del(memno){
		location.href="Member.do?command=delete&memno="+memno;
	}
	function back(){
		location.href="Member.do?command=updateForm";
	}
</script>

<style type="text/css">
main > div.container {
	postion: absolute;
	width: 300px;
	top: 50%;
	left: 50%;
	background-color: #f5f5dc;
	padding: 5%;
	border-radius: 50px;
}

#span {
	font-size: 60px;
	font-weight: bold;
}
</style>

</head>
<body>
<% MemberDto dto = (MemberDto)request.getAttribute("dto"); %>
<jsp:include page="form/header03.jsp" flush="false" />

	<main role="main" style="padding-top: 80px; padding-bottom: 50px; background-color: #fffff9; ">
		<div class="container">
		
			<div align="center">
		    	
    		</div>
    		
    		<form action="Member.do" method="post">
				<input type="hidden" name="command" value="insert">
				  <div class="form-group" style="margin-top: 10px;">
				    <label for="exampleInputPassword1"><%=dto.getMemid()%></label>
				    <input type="button" class="btn btn-secondary btn-lg btn-block" onclick="back();" style="border: none;  height: 50px;"  value="취소">		
				  </div>
				  
				  <div align="center" style="margin-top:10px;">
				  	<input type="button" class="btn btn-secondary btn-lg btn-block" onclick="del(<%=dto.getMemno()%>);" style="border: none;  height: 50px; " value="확인">
				  </div>
			</form>
		</div>
		
		</main>
	<jsp:include page="form/footer.jsp" flush="false" />

</body>
</html>