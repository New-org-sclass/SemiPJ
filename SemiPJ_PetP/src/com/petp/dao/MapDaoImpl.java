package com.petp.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petp.dto.MapDto;

public class MapDaoImpl implements MapDao{

	@Override
	public List<MapDto> selectAll() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<MapDto> res = new ArrayList<MapDto>();
		
		try {
			pstm = con.prepareStatement(selectAllSql);
			System.out.println("03.query 준비 : " + selectAllSql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				MapDto tmp = new MapDto(rs.getInt(1), rs.getString(2), rs.getString(3), 
						rs.getString(4), rs.getDate(5), rs.getString(6));
				
				res.add(tmp);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db종료 \n");
		}
		
		return res;
	}

	@Override
	public MapDto selectOne(int walk_no) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MapDto res = null;
		
		try {
			pstm = con.prepareStatement(selectOneSql);
			pstm.setInt(1, walk_no);
			System.out.println("03.query 준비 : " + selectOneSql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			while(rs.next()) {
				res = new MapDto(rs.getString(6));		
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		
		return res;
	}

	@Override
	public boolean insert(MapDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(insertSql);
			pstm.setString(1, dto.getWalk_name());
			pstm.setString(2, dto.getWalk_writer()); //session용으로 추가했습니다!
			pstm.setString(3, dto.getWalk_dong());
			pstm.setString(4, dto.getWalk_loc());
			System.out.println("03. query 준비 : " + insertSql);
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res > 0) {
				commit(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		
		return (res>0)?true:false;
	}

	@Override
	public int delete(int walk_no) {
		
		
		return 0;
	}

	
}
