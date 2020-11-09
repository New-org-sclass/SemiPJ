package com.petp.dao;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.petp.dto.BoardDto;

public class BoardDaoImpl implements BoardDao{

	@Override
	public List<BoardDto> boardList(Connection con, String search, int page) {
		System.out.println("[BoardDaoImpl : BoardList]");

		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BoardDto> res = new ArrayList<BoardDto>();
		
		try {
			pstm = con.prepareStatement(selectBoardSql);
			System.out.println("03.query 준비 : " + selectBoardSql);
			
			/*
			 * 	RNUM BETWEEN ? AND ?
			 * 	첫번째 ? ==> 1, 11, 21, 31 -> an = 1+(page-1)*10
			 * 	두번째 ? ==> 10, 20, 30, 40 -> page * 10
			 */
			pstm.setString(1, "%" + search + "%");
			pstm.setInt(2, 1 + (page - 1) * 10);
			pstm.setInt(3, page * 10);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setBoard_no(rs.getInt(2));
				dto.setGroup_no(rs.getInt(3));
				dto.setGroup_sq(rs.getInt(4));
				dto.setBoard_tab(rs.getInt(5));
				dto.setBoard_writer(rs.getString(6));
				dto.setBoard_content(rs.getString(7));
				dto.setBoard_hashtag(rs.getString(8));
				dto.setFile_group(rs.getString(9));
				dto.setBoard_regdate(rs.getDate(10));
				
				res.add(dto);
			}
			
			for(int i = 0; i<res.size(); i++) {
				System.out.println(res.get(i).getBoard_no());
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}

	@Override
	public int boardCount(Connection con, String search) {
		System.out.println("[BoardDaoImpl : boardCount]");

		PreparedStatement pstm = null;
		ResultSet rs = null;
		int res = 0;
		BoardDto dto = new BoardDto();
		
		try {
			pstm = con.prepareStatement(selectBoardCntSql);
			System.out.println("03.query 준비 : " + selectBoardCntSql);

			pstm.setString(1, "%" + search + "%");

			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			if(rs.next()) {
				res = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
			
		} finally {
			close(rs);
			close(pstm);
			//close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}

	@Override
	public List<BoardDto> userBoardList(Connection con, String memName, int page) {
		System.out.println("[BoardDaoImpl : userBoardList]");

		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BoardDto> res = new ArrayList<BoardDto>();
		
		try {
			pstm = con.prepareStatement(selectUserBoardSql);
			System.out.println("03.query 준비 : " + selectUserBoardSql);
			
			/*
			 * 	RNUM BETWEEN ? AND ?
			 * 	- 한페이지당 9개의 게시물
			 * 	첫번째 ? ==> 1, 10, 20, 30 -> an = 1+(page-1)*9
			 * 	두번째 ? ==> 9, 18, 27, 36 -> page * 9
			 */
			pstm.setString(1, memName);
			pstm.setInt(2, 1 + (page - 1) * 9);
			pstm.setInt(3, page * 9);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setBoard_no(rs.getInt(2));
				dto.setGroup_no(rs.getInt(3));
				dto.setGroup_sq(rs.getInt(4));
				dto.setBoard_tab(rs.getInt(5));
				dto.setBoard_writer(rs.getString(6));
				dto.setBoard_content(rs.getString(7));
				dto.setBoard_hashtag(rs.getString(8));
				dto.setFile_group(rs.getString(9));
				dto.setBoard_regdate(rs.getDate(10));
				
				res.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		return res;
	}

	public int boardUpload(Connection con, BoardDto dto) {
		System.out.println("[BoardDaoImpl]");

		PreparedStatement pstm = null;
		int res = 0;

		try {

			pstm = con.prepareStatement(insertBoardSql);
			System.out.println("03. query 준비: " + insertBoardSql);

			pstm.setInt(1, dto.getGroup_sq());
			pstm.setInt(2, dto.getBoard_tab());
			pstm.setInt(3, dto.getMem_no());
			pstm.setString(4, dto.getBoard_content());
			pstm.setString(5, dto.getBoard_hashtag());
			pstm.setString(6, dto.getFile_group());

			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			// 성공이면 res = 1

		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		
		return res;
	}
	
	/* board_detail */
	
	@Override
	public List<BoardDto> selectAll() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BoardDto> res = new ArrayList<BoardDto>();
		
		try {
			pstm = con.prepareStatement(selectAllSql);
			System.out.println("03. query 준비: " + selectAllSql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				
				dto.setBoard_no(rs.getInt(1));
				dto.setGroup_no(rs.getInt(2));
				dto.setGroup_sq(rs.getInt(3));
				dto.setBoard_tab(rs.getInt(4));
				dto.setBoard_writer(rs.getString(5));
				dto.setBoard_content(rs.getString(6));
				dto.setBoard_hashtag(rs.getString(7));
				dto.setFile_group(rs.getString(8));
				dto.setBoard_regdate(rs.getDate(9));
				
				res.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
	
	@Override
	public int update(BoardDto dto) {
		return 0;
	}

	
	@Override
	public int delete(int board_no) {
		return 0;
	}


	@Override
	public int insertAnswer(BoardDto dto) {
		
		return 0;
	}

	@Override
	public int updateAnswer(int group_no, int group_sq) {
		return 0;
	}
	
	// detail 페이지에 board_no에 해당하는 리스트 불러오기
	@Override
	public BoardDto selectOne(int board_no) {
		
		return null;
	}
	
	
	@Override
	   public int insert(BoardDto dto) {
	      Connection con = getConnection();
	      PreparedStatement pstm = null;
	      int res = 0;
	      
	      try {
	         pstm = con.prepareStatement(insertSql);
	         
	         pstm.setString(1, dto.getBoard_content());
	         System.out.println("03. query 준비: " +  insertSql);
	         
	         res = pstm.executeUpdate();
	         System.out.println("04. query 실행 및 리턴");
	         
	         if(res>0) {
	            commit(con);
	         }
	         
	         
	      } catch (SQLException e) {
	         System.out.println("3/4단계 에러");
	         e.printStackTrace();
	      } finally {
	         close(pstm);
	         close(con);
	         System.out.println("05. db 종료 \n");
	      }
	      
	      
	      return res;
	   }
	
}
