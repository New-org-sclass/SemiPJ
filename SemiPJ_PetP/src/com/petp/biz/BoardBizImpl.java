package com.petp.biz;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.petp.dao.BoardDao;
import com.petp.dao.BoardDaoImpl;
import com.petp.dto.BoardDto;

public class BoardBizImpl implements BoardBiz{
	private BoardDao dao = new BoardDaoImpl();

	@Override
	public int insertBoard(BoardDto dto) {
		System.out.println("[BoardBizImpl]");
		
		Connection con = getConnection();
		int res = dao.boardUpload(con, dto);
		
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
		return selectBoardList("", 1); // 검색어 없는 1페이지 반환
	}

	@Override
	public List<BoardDto> selectBoardList(int page) {
		return selectBoardList("", page); // 검색어 없이 페이지만 반환
	}

	@Override
	public List<BoardDto> selectBoardList(String search, int page) {
		System.out.println("[BoardBizImpl : selectBoardList]");
		
		Connection con = getConnection();
		List<BoardDto> res = dao.boardList(con, search, page);
		
		close(con);
		return res;
	}

	@Override
	public int getBoardCount() {
		return getBoardCount(""); // 검색어 없음
	}

	@Override
	public int getBoardCount(String search) {
		System.out.println("[BoardBizImpl : getBoardCount]");
		
		Connection con = getConnection();
		int res = dao.boardCount(con, search);
		
		if(res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return res;
	}

	@Override
	public List<BoardDto> selectUserBoard(String memName, int page) {
		System.out.println("[BoardBizImpl : selectUserBoard]");
		
		Connection con = getConnection();
		List<BoardDto> res = dao.userBoardList(con, memName, page); 
		
		close(con);
		return res;
	}

	@Override
	public int insertComment(BoardDto dto) {
		System.out.println("[BoardBizImpl : insertComment]");
		
		Connection con = getConnection();
		int res = dao.addComment(con, dto);
		
		if(res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return res;
	}

	@Override
	public BoardDto getBoard(int groupNo) {
		System.out.println("[BoardBizImpl : getBoard]");
		Connection con = getConnection();

		BoardDto board = dao.getBoard(con, groupNo);
		
		close(con);
		return board;
	}

	@Override
	public List<BoardDto> getComments(int groupNo) {
		System.out.println("[BoardBizImpl : getComments]");
		Connection con = getConnection();
		
		List<BoardDto> res = dao.getComments(con, groupNo); 
		
		close(con);
		return res;
	}

	@Override
	public boolean deleteComment(int boardNo) {
		System.out.println("[BoardBizImpl : deleteComment]");
		Connection con = getConnection();
		
		boolean res = dao.deleteComment(con, boardNo); 
		
		close(con);
		return res ;
	}

	@Override
	public boolean deleteBoard(int groupNo) {
		System.out.println("[BoardBizImpl : deleteBoard]");
		Connection con = getConnection();
		
		boolean res = dao.deleteBoard(con, groupNo); 
		
		close(con);
		return res ;
	}

}
