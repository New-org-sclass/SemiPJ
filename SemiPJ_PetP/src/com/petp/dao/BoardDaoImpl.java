package com.petp.dao;

import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sound.midi.Soundbank;

import com.petp.dto.BoardDto;

import static common.JDBCTemplate.*;

public class BoardDaoImpl implements BoardDao{

	@Override
	public List<BoardDto> selectAll() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BoardDto> res = new ArrayList<BoardDto>();
		
		try {
			pstm = con.prepareStatement(selectAllSql);
			System.out.println("03. query 준비: " + selectAllSql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
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
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}

	
	@Override
	public BoardDto selectOne(int board_no) {
		return null;
	}

	
	@Override
	public int insert(BoardDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(insertSql);
			pstm.setString(1, dto.getBoard_content());
			System.out.println("03. query 준비: " +  insertSql);
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
			
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		
		
		return res;
	}

	
	@Override
	public int update(BoardDto dto) {
		return 0;
	}

	
	@Override
	public int delete(int board_no) {
		return 0;
	}


	@Override
	public int insertAnswer(BoardDto dto) {
		
		return 0;
	}

	@Override
	public int updateAnswer(int group_no, int group_sq) {
		return 0;
	}
	
	
}
