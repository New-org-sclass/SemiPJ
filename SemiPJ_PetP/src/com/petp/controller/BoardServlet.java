package com.petp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.petp.biz.BoardBiz;
import com.petp.biz.BoardBizImpl;
import com.petp.dto.BoardDto;

@MultipartConfig
// servlet 클래스에서 request를 javax.servlet.http.Part 타입으로 받을 수 있도록 어노테이션 추가
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final int groupsq = 1; 
	// 게시글: 1, 댓글: 2, 대댓글: 3 ...
	private final int boardtab = 0;
	// 게시글, 댓글: 0, 대댓글: 1, 대대댓글: 2...
       
    public BoardServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    
	    String command = request.getParameter("command");
	    System.out.println("\n[BoardServlet]");
	    System.out.println("command: " + command);
	    
	    BoardBiz biz = new BoardBizImpl();
	    BoardDto dto = new BoardDto();
	    
	    if(command.equals("boardmain")) {
	    	
		    String search = request.getParameter("search");
		    String page = request.getParameter("page");
		    
		    String searchDefault = ""; // 검색어가 없는 경우 기본값
		    if(search != null) { // 검색어가 있는 경우
		    	searchDefault = search;
		    }
		    
		    int pageDefault = 1; // 페이지 선택이 없는 경우 기본값
		    if(page != null) { // 페이지를 선택한 경우
		    	pageDefault = Integer.parseInt(page);
		    }

	    	List<BoardDto> list = biz.selectBoardList(searchDefault, pageDefault); 
	    	int count = biz.getBoardCount(searchDefault);
	    	
	    	request.setAttribute("list", list);
	    	request.setAttribute("count", count);
	    	
	    	dispatch("board_main.jsp", request, response);
	    
	    } else if(command.equals("boardadd")) {
	    	
	    	// context, hashtag, username 받아오기
	    	String content = request.getParameter("content");
	    	String hashtag = request.getParameter("hashtag");
	    	int memno = Integer.parseInt(request.getParameter("memno"));
	    	
	    	System.out.println("memno : " + memno);
	    	
	    	// file 받아오기
	    	Part part = request.getPart("upfile");
	    	
	    	ServletConfig conf = this.getServletConfig();
	    	ServletContext application = conf.getServletContext();
			
			String filePath = "/resources/board_uploadimg/";
	    	String directory = application.getRealPath(filePath);

	    	
	    	System.out.println("directory: " + directory);
	    	
	    	String filename = UUID.randomUUID().toString().replace("-", "");
	    	String ext = ".png";
	    	String filefullname = filename + ext;
	    	
	    	part.write(directory + filefullname);
  
	        // db 에 저장
	        dto = new BoardDto(groupsq, boardtab, memno, content, hashtag, filefullname);

	        System.out.println("dto.getMemno : " + dto.getMem_no());
	        
	        int res = biz.insertBoard(dto);
	        if (res>0) {
	        	jsResponse("You have finished uploading your post :)", "BoardServlet.do?command=boardmain", response);
	        } else {
	        	jsResponse("Failed to upload post :(", "board_add.jsp", response);
	        }
	        
	    } else if(command.equals("userBoard")) {
	    	String page = request.getParameter("page");
		    
		    int pageDefault = 1; // 페이지 선택이 없는 경우 기본값
		    if(page != null) { // 페이지를 선택한 경우
		    	pageDefault = Integer.parseInt(page);
		    }
	    	
	    	String memName = request.getParameter("board_writer");
	    	System.out.println("board_writer: " + memName);
	    	
	    	List<BoardDto> list = biz.selectUserBoard(memName, pageDefault);
	    	
	    	request.setAttribute("list", list);
	    	request.setAttribute("board_writer", memName);
	    	
	    	dispatch("board_user.jsp", request, response);
	    	
	    } else if(command.equals("detail")) {
	    	
	    	int groupNo = Integer.parseInt(request.getParameter("groupNo"));
	    	System.out.println("groupNo: " + request.getParameter("groupNo"));

	    	// 본 게시글
	    	BoardDto board = biz.getBoard(groupNo);
	    	// 본 게시글의 댓글
	    	List<BoardDto> list = biz.getComments(groupNo);
	    	
	    	request.setAttribute("board", board);
	    	request.setAttribute("list", list);

	    	request.setAttribute("groupNo", groupNo);
			dispatch("board_detail.jsp", request, response);
			
	    } else if(command.equals("addComment")) {	
	    	// boardNo, memNo, Comment
	    	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	    	int memNo = Integer.parseInt(request.getParameter("memNo"));
	    	String comment = request.getParameter("comment");
	    	int groupNo = Integer.parseInt(request.getParameter("groupNo"));
	    	
	    	// dto 저장
	        dto = new BoardDto(boardNo, memNo, comment);
	    	
	    	int res = biz.insertComment(dto);
	    	if (res>0) {
	        	jsResponse("You have completed your comment :)", "BoardServlet.do?command=detail&groupNo=" + groupNo, response);
	        } else {
	        	jsResponse("Failed to write a comment :(", "BoardServlet.do?command=detail&groupNo=" + groupNo, response);
	        }
	    	
		} else if(command.equals("delComment")) {	
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			System.out.println(boardNo);
			int groupNo = Integer.parseInt(request.getParameter("groupNo"));
			System.out.println(groupNo);
			
			boolean result = biz.deleteBoard(boardNo);
			
			if (result) {
	        	jsResponse("댓글 삭제 성공", "BoardServlet.do?command=detail&groupNo=" + groupNo, response);
	        } else {
	        	jsResponse("댓글 삭제 실패", "BoardServlet.do?command=detail&groupNo=" + groupNo, response);
	        }

 			response.setContentType("text/html;charset=utf-8");
		}
	}

	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
		
	}
    
    private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {
       
       String s = "<script type='text/javascript'>"
                + "alert('"+ msg +"');"
                + "location.href='" + url + "';"
              + "</script>";
       
       PrintWriter out = response.getWriter();
       out.print(s);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
