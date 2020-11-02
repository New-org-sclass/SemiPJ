package com.petp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FileDao {
	private Connection con;
	
	public FileDao() {
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "KH";
			String pw = "KH";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int upload(String filename, String filerealname) {
		
		String sql = " INSERT INTO BPIC VALUES(BPICNO.NEXTVAL, GROUPNO.NEXTVAL, ?, ?) ";
		try {
			PreparedStatement pstm = con.prepareStatement(sql);
			pstm.setString(1, filename);
			pstm.setString(2, filerealname);
			
			return pstm.executeUpdate(); // 성공이면 1 반환 
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1; // 실패 -1
	}
}
