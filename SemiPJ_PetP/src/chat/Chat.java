package chat;


public class Chat {
	 int seq;
     String chatName;
     String chatContent;
     String regdate;
	public Chat() {
		super();
	}
	public Chat(int seq, String chatName, String chatContent, String regdate) {
		super();
		this.seq = seq;
		this.chatName = chatName;
		this.chatContent = chatContent;
		this.regdate = regdate;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getChatName() {
		return chatName;
	}
	public void setChatName(String chatName) {
		this.chatName = chatName;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
    
}