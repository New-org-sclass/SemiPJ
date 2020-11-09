package com.petp.dao;

import java.sql.Connection;
import java.util.List;

import com.petp.dto.BoardDto;


public interface BoardDao {
	
	public String insertFileSql = " INSERT INTO BPIC VALUES(BPICNO.NEXTVAL, ?, ?) ";
	public String insertBoardSql = " INSERT INTO BOARD VALUES(BOARDNOSQ.NEXTVAL, GROUPNOSQ.NEXTVAL, ?, ?, "
									+ " (SELECT MEM_NAME FROM MEMBER WHERE MEM_NO=?), "
									+ " ?, ?, ?, SYSDATE) ";
	public String selectBoardSql = 
			" SELECT * FROM "
			+ " (SELECT ROWNUM AS RNUM, BRD.* "
			+ " FROM (SELECT * FROM BOARD WHERE BOARD_HASHTAG LIKE ? ORDER BY BOARD_REGDATE) BRD) "
			+ " WHERE RNUM BETWEEN ? AND ? ";
	
	public String selectBoardCntSql = 
			" SELECT * FROM "
			+ " (SELECT ROWNUM AS RNUM, BRD.* "
			+ " FROM (SELECT * FROM BOARD WHERE BOARD_HASHTAG LIKE ? ORDER BY BOARD_REGDATE) BRD) ";
	
	public String selectUserBoardSql = 
			"SELECT *" + 
			"FROM BOARD" + 
			"WHERE BOARD_WRITER = ?";
	
	
	public int boardUpload(Connection con, BoardDto dto);
	public List<BoardDto> boardList(Connection con, String search, int page);
	public int boardCount(Connection con, String search);
	public List<BoardDto> userBoardList(Connection con, String memName);
}
