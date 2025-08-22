package jsp13_miniproject_250822.dto;

public class MemberDto {
	private String memberid;
	private String memberpw;
	private String membername;
	private String memberemail;
	private int memberbirth;
	private String memberregdate;
	
	public MemberDto() {
		super();
	}

	// 모든 변수 생성자
	public MemberDto(String memberid, String memberpw, String membername, String memberemail, int memberbirth,
			String memberregdate) {
		super();
		this.memberid = memberid;
		this.memberpw = memberpw;
		this.membername = membername;
		this.memberemail = memberemail;
		this.memberbirth = memberbirth;
		this.memberregdate = memberregdate;
	}
	
	
	// 회원등록일 없는 생성자
	public MemberDto(String memberid, String memberpw, String membername, String memberemail, int memberbirth) {
		super();
		this.memberid = memberid;
		this.memberpw = memberpw;
		this.membername = membername;
		this.memberemail = memberemail;
		this.memberbirth = memberbirth;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getMemberpw() {
		return memberpw;
	}

	public void setMemberpw(String memberpw) {
		this.memberpw = memberpw;
	}

	public String getMembername() {
		return membername;
	}

	public void setMembername(String membername) {
		this.membername = membername;
	}

	public String getMemberemail() {
		return memberemail;
	}

	public void setMemberemail(String memberemail) {
		this.memberemail = memberemail;
	}

	public int getMemberbirth() {
		return memberbirth;
	}

	public void setMemberbirth(int memberbirth) {
		this.memberbirth = memberbirth;
	}

	public String getMemberregdate() {
		return memberregdate;
	}

	public void setMemberregdate(String memberregdate) {
		this.memberregdate = memberregdate;
	}
	
	
	
}
