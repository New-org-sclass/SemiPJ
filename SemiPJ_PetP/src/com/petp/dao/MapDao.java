package com.petp.dao;

import java.util.List;

import com.petp.dto.BoardDto;
import com.petp.dto.MapDto;

public interface MapDao {
	
	// 수정해야지
	String selectAllSql = " SELECT * FROM WALKTABLE ORDER BY WALK_NO DESC ";
	String selectOneSql = " SELECT * FROM WALKTABLE WHERE WALK_NO=? ";
	String insertSql = " INSERT INTO BOARD VALUES(BOARDNOSQ.NEXTVAL,GROUPNOSQ.NEXTVAL,1,0,NULL,?,NULL,NULL,SYSDATE) ";
	String deleteSql = " DELETE FROM BOARD WHERE BOARD_NO=? ";
	
	public List<MapDto> selectAll(); 
	public MapDto selectOne(int walk_no);
	public int insert(MapDto dto);
	public int delete(int walk_no);
}
