package com.petp.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petp.biz.BoardBiz;
import com.petp.biz.BoardBizImpl;
import com.petp.dto.FileDto;

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
	    System.out.println("command: " + command);
	    
	    BoardBiz biz = new BoardBizImpl();
	    
	    if(command.equals("boardmain")) {
	    	dispatch("board_main.jsp", request, response);
	    
	    } else if(command.equals("fileupload")) {
	    	
	    	ServletContext application = getServletContext();
	    	FileDto dto = (FileDto)application.getAttribute("dto");
	    	
	    	System.out.println("dto 요놈: " + dto.getFilename() + dto.getFilerealname());
	    	biz.insertFile(dto);
	    	dispatch("board_add.jsp", request, response);
	    }
	}
    
    private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
