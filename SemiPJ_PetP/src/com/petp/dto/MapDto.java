package com.petp.dto;

import java.util.Date;

public class MapDto {
	private int walk_no;
	private String walk_name;
	private String walk_writer;
	private String walk_dong;
	private Date walk_regdate;
	private String walk_loc;
	


	public MapDto() {
		super();
	}


	public MapDto(String walk_name, String walk_loc, String walk_dong) {
		super();
		this.walk_name = walk_name;
		this.walk_loc = walk_loc;
		this.walk_dong = walk_dong;
	}


	public MapDto(int walk_no) {
		this.walk_no = walk_no;
	}
	
	public MapDto(int walk_no, String walk_name, String walk_writer, String walk_dong, Date walk_regdate, String walk_loc) {
		super();
		this.walk_no = walk_no;
		this.walk_name = walk_name;
		this.walk_writer = walk_writer;
		this.walk_dong = walk_dong;
		this.walk_regdate = walk_regdate;
		this.walk_loc  = walk_loc;
	}

	
	

	public MapDto(String walk_loc) {
		super();
		this.walk_loc = walk_loc;
	}


	public int getWalk_no() {
		return walk_no;
	}



	public void setWalk_no(int walk_no) {
		this.walk_no = walk_no;
	}



	public String getWalk_name() {
		return walk_name;
	}



	public void setWalk_name(String walk_name) {
		this.walk_name = walk_name;
	}



	public String getWalk_writer() {
		return walk_writer;
	}



	public void setWalk_writer(String walk_writer) {
		this.walk_writer = walk_writer;
	}



	public String getWalk_dong() {
		return walk_dong;
	}



	public void setWalk_dong(String walk_dong) {
		this.walk_dong = walk_dong;
	}



	public Date getWalk_regdate() {
		return walk_regdate;
	}



	public void setWalk_regdate(Date walk_regdate) {
		this.walk_regdate = walk_regdate;
	}
	
	public String getWalk_loc() {
		return walk_loc;
	}


	public void setWalk_loc(String walk_loc) {
		this.walk_loc = walk_loc;
	}


}
