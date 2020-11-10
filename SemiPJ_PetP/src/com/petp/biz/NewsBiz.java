package com.petp.biz;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import com.petp.dao.NewsDao;
import com.petp.dto.NewsCoDto;
import com.petp.dto.NewsDto;

public class NewsBiz {
	Connection con = null;
	NewsDao newsdao = new NewsDao();

	public List<NewsDto> pnewsAll() {
		con = getConnection();
		List<NewsDto> alist = newsdao.pnewsAll(con);
		close(con);
		return alist;
	}

	public NewsDto pnewsOne(int newsno) {
		con = getConnection();
		NewsDto oneN = newsdao.pnewsOne(con, newsno);
		close(con);
		return oneN;
	}
	
	public void insertData(List<NewsDto> nlist) {
		if(nlist.size() == 0) {
			System.out.println("저장할 데이터 없음~ EXIT!");
			return;
		}
		sortL(nlist);
		con = getConnection();
		
		int res = newsdao.insertData(con, nlist);
		
		if(res>0) {
			System.out.println("Data 성공적 저장!");
			commit(con);
		} else {
			System.out.println("Data 저장 실패!");
			rollback(con);
		}
		close(con);
	}
	
	public List<NewsCoDto> selCo(int newsno) {
		Connection con = getConnection();
		List<NewsCoDto> clist = newsdao.selCo(con, newsno);
		close(con);
		System.out.println("clist successfully loaded!");
		return clist;
	}
	
	public int insertCo(NewsCoDto insertdto) {
		Connection con = getConnection();
		int res = newsdao.insertCo(con, insertdto);
		if(res>0) {
			commit(con);
			System.out.println("최상위 댓글 작성 완료");
		} else {
			rollback(con);
			System.out.println("최상위 댓글 작성 실패");
		}
		close(con);
		return res;
	}
	public int insertAn(NewsCoDto insertCodto) {
		Connection con = getConnection();
		int res = newsdao.insertAn(con, insertCodto);
		if(res>0) {
			commit(con);
			System.out.println("하위 댓글 작성 완료");
		} else {
			rollback(con);
			System.out.println("하위 댓글 작성 실패");
		}
		close(con);
		return res;
	}

	public int updateCo(int parentno) {
		Connection con = getConnection();
		int res = newsdao.updateCo(con, parentno);
		if(res>0) {
			System.out.println("댓글 sq 변경 완료");
		} else {
			System.out.println("댓글 sq 변경 실패");
		}
		close(con);
		return res;
	}

	public int deleteCo(int delcommentno) {
		Connection con = getConnection();
		int res = newsdao.deleteCo(con, delcommentno);
		if(res>0) {
			commit(con);
			System.out.println("댓글 삭제 완료");
		}
		close(con);
		return res;
	}

	public List<NewsDto> search(String sub) {
		con = getConnection();
		List<NewsDto> sch = newsdao.search(con, sub); 
		close(con);
		return sch;
	}

	public int inspectTitle(String title) {
		con = getConnection();
		int res = newsdao.inspectTitle(con, title);
		
		if(res!=0) {
			System.out.println("Redundant title! discard!");
		}
		close(con);
		return res;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void sortL(List<NewsDto> list) {
		Collections.sort(list, new Comparator() {

			@Override
			public int compare(Object o1, Object o2) {
				Date f = ((NewsDto)o1).getNdate();
				Date r = ((NewsDto)o2).getNdate();
				
				return f.compareTo(r);
			}
		});
	}
	
	public void tport(int pno) {
		System.out.println("pno is "+pno);
		newsdao.tport(pno);
	}
}
