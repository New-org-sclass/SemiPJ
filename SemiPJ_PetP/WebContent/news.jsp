<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	request.setCharacterEncoding("UTF-8"); %>
<% 	response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petp.dto.NewsDto" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>News</title>
<%	
	List<NewsDto> alist = (List<NewsDto>)request.getAttribute("alist");
%>
	<style type="text/css">
		.card-group{
			padding: 8px 30px;
		}
	</style>
		
	
	
</head>

<body>
<jsp:include page="/form/header01.jsp" flush="true" />
	<main role="main" style="margin-top: 80px; background-color: #fffff9; ">
      <div class="container">
      
		<h1>News list</h1>
		<table border="1">
			<col width="50px" />
			<col width="150" />
			<col width="150" />
			<col width="200" />
			<col width="200" />
			<col width="150" />
			<col width="100" />
			
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>url</th>
				<th>요약</th>
				<th>내용</th>
				<th>썸</th>
				<th>등록</th>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
				<td>5</td>
				<td>6</td>
				<td>7</td>
			</tr>
			<c:choose>
				<c:when test="${empty list} ">
					<tr>
						<td colspan="7">--뉴스 없음--</td>
					</tr>
				</c:when>
				<c:otherwise>
					여기 반복문
				</c:otherwise>
			</c:choose>
			
		</table>
		
      </div>
      
    
      
      <div class="card-group" >
		  <div class="card">
		    <img src="${alist[0].nimg }" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">${alist[0].ntitle } </h5>
		      <p class="card-text">${alist[0].nsummary }  </p>
		      <p class="card-text"><small class="text-muted">${alist[0].ndate } </small></p>
		    </div>
		  </div>
		  <div class="card">
		    <img src="${alist[1].nimg }" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">${alist[1].ntitle } </h5>
		      <p class="card-text">${alist[1].nsummary }  </p>
		      <p class="card-text"><small class="text-muted">${alist[1].ndate } </small></p>
		    </div>
		  </div>
		  <div class="card">
		    <img src="${alist[2].nimg }" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">${alist[2].ntitle } </h5>
		      <p class="card-text">${alist[2].nsummary }  </p>
		      <p class="card-text"><small class="text-muted">${alist[2].ndate } </small></p>
		    </div>
		  </div>
	  </div>
		
      <div class="card-group" >
		  <div class="card">
		    <img src="#" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card">
		    <img src="#" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
		  <div class="card">
		    <img src="#" class="card-img-top" alt="...">
		    <div class="card-body">
		      <h5 class="card-title">Card title</h5>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
		      <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		    </div>
		  </div>
	  </div>
	  <br>
	  <br>
	  <ul class="list-unstyled" >
		  <li class="media">
		    <img src="${alist[5].nimg }" class="mr-3" alt="...">
		    <div class="media-body">
		      <h5 class="mt-0 mb-1">${alist[5].ntitle }</h5>
		      ${alist[5].ncontent }
		    </div>
		  </li>
		  <li class="media">
		    <img src="${alist[6].nimg }" class="mr-3" alt="...">
		    <div class="media-body">
		      <h5 class="mt-0 mb-1">${alist[6].ntitle }</h5>
		      ${alist[6].ncontent }
		    </div>
		  </li>
		  <li class="media">
		    <img src="${alist[7].nimg }" class="mr-3" alt="...">
		    <div class="media-body">
		      <h5 class="mt-0 mb-1">${alist[7].ntitle }</h5>
		      ${alist[7].ncontent }
		    </div>
		  </li>
		  
	  </ul>
      <br>
      <br>
    </main>

<jsp:include page="/form/footer.jsp" flush="true" />    
</body>
</html>