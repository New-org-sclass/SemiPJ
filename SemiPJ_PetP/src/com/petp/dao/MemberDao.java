package com.petp.dao;

import java.util.List;


import com.petp.dto.MemberDto;

public interface MemberDao {
	//전체회원
	String selectAllSql = " SELECT * FROM MEMBER ORDER BY MEM_NO DESC ";
	
	//선택한명
	String selectOneSql = " SELECT * FROM MEMBER WHERE MEM_NO=? ";
	
	//회원가입
	String insertSql = " INSERT INTO MEMBER VALUES(MEMSEQ.NEXTVAL, ?, ?, ?, ?, NULL, 'Y') ";
	
	//회원탈퇴
	String deleteSql = " UPDATE MEMBER SET MEM_ENABLED='N' WHERE MEM_NO=? ";

	
	//정보 수정
	String updateSql= " UPDATE MEMBER SET MEM_PW=?,MEM_EMAIL=? WHERE MEM_NO=? ";
	
	//프로필 변경
	String proSql= " UPDATE MEMBER SET MEM_PIC=? WHERE MEM_NO=? ";
	
	//아이디 중복체크
	String idChkSql= " SELECT * FROM MEMBER WHERE MEM_ID=? ";
	
	//로그인
	String login= " SELECT * FROM MEMBER WHERE MEM_ID=? AND MEM_PW=? AND MEM_ENABLED=? ";
	
	public List<MemberDto> selectAll();
	public MemberDto selectOne(int seq);
	public MemberDto login(String id,String pw);
	public boolean insert(MemberDto dto);
	public boolean update(MemberDto dto);
	public boolean delete(int seq);
	public String idChk(String id);
	public boolean setPro(int memno, String img);
}
