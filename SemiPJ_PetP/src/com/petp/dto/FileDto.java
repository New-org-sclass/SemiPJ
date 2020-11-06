package com.petp.dto;

public class FileDto {
	int bpicno;
	String filename;
	String filerealname;
	
	public FileDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FileDto(int bpicno, String filename, String filerealname) {
		super();
		this.bpicno = bpicno;
		this.filename = filename;
		this.filerealname = filerealname;
	}
	
	public FileDto(String filename, String filerealname) {
		super();
		this.filename = filename;
		this.filerealname = filerealname;
	}

	public int getBpicno() {
		return bpicno;
	}

	public void setBpicno(int bpicno) {
		this.bpicno = bpicno;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilerealname() {
		return filerealname;
	}

	public void setFilerealname(String filerealname) {
		this.filerealname = filerealname;
	}

}
