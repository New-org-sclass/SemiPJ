package com.petp.biz;

import java.util.List;

import com.petp.dto.BoardDto;
import com.petp.dto.FileDto;

public interface BoardBiz {
	public int insertFile(FileDto dto);
	public int insertBoard(BoardDto dto);
	public List<BoardDto> selectBoardList();
}
