package com.petp.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.petp.biz.BoardBiz;
import com.petp.biz.BoardBizImpl;
import com.petp.dto.FileDto;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    
	    String command = request.getParameter("command");
	    
	    System.out.println("[BoardServlet]");
	    System.out.println("command : " + command);
	    
	    BoardBiz biz = new BoardBizImpl();
	    
	    if(command.equals("fileupload")) {
	    	
	    	// application 내장 객체, 전체 프로젝트에 대한 자원을 관리하는 객체임
	    	// 서버의 실제 프로젝트 경로에서 자원을 찾는 경우 많이 사용
	    	String filePath = "/resources/board_uploadimg/";
	    	String directory = request.getSession().getServletContext().getRealPath(filePath);
	    	
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
	    	
	    		if(filename == null)  // 파일검색input 수를 꽉 채워서 업로드하지 않았다면,
	    			continue;
	    		if(!filename.endsWith(".png") && !filename.endsWith(".jpg")) {
	    			// 사진형식의 파일이 아니면 삭제
	    			File file = new File(directory + filerealname);
	    			file.delete();
	    			System.out.println("업로드할 수 없는 확장자입니다.");
	    		
	    		} else {
	    			FileDto dto = new FileDto();
	    			dto.setFilename(filename);
	    			dto.setFilerealname(filerealname);
	    			biz.insertFile(dto);
	    			
	    			System.out.println("파일명: " + filename);
	    			System.out.println("실제 파일명: " + filerealname);
	    		}
	    	}
	    } // end of command
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
