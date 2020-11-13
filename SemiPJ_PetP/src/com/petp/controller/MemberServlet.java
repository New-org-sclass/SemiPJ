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
import javax.servlet.http.HttpSession;

import com.petp.biz.BoardBiz;
import com.petp.biz.BoardBizImpl;
import com.petp.biz.MemberBiz;
import com.petp.biz.MemberBizImpl;
import com.petp.dto.BoardDto;
import com.petp.dto.MemberDto;

@WebServlet("/MemberServlet")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    
	    String command = request.getParameter("command");
	    System.out.println("\n[MemberServlet]");
	    System.out.println("command: " + command);
	    
	    MemberBiz biz = new MemberBizImpl();
	    MemberDto dto = new MemberDto();
	    BoardBiz brdbiz = new BoardBizImpl();
	    BoardDto brddto = new BoardDto();
	    HttpSession session = request.getSession();
	    session.setAttribute("cload1", 0);	//news에서 쓰는거
	    
	    if(command.equals("register")) {	
	    	String email = request.getParameter("email");
	    	String id = request.getParameter("id");
	    	String name = request.getParameter("name");
	    	String password = request.getParameter("password");
	    	
	    	dto = new MemberDto(id, name, password, email);
	    	boolean res = biz.insert(dto);
	    	
	    	if(res) {
	    		jsResponse("Welcome to PetP :)", "home_login.jsp", response);
	    	} else {
	    		jsResponse("Failed to Sign up :(", "home_register.jsp", response);
	    	}
	    	
	    } else if(command.equals("login")) {
	    	String email = request.getParameter("email");
	    	String id = request.getParameter("id");
	    	String password = request.getParameter("password");
	    	
	    	dto = new MemberDto(email, id, password);
	    	MemberDto member = biz.login(email, id, password);
	    	
	    	System.out.println("memname: " + member.getMemname());
	    	
	    	if(member != null) {
	    		session.setAttribute("memberDto", member);

	    		//dispatch("BoardServlet.do?command=userBoard&board_writer=" + member.getMemname(), request, response);
	    		dispatch("MemberServlet.do?command=mypage&board_writer=" + member.getMemid(), request, response);
	    	
	    	} else {
	    		dispatch("home_login.jsp", request, response);
	    	}
	    
	    } else if(command.equals("logout")) {
	    	session.invalidate();
	    	PrintWriter out = response.getWriter();
	    	out.println("<script>alert('로그아웃되었습니다');</script>");
	    	response.sendRedirect("home_main.jsp");
	    
	    } else if(command.equals("mypage")) {
	    	String page = request.getParameter("page");
		    
		    int pageDefault = 1; // 페이지 선택이 없는 경우 기본값
		    if(page != null) { // 페이지를 선택한 경우
		    	pageDefault = Integer.parseInt(page);
		    }
	    	
	    	String memName = request.getParameter("board_writer");
	    	System.out.println("board_writer: " + memName);
	    	
	    	List<BoardDto> list = brdbiz.selectUserBoard(memName, pageDefault);
	    	
	    	System.out.println("list_size" + list.size());
	    	
	    	request.setAttribute("list", list);
	    	request.setAttribute("board_writer", memName);
	    	
	    	dispatch("board_user.jsp", request, response);
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
