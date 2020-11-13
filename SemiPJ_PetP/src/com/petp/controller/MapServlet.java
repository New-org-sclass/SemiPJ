package com.petp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.ProcessBuilder.Redirect;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.apache.catalina.Session;

import com.petp.biz.MapBiz;
import com.petp.biz.MapBizImpl;
import com.petp.dto.MapDto;

@WebServlet("/MapServlet")
// MapServlet.do
public class MapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[Map command : " + command + "]");
		
		MapBiz biz = new MapBizImpl();
		
		if(command.equals("######")) {
			response.sendRedirect("board_main.jsp");
			
		}else if(command.equals("list")) {
			List<MapDto> list = biz.selectAll();
			request.setAttribute("list", list);
			
			dispatch("map_main.jsp", request, response);
			
		}else if(command.equals("selectlist")) {
			
			
			int walk_no = Integer.parseInt(request.getParameter("seq"));
			
			MapDto dto = biz.selectOne(walk_no);
			
			String loca = dto.getWalk_loc();
			System.out.println("dto.getWalk_loc() : " + loca);
			
			
			String loca_res = loca.substring(1, loca.length()-1);
			System.out.println("loca_res : " + loca_res);
			
			
			String[] latlon = loca_res.split("\\),\\(") ; 
			System.out.println("latlon - split: " + latlon);
			
			
			HttpSession session = request.getSession();
			session.setAttribute("latlon", latlon);
			
			
			//request.setAttribute("latlon", loca_res);
			
			dispatch("map_main.jsp", request, response);
			
			
			//jsResponse("MapServlet.do?command=list", response);
			
		}else if(command.equals("insertlist")) {
			String name = request.getParameter("name");
			String path = request.getParameter("path");
			String dong = request.getParameter("dong");
			System.out.println("name : " + name);
			System.out.println("path : " + path);
			System.out.println("dong : " + dong);
			MapDto dto = new MapDto(name, path, dong);
			
			boolean res = biz.insert(dto);
			if(res) {
				dispatch("MapServlet.do?command=list", request, response);
			}else {
				jsResponse("입력되지 않았습니다. 다시 입력해주세요.","MapServlet.do?command=list", response);
			}
			}	
	}


	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
		
	}
	
	private void jsResponse(String ale,String url, HttpServletResponse response) throws IOException {
		String s = "<script type='text/javascript'>"
					+"location.href='"+url+"';"
					+"alert('"+ale+"');"
					+"</script>";
		PrintWriter out = response.getWriter();
		out.print(s);
}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
