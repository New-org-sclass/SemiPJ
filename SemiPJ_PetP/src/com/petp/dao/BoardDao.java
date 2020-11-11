package com.petp.dao;

import java.sql.Connection;
import java.util.List;

import com.petp.dto.BoardDto;

public interface BoardDao {
	
	/* board_main & board_add & board_user */
	public String insertFileSql = " INSERT INTO BPIC VALUES(BPICNO.NEXTVAL, ?, ?) ";
	public String insertBoardSql = " INSERT INTO BOARD VALUES(BOARDNOSQ.NEXTVAL, GROUPNOSQ.NEXTVAL, ?, ?, "
									+ " (SELECT MEM_NAME FROM MEMBER WHERE MEM_NO=?), "
									+ " ?, ?, ?, SYSDATE) ";
	public String selectBoardSql = 
			" SELECT * FROM "
			+ " (SELECT ROWNUM AS RNUM, BRD.* "
			+ " FROM (SELECT * FROM BOARD WHERE BOARD_HASHTAG LIKE ? ORDER BY BOARD_REGDATE DESC) BRD) "
			+ " WHERE RNUM BETWEEN ? AND ? ";
	
	public String selectBoardCntSql = 
			" SELECT * FROM "
			+ " (SELECT ROWNUM AS RNUM, BRD.* "
			+ " FROM (SELECT * FROM BOARD WHERE BOARD_HASHTAG LIKE ? ORDER BY BOARD_REGDATE) BRD) ";
	
	public String selectUserBoardSql = 
			" SELECT * FROM "
			+ " (SELECT ROWNUM AS RNUM, BRD.* "
			+ " FROM (SELECT * FROM BOARD WHERE BOARD_WRITER = ? ORDER BY BOARD_REGDATE DESC) BRD) "
			+ " WHERE RNUM BETWEEN ? AND ? ";
	
	
	public int boardUpload(Connection con, BoardDto dto);
	public List<BoardDto> boardList(Connection con, String search, int page);
	public int boardCount(Connection con, String search);
	public List<BoardDto> userBoardList(Connection con, String memName, int page);
	
	/* board_detail */
	String getBoardSql = " select * from board where group_no=? and group_sq =1 ";
	String getCommentsSql = "select * from board where group_no=? and group_sq !=1";
	
	String insertCommentSql = 
			" INSERT INTO BOARD " + 
			" VALUES(BOARDNOSQ.NEXTVAL," + 
			" (SELECT GROUP_NO FROM BOARD WHERE BOARD_NO=?)," + 
			" (SELECT GROUP_SQ FROM BOARD WHERE BOARD_NO=?)+1," + 
			" (SELECT BOARD_TAB FROM BOARD WHERE BOARD_NO=?), " + 
			" (SELECT MEM_NAME FROM MEMBER WHERE MEM_NO=?), " + 
			" ?, NULL, NULL ,SYSDATE) ";
			// boardNo, memNo, Comment
	
	public BoardDto getBoard(Connection con, int groupNo);
	public List<BoardDto> getComments(Connection con, int groupNo);
	public int addComment(Connection con, BoardDto dto);
}
