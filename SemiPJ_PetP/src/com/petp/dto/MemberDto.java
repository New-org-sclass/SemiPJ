package com.petp.dto;

public class MemberDto {
	private int memno;
	private String memid;
	private String mempw;
	private String memname;
	private String mememail;
	private String mempic;
	private String memenabled;
	public MemberDto() {
		super();
	}
	
	public MemberDto(String memid, String mempw, String mememail) {
		super();
		this.memid = memid;
		this.mempw = mempw;
		this.mememail = mememail;
	}

	public MemberDto(String memid, String memname, String mempw, String mememail) {
		super();
		this.memid = memid;
		this.memname = memname;
		this.mempw = mempw;
		this.mememail = mememail;
	}

	public MemberDto(int memno, String memid, String mempw, String memname, String mememail, String mempic,
			String memenabled) {
		super();
		this.memno = memno;
		this.memid = memid;
		this.mempw = mempw;
		this.memname = memname;
		this.mememail = mememail;
		this.mempic = mempic;
		this.memenabled = memenabled;
	}
	public int getMemno() {
		return memno;
	}
	public void setMemno(int memno) {
		this.memno = memno;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getMempw() {
		return mempw;
	}
	public void setMempw(String mempw) {
		this.mempw = mempw;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getMememail() {
		return mememail;
	}
	public void setMememail(String mememail) {
		this.mememail = mememail;
	}
	public String getMempic() {
		return mempic;
	}
	public void setMempic(String mempic) {
		this.mempic = mempic;
	}
	public String getMemenabled() {
		return memenabled;
	}
	public void setMemenabled(String memenabled) {
		this.memenabled = memenabled;
	}

	@Override
	public String toString() {
		return "MemberDto [memno=" + memno + ", memid=" + memid + ", mempw=" + mempw + ", memname=" + memname
				+ ", mememail=" + mememail + ", mempic=" + mempic + ", memenabled=" + memenabled + "]";
	}
	
	
}
