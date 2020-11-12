package chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.JDBCTemplate;

public class ChatDAO extends JDBCTemplate{      //현재시각에맞춰서 메세지
    public ArrayList<Chat> getChatList() {   
    	Connection con = getConnection();
    	PreparedStatement pstm = null;
        ResultSet rs = null;
        ArrayList<Chat> chatList = new ArrayList<Chat>();
        
        String SQL = "SELECT SEQ, CHATNAME, CHATCONTENT, TO_CHAR(REGDATE,'HH:MI:ss AM') FROM ANONYMOUSCHAT";    //분 MI로하면 더 정확하게나옴
        
        try {
            pstm = con.prepareStatement(SQL);
            System.out.println("03.query준비" +SQL);
            
            rs = pstm.executeQuery();
            System.out.println("04.query 실행 및 리턴");
            
            while (rs.next()) {
                Chat chat = new Chat();
                chat.setSeq(rs.getInt("SEQ"));
                chat.setChatName(rs.getString("CHATNAME"));
                chat.setChatContent(rs.getString("CHATCONTENT").replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replace(">", "&gt;").replaceAll("\n","<br>"));  //띄워쓰기, 엔터버튼눌러도 잘작동되게
                chat.setRegdate(rs.getString(4));
                
                chatList.add(chat);
            }
        } catch (Exception e) {
        	System.out.println("3/4단계 에러");
            e.printStackTrace();
        } finally {
                    close(rs);
                    close(pstm);
                    close(con);
            System.out.println("05.db종료");
        }
        return chatList;
    }
    public ArrayList<Chat> getChatListByRecent(int number) {   
    	Connection con = getConnection();
    	PreparedStatement pstm = null;
        ResultSet rs = null;
        ArrayList<Chat> chatList = new ArrayList<Chat>();
        
        String SQL = "SELECT SEQ, CHATNAME, CHATCONTENT, TO_CHAR(REGDATE,'HH:MI:ss AM') FROM ANONYMOUSCHAT WHERE SEQ > (SELECT MAX(SEQ) - ? FROM ANONYMOUSCHAT) ORDER BY REGDATE ";  //seq숫자이용해서 불러오기
        
        try {
            pstm = con.prepareStatement(SQL);
            pstm.setInt(1, number);
            System.out.println("03.query준비" +SQL);
            
            rs = pstm.executeQuery();
            System.out.println("04.query 실행 및 리턴");
            
            while (rs.next()) {
                Chat chat = new Chat();
                chat.setSeq(rs.getInt("SEQ"));
                chat.setChatName(rs.getString("CHATNAME"));
                chat.setChatContent(rs.getString("CHATCONTENT").replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replace(">", "&gt;").replaceAll("\n","<br>"));  //띄워쓰기, 엔터버튼눌러도 잘작동되게
                chat.setRegdate(rs.getString(4));
                
                chatList.add(chat);
            }
        } catch (Exception e) {
        	System.out.println("3/4단계 에러");
            e.printStackTrace();
        } finally {
                    close(rs);
                    close(pstm);
                    close(con);
            System.out.println("05.db종료");
        }
        return chatList;
    }
    
    public ArrayList<Chat> getChatListByRecent(String seq) {   
    	Connection con = getConnection();
    	PreparedStatement pstm = null;
        ResultSet rs = null;
        ArrayList<Chat> chatList = new ArrayList<Chat>();
        
        String SQL = "SELECT SEQ, CHATNAME, CHATCONTENT, TO_CHAR(REGDATE,'HH:MI:ss AM') FROM ANONYMOUSCHAT WHERE SEQ > ? ORDER BY REGDATE ";  
        
        try {
            pstm = con.prepareStatement(SQL);
            pstm.setInt(1, Integer.parseInt(seq));
            System.out.println("03.query준비" +SQL);
            
            rs = pstm.executeQuery();
            System.out.println("04.query 실행 및 리턴");
            
            while (rs.next()) {
                Chat chat = new Chat();
                chat.setSeq(rs.getInt("SEQ"));
                chat.setChatName(rs.getString("CHATNAME"));
                chat.setChatContent(rs.getString("CHATCONTENT").replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replace(">", "&gt;").replaceAll("\n","<br>"));  //띄워쓰기, 엔터버튼눌러도 잘작동되게
                chat.setRegdate(rs.getString(4));
                
                chatList.add(chat);
            }
        } catch (Exception e) {
        	System.out.println("3/4단계 에러");
            e.printStackTrace();
        } finally {
                    close(rs);
                    close(pstm);
                    close(con);
            System.out.println("05.db종료");
        }
        return chatList;
    }
    
    public int submit(String chatName, String chatContent) { //상자에 입력가능하게
    	Connection con = getConnection();
        PreparedStatement pstm = null;
        int res =0;
        
        System.out.println(chatName);
        System.out.println(chatContent);
        String SQL = "INSERT INTO ANONYMOUSCHAT VALUES (MYCHAT.NEXTVAL, ?,?, SYSDATE)";
        
        try {
            pstm = con.prepareStatement(SQL);
            pstm.setString(1, chatName);
            pstm.setString(2, chatContent);
            System.out.println("03.query 준비: " + SQL);
            
            res= pstm.executeUpdate();
            System.out.println("04. query 실행 및 리턴");
            
            if(res>0) {
				commit(con);
			}
            
        } catch (Exception e) {
        	System.out.println("3/4단계 에러");
            e.printStackTrace();
        } finally {
                    close(con);
                    close(pstm);
            System.out.println("05.db종료");
        }
        return res;
    }



}


