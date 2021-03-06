package com.petp.biz;

import java.util.List;

import com.petp.dto.MemberDto;

public interface MemberBiz {
	public List<MemberDto> selectAll();
	public MemberDto selectOne(int seq);
	public MemberDto login(String email, String id, String pw);
	public boolean insert(MemberDto dto);
	public boolean update(MemberDto dto);
	public boolean delete(int seq);
}
