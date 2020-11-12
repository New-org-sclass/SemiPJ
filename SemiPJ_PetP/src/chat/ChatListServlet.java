package chat;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String listType = request.getParameter("listType");
        if(listType == null || listType.equals("")) {
        	response.getWriter().write(""); //공백이면 공백
        }else if(listType.equals("today")) {
        	response.getWriter().write(getToday());   //디비내용있음 불러오기
        }else if(listType.equals("ten")) {
        	response.getWriter().write(getTen());     //디비안에 내용10개씩 불러오기
        }else {
        	try {
        		Integer.parseInt(listType);
        		response.getWriter().write(getID(listType));
        	} catch (Exception e) {
        		 response.getWriter().write("");
        }
        }
	}
   
	 public String getToday() {
		 StringBuffer result = new StringBuffer("");
		 result.append("{\"result\":[");
		 ChatDAO chatDAO = new ChatDAO();
		 ArrayList<Chat> chatList = chatDAO.getChatList();
		 System.out.println(chatList.get(0).getRegdate());
	     for(int i=0; i < chatList.size(); i++) {        
	    	 result.append("[{\"value\":\"" + chatList.get(i).getChatName() + "\"},");
	    	 result.append("{\"value\":\"" + chatList.get(i).getChatContent() + "\"},");
	    	 result.append("{\"value\":\"" + chatList.get(i).getRegdate() + "\"}]");
	    	 if(i != chatList.size() -1) result.append(","); //i가 마지막이아닌경우
	     }
	     
	     result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getSeq() + "\"}"); //가장마지막 채팅가져오기
	     return result.toString();
	     
	 }
	 
	 public String getTen() {
		 StringBuffer result = new StringBuffer("");
		 result.append("{\"result\":[");
		 ChatDAO chatDAO = new ChatDAO();
		 ArrayList<Chat> chatList = chatDAO.getChatListByRecent(10);   //10개까지만 가져오기
		 System.out.println(chatList.get(0).getRegdate());
	     for(int i=0; i < chatList.size(); i++) {        
	    	 result.append("[{\"value\":\"" + chatList.get(i).getChatName() + "\"},");
	    	 result.append("{\"value\":\"" + chatList.get(i).getChatContent() + "\"},");
	    	 result.append("{\"value\":\"" + chatList.get(i).getRegdate() + "\"}]");
	    	 if(i != chatList.size() -1) result.append(","); //i가 마지막이아닌경우
	     }
	     
	     result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getSeq() + "\"}");
	     return result.toString();
	     
	 }
	 
	 public String getID(String seq) {
		 StringBuffer result = new StringBuffer("");
		 result.append("{\"result\":[");
		 ChatDAO chatDAO = new ChatDAO();
		 ArrayList<Chat> chatList = chatDAO.getChatListByRecent(seq);
		 System.out.println(chatList.get(0).getRegdate());
	     for(int i=0; i < chatList.size(); i++) {        
	    	 result.append("[{\"value\":\"" + chatList.get(i).getChatName() + "\"},");
	    	 result.append("{\"value\":\"" + chatList.get(i).getChatContent() + "\"},");
	    	 result.append("{\"value\":\"" + chatList.get(i).getRegdate() + "\"}]");
	    	 if(i != chatList.size() -1) result.append(","); //i가 마지막이아닌경우
	     }
	     
	     result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getSeq() + "\"}");
	     return result.toString();
	     
	 }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
