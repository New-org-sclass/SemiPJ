package com.petp.dto;

import java.util.Date;

public class NewsDto {
	private int newsno;
	private String ntitle;
	private String nurl;
	private String nsummary;
	private String ncontent;
	private String nimg;
	private Date ndate;
	
	public NewsDto() {
		super();
	}
	
	
	
	public NewsDto(String ntitle, String nurl, String nsummary, String ncontent, String nimg, Date ndate) {
		super();
		this.ntitle = ntitle;
		this.nurl = nurl;
		this.nsummary = nsummary;
		this.ncontent = ncontent;
		this.nimg = nimg;
		this.ndate = ndate;
	}



	public NewsDto(int newsno, String ntitle, String nurl, String nsummary, String ncontent, String nimg,
			Date ndate) {
		super();
		this.newsno = newsno;
		this.ntitle = ntitle;
		this.nurl = nurl;
		this.nsummary = nsummary;
		this.ncontent = ncontent;
		this.nimg = nimg;
		this.ndate = ndate;
	}

	
	public int getNewsno() {
		return newsno;
	}

	public void setNewsno(int newsno) {
		this.newsno = newsno;
	}

	public String getNtitle() {
		return ntitle;
	}

	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}

	public String getNurl() {
		return nurl;
	}

	public void setNurl(String nurl) {
		this.nurl = nurl;
	}

	public String getNsummary() {
		return nsummary;
	}

	public void setNsummary(String nsummary) {
		this.nsummary = nsummary;
	}

	public String getNcontent() {
		return ncontent;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public String getNimg() {
		return nimg;
	}

	public void setNimg(String nimg) {
		this.nimg = nimg;
	}

	public Date getNdate() {
		return ndate;
	}

	public void setNdate(Date ndate) {
		this.ndate = ndate;
	}

	

	
}
