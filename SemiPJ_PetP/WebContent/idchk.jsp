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
	onload=function(){
		var id = opener.document.getElementsByName("memid")[0].value;
		document.getElementsByName("id")[0].value=id;
	}
	function confirm(bool){
		if(bool=="true"){
			opener.document.getElementsByName("memname")[0].focus();
			opener.document.getElementsByName("memid")[0].title="y";
		}else{
			opener.document.getElementsByName("memid")[0].focus();
		}
		self.close();
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
<% String idnotused = request.getParameter("idnotused"); %>
<body>
<jsp:include page="form/header03.jsp" flush="false" />

	<main role="main" style="padding-top: 80px; padding-bottom: 50px; background-color: #fffff9; ">
		<div class="container">
		
			<div align="center">
		    	
    		</div>
    		
    		<form action="Member.do" method="post">
				<input type="hidden" name="command" value="insert">
				  <div class="form-group" style="margin-top: 10px;">
				    <label for="exampleInputPassword1">ID</label>
				    <input type="text" class="form-control" id="exampleInputPassword1" name="id" title="n" required="required">		
				  </div>
				  
				  <div class="form-group">
				    <label for="exampleInputPassword1">사용 여부</label>
				    <input type="text" class="form-control" id="exampleInputPassword1" value="<%=idnotused.equals("true")?"아이디 생성가능":"중복 아이디 존재" %>" readonly="readonly">
				  </div>
				  
				  <div align="center" style="margin-top:10px;">
				  	<input type="button" class="btn btn-secondary btn-lg btn-block" onclick="confirm('<%=idnotused%>');" style="border: none;  height: 50px; " value="확인">
				  </div>
			</form>
		</div>
		
		</main>
	<jsp:include page="form/footer.jsp" flush="false" />

</body>
</html>