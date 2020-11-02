<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "com.petp.dao.FileDao" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 사용자가 업로드한 파일명이 동일한 경우 자동으로 바꾸어 오류를 방지한다. -->
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	System.out.println("[board_uploadaction.jsp]");
	// application 내장 객체, 전체 프로젝트에 대한 자원을 관리하는 객체임
	// 서버의 실제 프로젝트 경로에서 자원을 찾는 경우 많이 사용
	// String directory = application.getRealPath("/upload/");
	
	String filePath = "/resources/board_uploadimg/";
	String directory = application.getRealPath(filePath);
	
	System.out.println("directory: " + directory);
	int maxSize = 1024 * 1024 * 100;
	String encoding = "UTF-8";
	
	MultipartRequest multipartRequest
	= new MultipartRequest(request, directory, maxSize, encoding,
			new DefaultFileRenamePolicy());
	// 사용자가 전송한 file을 설정한 maxSize로 업로드 가능하도록
	
	// 향상된 for문과 비슷한 기능
	Enumeration filenames = multipartRequest.getFileNames();
	while(filenames.hasMoreElements()) {
		String parameter = (String)filenames.nextElement();
		String filename = multipartRequest.getOriginalFileName(parameter);
		String filerealname = multipartRequest.getFilesystemName(parameter);
		
		if(filename == null)  // 파일을 3개 꽉 채워서 업로드 하지 않았다면
			continue;
		
		if(!filename.endsWith(".png") && !filename.endsWith(".jpg")) {
			// 사진형식의 파일이 아니면 삭제
			File file = new File(directory + filerealname);
			file.delete();
			out.write("업로드할 수 없는 확장자입니다.");
			
		} else {
			new FileDao().upload(filename, filerealname);
			out.write("파일명: " + filename + "<br>");
			out.write("실제 파일명: " + filerealname + "<br>");
		}
	}	
%>
</body>
</html>