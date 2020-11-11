package com.petp.biz;

import java.util.List;
import com.petp.dto.BoardDto;

public interface BoardBiz {
	
	/* board mian & board add */
	public int insertBoard(BoardDto dto);
	public List<BoardDto> selectBoardList();
	public List<BoardDto> selectBoardList(int page);
	public List<BoardDto> selectBoardList(String search, int page); // 검색한 게시글
	
	/* user board */
	public List<BoardDto> selectUserBoard(String memName, int page);
	
	/* board count */ 
	public int getBoardCount();
	public int getBoardCount(String search); // 페이징 없이 검색된 게시물 수

	/* board detail */
	public BoardDto getBoard(int groupNo);
	public List<BoardDto> getComments(int groupNo);
	public int insertComment(BoardDto dto);
	
	/* common */
	public boolean deleteBoard(int boardNo);
}
