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
	    session.setAttribute("cload1", 0);	//news에서 쓰는 것 
	    session.setAttribute("mylocload1", 0);	//map에서 쓰는 것
	    
	    
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
	    	
	    	System.out.println("확인: " + email + id + password);
	    	
	    	MemberDto member = biz.login(email, id, password);
	    	
	    	System.out.println("memname: " + member.getMemname());
	    	System.out.println("memid: " + member.getMemid());
	    	
	    	if(member.getMemid() == null) {

	    		jsResponse("Failed to Login :(", "home_login.jsp", response);
	    	
	    	} else {
	    		session.setAttribute("memberDto", member);
	    		dispatch("MemberServlet.do?command=mypage", request, response);
	    	}
	    
	    } else if(command.equals("logout")) {
	    	session.invalidate();
	    	jsResponse("로그아웃 되었습니다.", "home_login.jsp", response);
	    
	    } else if(command.equals("mypage")) {
	    	
		    MemberDto member = (MemberDto)request.getSession().getAttribute("memberDto");
	    	System.out.println("board_writer: " + member.getMemid());
	    	
	    	List<BoardDto> list = brdbiz.selectUserBoard(member.getMemid(), 1);
	    	
	    	System.out.println("list_size" + list.size());
	    	
	    	request.setAttribute("list", list);
	    	
	    	dispatch("profile_main.jsp", request, response);
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
