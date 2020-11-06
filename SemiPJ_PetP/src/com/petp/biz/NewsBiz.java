package com.petp.biz;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import com.petp.dao.NewsDao;
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

	public int insert(List<NewsDto> insertdto) {
		return 0;
	}

	public int update(List<NewsDto> updatedto) {
		return 0;
	}

	public int delete(int delnewsno) {
		return 0;
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
		newsdao.tport(pno);
	}
}
