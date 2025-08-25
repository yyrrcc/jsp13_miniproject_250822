package jsp13_miniproject_250822.dto;

public class ReplyDto {
	private int rid;
	private int bnum;
	private String membername;
	private String memberid;
	private String rcontent;
	private String rdate;
	
	private MemberDto memberDto; // 필요한가?
	private BoardDto boardDto; // 필요한가?
	
	public ReplyDto() {
		super();
	}

	// 기존 생성자
	public ReplyDto(int rid, int bnum, String membername, String memberid, String rcontent, String rdate) {
		super();
		this.rid = rid;
		this.bnum = bnum;
		this.membername = membername;
		this.memberid = memberid;
		this.rcontent = rcontent;
		this.rdate = rdate;
	}
	
	

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getMembername() {
		return membername;
	}

	public void setMembername(String membername) {
		this.membername = membername;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	
	
}
