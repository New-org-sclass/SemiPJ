package com.petp.dao;

import java.sql.Connection;
import java.util.List;

import com.petp.dto.BoardDto;
import com.petp.dto.FileDto;

public interface BoardDao {
	
	public String insertFileSql = " INSERT INTO BPIC VALUES(BPICNO.NEXTVAL, ?, ?) ";
	
	public String insertBoardSql = " INSERT INTO BOARD VALUES(BOARDNOSQ.NEXTVAL, GROUPNOSQ.NEXTVAL, ?, ?, "
									+ " (SELECT MEM_NAME FROM MEMBER WHERE MEM_NO=?), "
									+ " ?, ?, ?, SYSDATE) ";
	
	public String selectBoardSql = " SELECT * FROM BOARD ORDER BY GROUP_NO DESC ";
	
	public int FileUpload(Connection con, FileDto dto);
	public int BoardUpload(Connection con, BoardDto dto);
	public List<BoardDto> BoardList(Connection con);
}
