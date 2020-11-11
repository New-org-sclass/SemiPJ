package com.petp.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petp.dto.NewsCoDto;
import com.petp.dto.NewsDto;

public class NewsDao {
	private int pno = 0;
	
	public List<NewsDto> pnewsAll(Connection con){
		List<NewsDto> alist = new ArrayList<NewsDto>();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = " select * from petnews order by ndate desc, newsno desc ";
		String noimg = "./resources/images/noimage.jpg";
		
		try {
			pstm = con.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				NewsDto tmp = new NewsDto();
				tmp.setNewsno(rs.getInt(1));
				tmp.setNtitle(doubleTosingle(rs.getString(2)));
				tmp.setNurl(rs.getString(3));
				tmp.setNsummary(doubleTosingle(rs.getString(4)));
				tmp.setNcontent(rs.getString(5));
				if(rs.getString(6) == null) {
					System.out.println("dao's pno is "+ pno);
					tmp.setNimg(noimg);
				} else {
					tmp.setNimg(rs.getString(6));
				}
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
		String noimg = "./resources/images/noimage.jpg";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, newsno);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				oneN.setNewsno(rs.getInt(1));
				oneN.setNtitle(doubleTosingle(rs.getString(2)));
				oneN.setNurl(rs.getString(3));
				oneN.setNsummary(doubleTosingle(rs.getString(4)));
				oneN.setNcontent(rs.getString(5));
				if(rs.getString(6) == null) {
					oneN.setNimg(noimg);
				} else {
					oneN.setNimg(rs.getString(6));
				}
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
	
	public List<NewsCoDto> selCo(Connection con, int newsno) {
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<NewsCoDto> clist = new ArrayList<NewsCoDto>();
		String sql = " select * from newscomment where news_no = ? order by groupno desc, groupsq ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, newsno);
			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				NewsCoDto tmp = new NewsCoDto();
				tmp.setCommentno(rs.getInt(1));
				tmp.setNewsno(rs.getInt(2));
				tmp.setGroupno(rs.getInt(3));
				tmp.setGroupsq(rs.getInt(4));
				tmp.setWriter(rs.getString(5));
				tmp.setNcomment(rs.getString(6));
				tmp.setCommentdate(rs.getString(7));
				clist.add(tmp);
			}
			
			System.out.println("댓글 select 준비 및 쿼리실행");
			
		} catch (SQLException e) {
			System.out.println("answer select fail T.T");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		
		return clist;
	}
	
	public int insertCo(Connection con, NewsCoDto insertdto) {
		PreparedStatement pstm = null;
		int res = 0; //member id 는 이 밑에 where mem_no = 1 << 여기부분을 바꿔줘야한다! 
		String sql = " insert into newscomment values(newscommentnosq.nextval, ?,newscommentgroupnosq.nextval, "
				+ "1, (select mem_id from member where mem_no = 1) ,?, "
				+ "(select TO_CHAR(TO_DATE(SYSDATE), 'YYYY-MM-DD HH:mm:ss') from dual) ) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, insertdto.getNewsno());
			//pstm.setString(2, insertdto.getWriter()); mem_no추가해야되는 부분!
			pstm.setString(2, insertdto.getNcomment());
			
			res = pstm.executeUpdate();
			System.out.println("댓글 삽입 준비 및 쿼리실행");
			
		} catch (SQLException e) {
			System.out.println("answer insert fail T.T");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		
		return res;
	}
	public int insertAn(Connection con, NewsCoDto insertCodto) {
		PreparedStatement pstm = null;
		int res = 0;
		String sql = " insert into newscomment values(newscommentnosq.nextval, ?, ?, "
				+ "1, (select mem_id from member where mem_no = 1) ,?, "
				+ "(select TO_CHAR(TO_DATE(SYSDATE), 'YYYY-MM-DD HH:mm:ss') from dual)) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, insertCodto.getNewsno());
			pstm.setInt(2, insertCodto.getGroupno());//부모댓글의 groupno view에서 전달받아와야함.
			pstm.setString(3, insertCodto.getNcomment());
			
			res = pstm.executeUpdate();
			System.out.println("댓글 삽입 준비 및 쿼리실행");
			
		} catch (SQLException e) {
			System.out.println("answer insert fail T.T");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		
		return res;
	}
	
	public int updateCo(Connection con, int parentno) {//해당기사넘의 1번 댓글 groupsq
		PreparedStatement pstm = null;
		int res = 0;
		String sql = " update newscomment set groupsq = groupsq+1 where "
				+ " groupno = (select groupno from newscomment where commentno = ?) and "
				+ " groupsq > (select groupsq from newscomment where commentno = ?) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, parentno);
			pstm.setInt(2, parentno);
			
			res = pstm.executeUpdate();
			System.out.println("댓글 updateCo 준비 및 쿼리실행");
			
		} catch (SQLException e) {
			System.out.println("answer groupsq modify fail T.T");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		return res;
	}
	
	public int deleteCo(Connection con, int delcommentno) { //마지막 순위
		PreparedStatement pstm = null;
		int res = 0;
		String sql = " delete from newscomment where commentno = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, delcommentno);
			
			res = pstm.executeUpdate();
			System.out.println("댓글 삭제 준비 및 쿼리실행");
			
		} catch (SQLException e) {
			System.out.println("answer groupsq delete fail T.T");
			e.printStackTrace();
		} finally {
			close(pstm);
		}
		return res;
	}
	
	public List<NewsDto> search(Connection con, String sub){
		List<NewsDto> sch = new ArrayList<NewsDto>();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = " select * from petnews where ntitle like ? or ncontent like ? order by ndate desc, newsno desc ";
		String noimg = "./resources/images/noimage.jpg";
		System.out.println(sql);
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, "%"+sub+"%");
			pstm.setString(2, "%"+sub+"%");
			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				NewsDto tmp = new NewsDto();
				tmp.setNewsno(rs.getInt(1));
				tmp.setNtitle(doubleTosingle(rs.getString(2)));
				tmp.setNurl(rs.getString(3));
				tmp.setNsummary(doubleTosingle(rs.getString(4)));
				tmp.setNcontent(rs.getString(5));
				tmp.setNimg(rs.getString(6));
				if(rs.getString(6) == null) {
					tmp.setNimg(noimg);
				} else {
					tmp.setNimg(rs.getString(6));
				}
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
	
	public void tport(int pno) {
		this.pno = pno;
	}
	
	private String doubleTosingle(String raw) {
		char[] ct = raw.toCharArray();
		for(int i=0; i<ct.length; i++) {
			if(ct[i] == '\"') {
				ct[i] = '`';
			}
		}
		return String.valueOf(ct);
	}
	
}
