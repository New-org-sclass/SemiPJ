package com.petp.biz;

import com.petp.dto.FileDto;
import com.petp.dao.BoardDao;
import com.petp.dao.BoardDaoImpl;

import static common.JDBCTemplate.*;

import java.sql.Connection;

public class BoardBizImpl implements BoardBiz{
	private BoardDao dao = new BoardDaoImpl();
	
	
	@Override
	public int insertFile(FileDto dto) {
		Connection con = getConnection();
		int res = dao.FileUpload(con, dto);
		
		if(res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return res;
	}

}
