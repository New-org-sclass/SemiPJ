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
import javax.websocket.Session;

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
	    
	    HttpSession session = request.getSession();
	    
	    if(command.equals("login")){
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDto dto = dao.login(id, pw);
			
			if(dto.getMemid() != null){
				session.setAttribute("dto", dto);
				
				request.setAttribute("dto", dto);
				//session에 담긴 객체가 살아있는 시간 기본 30분
				//session.setMaxInactiveInterval(60*60);

				dispatch("profile_main.jsp", request, response);
			}else {
				request.setAttribute("name", dto.getMemname());
				request.setAttribute("msg", "로그인 실패");
				jsResponse("로그인 실패", "home_login.jsp", response);
			}
				
		}else if(command.equals("list")) {
			dispatch("home_login.jsp", request, response);
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
				jsResponse("회원가입 성공","Member.do?command=list",response);
			}else {
				jsResponse("회원가입 실패","Member.do?command=regist",response);
			}
			
		}else if(command.equals("idChk")) {
			String memid = request.getParameter("id");
			String res = dao.idChk(memid);
			
			boolean idnotused = true;
			
			if(res != null){
				idnotused = false;
			}
			
			response.sendRedirect("idchk.jsp?idnotused="+idnotused);
		}else if(command.equals("regist")) {
			dispatch("home_register.jsp", request, response);
		}else if(command.equals("updateForm")) {
			int memno = Integer.parseInt(request.getParameter("memno"));
			MemberDto dto = dao.selectOne(memno);
		
			request.setAttribute("dto", dto);
			dispatch("profile_modify.jsp", request, response);
		}else if(command.equals("update")) {
			String mememail = request.getParameter("email");
			String mempw = request.getParameter("pw");
			
			MemberDto dto = (MemberDto) session.getAttribute("dto");
			System.out.println(dto.getMemno());
			dto.setMememail(mememail);
			dto.setMempw(mempw);
			
			boolean res = dao.update(dto);
			request.setAttribute("dto", dto);
			
			if(res==true) {
				jsResponse("수정 되었습니다.", "home_login.jsp", response);
			}else {
				request.setAttribute("dto", dto);
				jsResponse("수정 실패.", "profile_modify.jsp", response);
			}
			
		} else if(command.equals("logout")) {
	    	session.invalidate();
	    	jsResponse("로그아웃 되었습니다.", "home_login.jsp", response);
	    
	    }else if(command.equals("delete")) {
	    	
	    	int memno=Integer.parseInt(request.getParameter("memno"));
	    	
			boolean res = dao.delete(memno);
			if(res==true) {
				session.invalidate();
				jsResponse("삭제 되었습니다.", "home_login.jsp", response);
			}else {
				jsResponse("감사합니다.", "profile_modify.jsp", response);
			}
	    }else if(command.equals("delForm")) {
	    	int memno = Integer.parseInt(request.getParameter("memno"));
			MemberDto dto = dao.selectOne(memno);
	    	
	    	request.setAttribute("dto", dto);
	    	dispatch("delete.jsp", request, response);
	    
	    }else if(command.equals("profile")) {
	    	String img = "resources/images/pro"+request.getParameter("num")+".jpg";
	    	int memno = Integer.parseInt(request.getParameter("memno"));
	    	System.out.println(memno);
			boolean res = dao.setPro(memno, img);
			
			MemberDto dto = (MemberDto) session.getAttribute("dto");
			dto.setMemno(memno);
			dto.setMempic(img);
			request.setAttribute("memno", memno);
			
			if(res==true) {
				jsResponse("수정 되었습니다.", "Member.do?command=updateForm&memno="+memno, response);
			}else {
				jsResponse("수정 실패.", "profile_modify.jsp", response);
			}
	    
	    }else if(command.equals("movepro")) {
	    	int memno = Integer.parseInt(request.getParameter("memno"));
			MemberDto dto = dao.selectOne(memno);
	    	
	    	request.setAttribute("dto", dto);
	    	dispatch("profile.jsp", request, response);
	    
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
