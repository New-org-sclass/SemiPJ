package com.petp.dao;

import com.petp.dto.FileDto;
import java.sql.Connection;

public interface BoardDao {
	public String insertFileSql = " INSERT INTO BPIC VALUES(BPICNO.NEXTVAL, GROUPNO.NEXTVAL, ?, ?) ";
	
	public int FileUpload(Connection con, FileDto dto);
}
