package com.petp.biz;

import java.util.List;

import com.petp.dao.MemberDao;
import com.petp.dao.MemberDaoImpl;
import com.petp.dto.MemberDto;

public class MemberBizImpl implements MemberBiz {
	private MemberDao dao = new MemberDaoImpl();
	
	@Override
	public List<MemberDto> selectAll() {
		return dao.selectAll();
	}

	@Override
	public MemberDto selectOne(int seq) {
		return dao.selectOne(seq);
	}

	@Override
	public boolean insert(MemberDto dto) {
		return dao.insert(dto);
	}

	@Override
	public boolean update(MemberDto dto) {
		return dao.update(dto);
	}

	@Override
	public boolean delete(int seq) {
		return dao.delete(seq);
	}

	@Override
	public MemberDto login(String email, String id, String pw) {
		return dao.login(email, id, pw);
	}

	
}
