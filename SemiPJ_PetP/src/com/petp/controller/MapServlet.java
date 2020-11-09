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

import com.petp.biz.MapBiz;
import com.petp.biz.MapBizImpl;
import com.petp.dto.MapDto;

@WebServlet("/MapServlet")
public class MapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[Map) command : " + command + "]");
		
		MapBiz biz = new MapBizImpl();
		
		if(command.equals("mapinsert")) {
			response.sendRedirect("board_main.jsp");
			
		}else if(command.equals("#######")) {
			List<MapDto> list = biz.selectAll();
			request.setAttribute("list", list);
//			dispatch("board_detail.jsp", request, response);
			
			response.sendRedirect("board_detail.jsp");

			
		} else if(command.equals("mapdelete")) {			
			String walk_no = request.getParameter("walk_no");
			int walk_no2 = Integer.parseInt(walk_no);
			
			MapDto dto = new MapDto(walk_no2);

			int res = biz.insert(dto);
			
			if(res>0) {
				jsResponse("댓글 작성 성공","BoardServlet.do?command=list",response);
			}else {
				jsResponse("댓글 작성 실패","BoardServlet.do?command=detail",response);
			}
		}
	}


	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
		
	}
	
	private void jsResponse(String message, String url, HttpServletResponse response) throws IOException {
		String s = "<script type='text/javascript'>"
					+"alert('"+message+"');"
					+"location.href='"+url+"';"
					+"</script>";
		PrintWriter out = response.getWriter();
		out.print(s);
}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
