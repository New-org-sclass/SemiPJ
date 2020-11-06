package com.petp.biz;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;

import com.petp.dao.BoardDao;
import com.petp.dao.BoardDaoImpl;
import com.petp.dto.BoardDto;
import com.petp.dto.FileDto;

public class BoardBizImpl implements BoardBiz{
	private BoardDao dao = new BoardDaoImpl();
	
	@Override
	public int insertFile(FileDto dto) {
		System.out.println("[BoardBizImpl]");
		
		Connection con = getConnection();
		int res = dao.FileUpload(con, dto);
		
		if(res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return res;
	}

	@Override
	public int insertBoard(BoardDto dto) {
		System.out.println("[BoardBizImpl]");
		
		Connection con = getConnection();
		int res = dao.BoardUpload(con, dto);
		
		if(res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return res;
	}

	@Override
	public List<BoardDto> selectBoardList() {
		System.out.println("[BoardBizImpl]");
		
		Connection con = getConnection();
		List<BoardDto> res = dao.BoardList(con);
		
		close(con);
		
		return res;
	}

}
