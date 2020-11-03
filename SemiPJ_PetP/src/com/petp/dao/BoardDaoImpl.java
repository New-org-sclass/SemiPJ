package com.petp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.petp.dto.FileDto;
import static common.JDBCTemplate.*;

public class BoardDaoImpl implements BoardDao {

	@Override
	public int FileUpload(Connection con, FileDto dto) {
		System.out.println("[BoardDaoImpl]");
		
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(insertFileSql);
			System.out.println("03. query 준비: " + insertFileSql);
			// INSERT INTO BPIC VALUES(BPICNO.NEXTVAL, GROUPNO.NEXTVAL, ?, ?)
			System.out.println("dto 요놈: " + dto.getFilename() + dto.getFilerealname());
			pstm.setString(1, dto.getFilename());
			pstm.setString(2, dto.getFilerealname());
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			// 성공이면 res = 1
		
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			System.out.println("05. db 종료\n");
		}
	
		return res;
	}

}
