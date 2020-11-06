package com.petp.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petp.dto.BoardDto;
import com.petp.dto.FileDto;
import com.sun.org.apache.bcel.internal.generic.AALOAD;

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
			System.out.println("[dto] " + "filename: " + dto.getFilename() + ", filerealname: " + dto.getFilerealname());

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

	@Override
	public int BoardUpload(Connection con, BoardDto dto) {
		System.out.println("[BoardDaoImpl]");

		PreparedStatement pstm = null;
		int res = 0;

		try {
			pstm = con.prepareStatement(insertBoardSql);
			System.out.println("03. query 준비: " + insertBoardSql);

			pstm.setInt(1, dto.getGroup_sq());
			pstm.setInt(2, dto.getBoard_tab());
			pstm.setString(3, dto.getBoard_writer());
			pstm.setString(4, dto.getBoard_content());
			pstm.setString(5, dto.getBoard_hashtag());
			pstm.setString(6, dto.getFile_group());

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

	@Override
	public List<BoardDto> BoardList(Connection con) {
		System.out.println("[BoardDaoImpl]");

		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BoardDto> res = new ArrayList<BoardDto>();
		
		try {
			pstm = con.prepareStatement(selectBoardSql);
			System.out.println("03.query 준비 : " + selectBoardSql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setBoard_no(rs.getInt(1));
				dto.setGroup_no(rs.getInt(2));
				dto.setGroup_sq(rs.getInt(3));
				dto.setBoard_tab(rs.getInt(4));
				dto.setBoard_writer(rs.getString(5));
				dto.setBoard_content(rs.getString(6));
				dto.setBoard_hashtag(rs.getString(7));
				dto.setFile_group(rs.getString(8));
				dto.setBoard_regdate(rs.getDate(9));
				
				res.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}

}
