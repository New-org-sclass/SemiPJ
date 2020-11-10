package com.petp.dto;

public class NewsCoDto {
	private int commentno;
	private int newsno;
	private int groupno;
	private int groupsq;
	private String writer;
	private String ncomment;
	private String commentdate;
	
	public NewsCoDto() {
		super();
	}

	public NewsCoDto(int commentno, int newsno, int groupno, int groupsq, String writer, String ncommnet,
			String commentdate) {
		super();
		this.commentno = commentno;
		this.newsno = newsno;
		this.groupno = groupno;
		this.groupsq = groupsq;
		this.writer = writer;
		this.ncomment = ncommnet;
		this.commentdate = commentdate;
	}

	
	public int getCommentno() {
		return commentno;
	}

	public void setCommentno(int commentno) {
		this.commentno = commentno;
	}

	public int getNewsno() {
		return newsno;
	}

	public void setNewsno(int newsno) {
		this.newsno = newsno;
	}

	public int getGroupno() {
		return groupno;
	}

	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}

	public int getGroupsq() {
		return groupsq;
	}

	public void setGroupsq(int groupsq) {
		this.groupsq = groupsq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getNcomment() {
		return ncomment;
	}

	public void setNcomment(String ncomment) {
		this.ncomment = ncomment;
	}

	public String getCommentdate() {
		return commentdate;
	}

	public void setCommentdate(String commentdate) {
		this.commentdate = commentdate;
	}
	
	
	
	
	
	
}
