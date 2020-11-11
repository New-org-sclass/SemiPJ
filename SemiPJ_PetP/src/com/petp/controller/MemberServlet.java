package com.petp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petp.biz.MemberBiz;
import com.petp.biz.MemberBizImpl;
import com.petp.dao.MemberDao;
import com.petp.dao.MemberDaoImpl;
import com.petp.dto.MemberDto;

@WebServlet("/Member.do")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    
	    String command = request.getParameter("command");
	    System.out.println("\n[Member]");
	    System.out.println("command: " + command);
	    
	    MemberDao dao = new MemberDaoImpl();
	    MemberBiz biz = new MemberBizImpl();
	    
	    if(command.equals("login")){
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDto dto = dao.login(id, pw);
			
			if(dto.getMemid() != null){
				HttpSession session = request.getSession();
			
				session.setAttribute("dto", dto);
				
				//session에 담긴 객체가 살아있는 시간 기본 30분
				//session.setMaxInactiveInterval(60*60);
				request.setAttribute("name", dto.getMemname());
				dispatch("board_main.jsp", request, response);
			}else {
				request.setAttribute("name", dto.getMemname());
				request.setAttribute("msg", "로그인 실패");
				dispatch("login.jsp", request, response);
			}
				
		}else if(command.equals("list")) {
			dispatch("login.jsp", request, response);
		}else if(command.equals("insert")) {
			String id=request.getParameter("memid");
			String pw=request.getParameter("mempw");
			String name=request.getParameter("memname");
			String email=request.getParameter("mememail");
			String pro=request.getParameter("mempro");
			String enabled="Y";
			
			MemberDto dto = new MemberDto(id,pw,name,email,pro,enabled);
			boolean res = biz.insert(dto);
			if(res) {
				jsResponse("글 작성 성공","member.do?command=list",response);
			}else {
				jsResponse("글 작성 실패","member.do?command=regist",response);
			}
			
		}else if(command.equals("insert")) {
			String myid = request.getParameter("id");
			String res = dao.idChk(myid);
			
			boolean idnotused = true;
			
			if(res != null){
				idnotused = false;
			}
			
			response.sendRedirect("idchk.jsp?idnotused="+idnotused);
		}
	    
	}
	
	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch=request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {
		String s = "<script type='text/javascript'>"
					+"alert('"+msg+"');"
					+"location.href='"+url+"';"
					+"</script>";
		PrintWriter out = response.getWriter();
		out.print(s);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
