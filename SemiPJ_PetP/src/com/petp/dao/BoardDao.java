package com.petp.dao;

import java.util.List;

import com.petp.dto.BoardDto;

public interface BoardDao {
	
	String selectAllSql = " SELECT * FROM BOARD ORDER BY GROUP_NO, GROUP_SQ ";
	String selectOneSql = " SELECT * FROM BOARD WHERE BOARD_NO=? ";
	String insertSql = " INSERT INTO BOARD VALUES(BOARDNOSQ.NEXTVAL,GROUPNOSQ.NEXTVAL,1,0,NULL,?,NULL,NULL,SYSDATE) ";
	String updateSql = " UPDATE BOARD SET CONTENT=? WHERE BOARD_NO=? ";
	String deleteSql = " DELETE FROM BOARD WHERE BOARD_NO=? ";
	
	String insertAnswerSql = " INSERT INTO BOARD VALUES(BOARDNOSQ.NEXTVAL,?,?,?,?,?,NULL,NULL,SYSDATE) ";
	String updateAnswerSql = " UPDATE BOARD SET GROUP_SQ = GROUP_SQ+1 WHERE GROUP_NO=? AND GROUP_SQ>? ";

	
	//추상메소드
	public List<BoardDto> selectAll(); 
	public BoardDto selectOne(int board_no);
	public int insert(BoardDto dto);
	public int update(BoardDto dto);
	public int delete(int board_no);
		
	public int insertAnswer(BoardDto dto);
	public int updateAnswer(int group_no, int group_sq);
	
	
	
	
	
	
	
}
