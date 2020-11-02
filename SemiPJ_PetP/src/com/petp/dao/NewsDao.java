package com.petp.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petp.dto.NewsDto;

public class NewsDao {
	
	public List<NewsDto> pnewsAll(Connection con){
		List<NewsDto> alist = new ArrayList<NewsDto>();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = " select * from petnews order by newsno desc ";
		
		try {
			pstm = con.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				NewsDto tmp = new NewsDto();
				tmp.setNewsno(rs.getInt(1));
				tmp.setNtitle(rs.getString(2));
				tmp.setNurl(rs.getString(3));
				tmp.setNsummary(rs.getString(4));
				tmp.setNcontent(rs.getString(5));
				tmp.setNimg(rs.getString(6));
				tmp.setNdate(rs.getDate(7));
				alist.add(tmp);
			}
			System.out.println("03.alist loaded");
			
		} catch (SQLException e) {
			System.out.println("--alist load fail");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		return alist;
	}
	
	
	public NewsDto pnewsOne(Connection con, int newsno) {
		NewsDto oneN = new NewsDto();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = " select * from petnews where newsno = ? order by newsno desc ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, newsno);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				oneN.setNewsno(rs.getInt(1));
				oneN.setNtitle(rs.getString(2));
				oneN.setNurl(rs.getString(3));
				oneN.setNsummary(rs.getString(4));
				oneN.setNcontent(rs.getString(5));
				oneN.setNimg(rs.getString(6));
				oneN.setNdate(rs.getDate(7));
			}
			System.out.println("03.oneN loaded");
			
		} catch (SQLException e) {
			System.out.println("--oneN load fail");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		return oneN;
	}
	
	
	public int insertData(Connection con, List<NewsDto> nlist) {
		PreparedStatement pstm = null;
		int rs[] = null;
		int betchres = 0;
		int res = 0;
		
		String sql = " insert into petnews values(petnewsnosq.nextval, ? ,?, ?, ?, ?, ?) ";
		
		try {
			pstm = con.prepareStatement(sql);
			
			for(int i=0; i<nlist.size(); i++) {
//				NewsDto tmp = nlist.get(i);
				pstm.setString(1, nlist.get(i).getNtitle());
				pstm.setString(2, nlist.get(i).getNurl());
				pstm.setString(3, nlist.get(i).getNsummary());
				pstm.setString(4, nlist.get(i).getNcontent());
				pstm.setString(5, nlist.get(i).getNimg());
				pstm.setDate(6, convert(nlist.get(i).getNdate()));
				pstm.addBatch();
			}
			
			rs = pstm.executeBatch();
			System.out.println("03.InsertData query executed~");
			
			for(int i=0; i<rs.length; i++) {
				if(rs[i] == -2) {
					betchres++;
				}
			}
			if(betchres==nlist.size()) {
				res = betchres;
				System.out.println("04.InsertData query succsess!");
			}
			
		} catch (SQLException e) {
			System.out.println("InsertData Fail...T.T");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		
		return res;
	}
	
	public int insert(Connection con, List<NewsDto> insertdto) {
		
		return 0;
	}
	
	public int update(Connection con, List<NewsDto> updatedto) {
		
		return 0;
	}
	
	public int delete(Connection con, int delnewsno) { //마지막 순위
		
		return 0;
	}
	
	public List<NewsDto> search(Connection con, String sub){
		List<NewsDto> sch = new ArrayList<NewsDto>();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = " select * from petnews where ntitle like '%?%' or ncontent like '%?%' ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, sub);
			pstm.setString(2, sub);
			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				NewsDto tmp = new NewsDto();
				tmp.setNewsno(rs.getInt(1));
				tmp.setNtitle(rs.getString(2));
				tmp.setNurl(rs.getString(3));
				tmp.setNsummary(rs.getString(4));
				tmp.setNcontent(rs.getString(5));
				tmp.setNimg(rs.getString(6));
				tmp.setNdate(rs.getDate(7));
				sch.add(tmp);
			}
			
		} catch (SQLException e) {
			System.out.println("search fail T.T");
			e.printStackTrace();
		} finally{
			close(pstm);
		}
		
		return sch;
	}
	
	public int inspectTitle(Connection con, String title) { //db에 없어야 true
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int res = 0;
		
		String sql = " select count(ntitle) from petnews where ntitle = ? "
						+" and newsno between (select max(newsno)-100 from petnews )"
						+ " and (select max(newsno) from petnews ) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, title);
			
			rs = pstm.executeQuery();
			System.out.println("inspectTitle query executed~");
			
			while(rs.next()) {
				res = rs.getInt(1);
				System.out.println("res: "+res);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		
		return res;
	}
	
	private java.sql.Date convert(java.util.Date uDate) {
        java.sql.Date sDate = new java.sql.Date(uDate.getTime());
        return sDate;
    }
	
}
