<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
			var target="Member.do?command=idChk&id="+doc.value.trim();
			open(target,"","width=500,height=500");
		}
	}
</script>

<style type="text/css">
main > div.container {
	postion: absolute;
	width: 600px;
	top: 50%;
	left: 50%;
	background-color: #f5f5dc;
	padding: 5%;
	border-radius: 100px;
}

#span {
	font-size: 60px;
	font-weight: bold;
}
</style>

<title>PETP</title>
</head>
<body>
<jsp:include page="form/header02.jsp" flush="false" />

	<main role="main" style="padding-top: 200px; padding-bottom: 200px; background-color: #fffff9; ">
		<div class="container">
		
			<div align="center">
		    	<img src="resources/images/logo01.png" class="card-img2" style="width: 80px;">&nbsp;&nbsp;
		    	<span id="span">PETP</span>
    		</div>
		
			<form action="Member.do" method="post">
				<input type="hidden" name="command" value="insert">
				  <div class="form-group" style="margin-top: 30px;">
				    <label for="exampleInputEmail1">Email address</label>
				    <input type="email" class="form-control" id="exampleInputEmail1" name="mememail" aria-describedby="emailHelp" onclick="idChkConfirm();" required="required">
				  </div>
				  
				  <div class="form-group">
				    <label for="exampleInputPassword1">ID</label>
				    <input type="text" class="form-control" id="exampleInputPassword1" name="memid" title="n" required="required">
				    <input type="button"  class="btn btn-secondary btn-lg btn-white" value="ID Check" onclick="idChk();">
				  </div>
				  
				  <div class="form-group">
				    <label for="exampleInputPassword1">NAME</label>
				    <input type="text" class="form-control" id="exampleInputPassword1" name="memname" title="n" required="required">
				  </div>
				  
				  <div class="form-group">
				    <label for="exampleInputPassword1">Password</label>
				    <input type="password" class="form-control" name="mempw" id="exampleInputPassword1" onclick="idChkConfirm();" required="required">
				  </div>
				  
				  <div align="center" style="margin-top:50px;">
				  	<button type="submit" class="btn btn-secondary btn-lg btn-block" style="border: none;  height: 50px;">Sign Up</button>
				  </div>
			</form>

		</div>
	</main>
<jsp:include page="form/footer.jsp" flush="false" />
</body>
</html>