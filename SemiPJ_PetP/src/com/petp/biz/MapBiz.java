package com.petp.biz;

import java.util.List;

import com.petp.dto.MapDto;

public interface MapBiz {

	public List<MapDto> selectAll();
	public MapDto selectOne(int walk_no);
	public boolean insert(MapDto dto);
	public int delete(int walk_no);
	
}
