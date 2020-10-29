<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<jsp:include page="./form/header01.jsp" flush="true" />

	<main role="main" style="margin-top: 100px; background-color: #fffff9; ">
		<div class="container">
			<table width="200" cellpadding="0" cellspacing="0" border="1" class="table table-bordered ">
				<tr>user1</tr>
				<tbody>
					
				</tbody>
			</table>
		</div>
	</main>

	<jsp:include page="./form/footer.jsp" flush="true" />
</body>
</html>