package com.petp.biz;


import com.petp.dto.FileDto;

import java.util.List;

import com.petp.dto.BoardDto;

public interface BoardBiz {

	public List<BoardDto> selectAll(); 
	public BoardDto selectOne(int board_no);
	public int insert(BoardDto dto);
	public int update(BoardDto dto);
	public int delete(int board_no);
	
	public int insertAnswer(BoardDto dto);
	public int updateAnswer(int group_no, int group_sq);
	
	
}
