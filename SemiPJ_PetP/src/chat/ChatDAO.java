package chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.JDBCTemplate;

public class ChatDAO extends JDBCTemplate{      //현재시각에맞춰서 메세지
    public ArrayList<Chat> getChatList(String regdate) {    //문제점: 여기에 변수넣지 말고 테이블에있는 날짜를 불러와야한다.
    	System.out.println("dao getChatList");
    	Connection con = getConnection();
    	PreparedStatement pstm = null;
        ResultSet rs = null;
        ArrayList<Chat> chatList = new ArrayList<Chat>();
        
        String SQL = "SELECT * FROM ANONYMOUSCHAT ORDER BY SEQ DESC";
        
        try {
            pstm = con.prepareStatement(SQL);
            System.out.println("03.query준비" +SQL);
            
            rs = pstm.executeQuery();
            System.out.println("04.query 실행 및 리턴");
            
            while (rs.next()) {
                Chat chat = new Chat();
                chat.setSeq(rs.getInt(1));
                chat.setChatName(rs.getString("CHATNAME"));
                chat.setChatContent(rs.getString("CHATCONTENT").replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replace(">", "&gt;").replaceAll("\n","<br>"));  //띄워쓰기, 엔터버튼눌러도 잘작동되게
                chat.setRegdate(rs.getDate("REGDATE"));
                
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
    	System.out.println("submit");
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


