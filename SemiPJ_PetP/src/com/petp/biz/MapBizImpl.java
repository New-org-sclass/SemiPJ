package com.petp.biz;

import java.util.List;

import com.petp.dao.MapDao;
import com.petp.dao.MapDaoImpl;
import com.petp.dto.MapDto;

public class MapBizImpl implements MapBiz{

	private MapDao dao = new MapDaoImpl();
	
	@Override
	public List<MapDto> selectAll() {
		return dao.selectAll();
	}

	@Override
	public MapDto selectOne(int walk_no) {
		return dao.selectOne(walk_no);
	}

	@Override
	public boolean insert(MapDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int delete(int walk_no) {
		return dao.delete(walk_no);
	}

}
