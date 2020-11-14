package com.petp.dao;

import static common.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petp.dto.MemberDto;

public class MemberDaoImpl implements MemberDao {

	@Override
	public List<MemberDto> selectAll() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<MemberDto> res = new ArrayList<MemberDto>();
		
		String sql=selectAllSql;
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("03.query 준비: "+sql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				MemberDto tmp = new MemberDto();
				tmp.setMemno(rs.getInt(1));
				tmp.setMemid(rs.getString(2));
				tmp.setMempw(rs.getString(3));
				tmp.setMemname(rs.getString(4));
				tmp.setMememail(rs.getString(5));
				tmp.setMempic(rs.getString(6));
				tmp.setMemenabled(rs.getString(7));
				
				res.add(tmp);
				
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}

	@Override
	public MemberDto selectOne(int seq) {
		Connection con = getConnection();
		PreparedStatement pstm =null;
		ResultSet rs = null;
		MemberDto res = new MemberDto();
		
		String sql = selectOneSql;
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, seq);
			System.out.println("03. query 준비: "+sql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				res.setMemno(rs.getInt(1));
				res.setMemid(rs.getString(2));
				res.setMempw(rs.getString(3));
				res.setMemname(rs.getString(4));
				res.setMememail(rs.getString(5));
				res.setMempic(rs.getString(6));
				res.setMemenabled(rs.getString(7));
				
				
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		
		return res;
	}

	@Override
	public MemberDto login(String id, String pw) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs= null;
		MemberDto res = new MemberDto();
		
		String sql=login;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, id);
			pstm.setString(2, pw);
			pstm.setString(3, "Y");
			System.out.println("03.query 준비: "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				res.setMemno(rs.getInt(1));
				res.setMemid(rs.getString(2));
				res.setMempw(rs.getString(3));
				res.setMemname(rs.getString(4));
				res.setMememail(rs.getString(5));
				res.setMempic(rs.getString(6));
				res.setMemenabled(rs.getString(7));
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}

	@Override
	public boolean insert(MemberDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res =0;
		
		String sql=insertSql;
		
		
			try {
				pstm=con.prepareStatement(sql);
				pstm.setString(1, dto.getMemid());
				pstm.setString(2, dto.getMempw());
				pstm.setString(3, dto.getMemname());
				pstm.setString(4, dto.getMememail());
		
				System.out.println("03.query ready: "+sql);
				
				res=pstm.executeUpdate();
				System.out.println("04.query 실행 및 리턴");
				
				if(res>0) {
					commit(con);
				}
				
				
			} catch (SQLException e) {
				System.out.println("3/4 단계 에러");
				e.printStackTrace();
			}finally {
				close(pstm);
				close(con);
				System.out.println("05.db 종료\n");
			}

			return (res>0)?true:false;
	}

	@Override
	public boolean update(MemberDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res =0;
		
		String sql=updateSql;
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, dto.getMempw());
			pstm.setString(2, dto.getMememail());
			pstm.setInt(3, dto.getMemno());
			System.out.println("03.query 준비:"+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
			
		}catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}

		return (res>0)?true:false;
	}

	@Override
	public boolean delete(int seq) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res =0;
		
		String sql=deleteSql;
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, seq);
			System.out.println("03.query 준비:"+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
			
		}catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return (res>0)?true:false;
	}

	@Override
	public String idChk(String id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs =null;
		String res =null;
		
		String sql=idChkSql;
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, id);
			System.out.println("03.query 준비:"+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				res=rs.getString(2);
			}
			
		}catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}

	@Override
	public boolean setPro(int memno, String img) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res =0;
		
		String sql=proSql;
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, img);
			pstm.setInt(2, memno);
			System.out.println("03.query 준비:"+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
			
		}catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}

		return (res>0)?true:false;
	}

	

}
