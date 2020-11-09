package com.petp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petp.biz.BoardBiz;
import com.petp.biz.BoardBizImpl;
import com.petp.dto.BoardDto;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[command : "+command+"]");
		
		BoardBiz biz = new BoardBizImpl();
		
		if(command.equals("main")) {
			response.sendRedirect("board_main.jsp");
			
		} else if(command.equals("detail")) {
			List<BoardDto> list = biz.selectAll();
			request.setAttribute("list", list);
//			dispatch("board_detail.jsp", request, response);			
			
			
			response.sendRedirect("board_detail.jsp");
			
		} else if(command.equals("boardwrite")) {			
			String board_content = request.getParameter("board_content");
			
			BoardDto dto = new BoardDto(board_content);

			int res = biz.insert(dto);
			
			if(res>0) {
				jsResponse("댓글 작성 성공","BoardServlet.do?command=list",response);
			}else {
				jsResponse("댓글 작성 실패","BoardServlet.do?command=detail",response);
			}
		}
		
		
		
		
		
	}

	private void jsResponse(String message, String url, HttpServletResponse response) throws IOException {
		String s = "<script type='text/javascript'>"
					+"alert('"+message+"');"
					+"location.href='"+url+"';"
					+"</script>";
		PrintWriter out = response.getWriter();
		out.print(s);
}

	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
