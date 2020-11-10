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

//	@Override
//	public List<BoardDto> getBoardDetail(int boardNo) {
//		return null;
//	}
	
	/* board_detail */
	@Override
	public List<BoardDto> selectAll() {
		return dao.selectAll();
	}

	@Override
	public List<BoardDto> selectOne(int group_no) {
		System.out.println("[BoardBizImpl : selectOne]");
		
		Connection con = getConnection();
		List<BoardDto> res = dao.selectOne(con, group_no); 
		
		return res;
	}

	@Override
	public int insert(BoardDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(BoardDto dto) {
		return dao.update(dto);
	}

	@Override
	public int delete(int board_no) {
		return dao.delete(board_no);
	}

	@Override
	public int insertAnswer(BoardDto dto) {
		return dao.insertAnswer(dto);
	}

	@Override
	public int updateAnswer(int group_no, int group_sq) {
		return dao.updateAnswer(group_no, group_sq);
	}
}
