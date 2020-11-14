<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    
    <%@page import="com.petp.dto.MemberDto" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetP</title>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script type="text/javascript">
	function pro(num,memno){
				location.href="Member.do?command=profile&num="+num+"&memno="+memno;
		}
		
	
	
</script>

<style type="text/css">
	.profileimg {
		width: 200px;
		height: 200px;
		border-radius: 60px 60px 50px 50px;
	}

	td{
		padding: 5px;
		text-align: center;
	}
	
	#aboutProfile{ 
		width: 300px;
	}

</style>


</head>
<body>
<% MemberDto dto = (MemberDto)request.getAttribute("dto"); %>
	<jsp:include page="form/header03.jsp" flush="true" />
	<main role="main" style="padding-top: 120px; padding-bottom: 70px; background-color: #fffff9; ">
	
	<div class="container" >
			<div class="card" style="background-color: #fffff9; border: none;">
				<div class="card-section-1" style="margin: 0 auto;">
					<table id="aboutProfile"> 
						<tr>
							<td rowspan="3"><a href="#" onclick="pro(1,<%=dto.getMemno()%>);"><img class="profileimg" name="pro1" src="resources/images/pro1.jpg"></a></td>
						</tr>
						<tr>
							<td rowspan="2"><a href="#" onclick="pro(2,<%=dto.getMemno()%>);"><img class="profileimg" src="resources/images/pro2.jpg"></a></td>
						</tr>
						<tr>
							<td rowspan="2"><a href="#" onclick="pro(3,<%=dto.getMemno()%>);"><img class="profileimg" src="resources/images/pro3.jpg"></a></td>
						</tr>
						<tr>
							<td rowspan="2"><a href="#" onclick="pro(4,<%=dto.getMemno()%>);"><img class="profileimg" src="resources/images/pro4.jpg"></a></td>
						</tr>
						<tr>
							<td rowspan="2"><a href="#" onclick="pro(5,<%=dto.getMemno()%>);"><img class="profileimg" src="resources/images/pro5.jpg"></a></td>
						</tr>
					</table>
					
					
		</div>
	
	</div>
	</div>
	
	
	</main>
	<jsp:include page="form/footer.jsp" flush="true" />
</body>
</html>