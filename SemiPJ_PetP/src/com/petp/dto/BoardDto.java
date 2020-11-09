package com.petp.dto;

import java.util.Date;

public class BoardDto {
	private int board_no;
	private int group_no;
	private int group_sq;
	private int board_tab;
	private String board_writer;
	private String board_content;
	private String board_hashtag;
	private String file_group;
	private Date board_regdate;
	
	
	public BoardDto() {
		super();
	}

	
	//board_detail에 content 작성
	public BoardDto(String board_content) {
		this.board_content = board_content;
	}



	public BoardDto(int board_no, int group_no, int group_sq, int board_tab, String board_writer, String board_content,
			String board_hashtag, String file_group, Date board_regdate) {
		super();
		this.board_no = board_no;
		this.group_no = group_no;
		this.group_sq = group_sq;
		this.board_tab = board_tab;
		this.board_writer = board_writer;
		this.board_content = board_content;
		this.board_hashtag = board_hashtag;
		this.file_group = file_group;
		this.board_regdate = board_regdate;
	}


	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getGroup_sq() {
		return group_sq;
	}
	public void setGroup_sq(int group_sq) {
		this.group_sq = group_sq;
	}
	public int getBoard_tab() {
		return board_tab;
	}
	public void setBoard_tab(int board_tab) {
		this.board_tab = board_tab;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_hashtag() {
		return board_hashtag;
	}
	public void setBoard_hashtag(String board_hashtag) {
		this.board_hashtag = board_hashtag;
	}
	public String getFile_group() {
		return file_group;
	}
	public void setFile_group(String file_group) {
		this.file_group = file_group;
	}
	public Date getBoard_regdate() {
		return board_regdate;
	}
	public void setBoard_regdate(Date board_regdate) {
		this.board_regdate = board_regdate;
	}

	
	
	
	


}




