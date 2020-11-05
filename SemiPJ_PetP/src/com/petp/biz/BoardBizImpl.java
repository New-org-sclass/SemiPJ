package com.petp.biz;

import java.util.List;

import com.petp.dao.BoardDao;
import com.petp.dao.BoardDaoImpl;
import com.petp.dto.BoardDto;

public class BoardBizImpl implements BoardBiz{
	private BoardDao dao = new BoardDaoImpl();

	@Override
	public List<BoardDto> selectAll() {
		return dao.selectAll();
	}

	@Override
	public BoardDto selectOne(int board_no) {
		return dao.selectOne(board_no);
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