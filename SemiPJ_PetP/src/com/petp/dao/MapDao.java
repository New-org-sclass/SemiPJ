package com.petp.dao;

import java.util.List;

import com.petp.dto.BoardDto;
import com.petp.dto.MapDto;

public interface MapDao {
	
	// 수정해야지
	String selectAllSql = " SELECT * FROM WALKTABLE ORDER BY WALK_NO DESC";
	String selectOneSql = " SELECT * FROM WALKTABLE WHERE WALK_NO=? ";
	String insertSql = " INSERT INTO WALKTABLE VALUES(BOARDNOSQ.NEXTVAL,?,'박정우','역삼',SYSDATE,?) ";
	String deleteSql = " DELETE FROM WALKTABLE WHERE WALK_NO=? ";
	
	public List<MapDto> selectAll(); 
	public MapDto selectOne(int walk_no);
	public boolean insert(MapDto dto);
	public int delete(int walk_no);
}
