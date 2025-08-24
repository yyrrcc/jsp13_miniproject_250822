package jsp13_miniproject_250822.dto;

public class BoardDto {
	private int bnum;
	private String btitle;
	private String bcontent;
	private String memberid;
	private int bhit;
	private String bdate;
	
	private int rownum; // 실제 글 개수
	private MemberDto memberDto; // MemberDto 클래스에 있는 멤버변수 가져오기
	
	public BoardDto() {
		super();
	}

	// 기존 변수
	public BoardDto(int bnum, String btitle, String bcontent, String memberid, int bhit, String bdate) {
		super();
		this.bnum = bnum;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.memberid = memberid;
		this.bhit = bhit;
		this.bdate = bdate;
	}

	// bcontent 없는 메서드
	public BoardDto(int bnum, String btitle, String memberid, int bhit, String bdate) {
		super();
		this.bnum = bnum;
		this.btitle = btitle;
		this.memberid = memberid;
		this.bhit = bhit;
		this.bdate = bdate;
	}
	
	// 모든 변수 + rownum
	public BoardDto(int bnum, String btitle, String bcontent, String memberid, int bhit, String bdate, int rownum) {
		super();
		this.bnum = bnum;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.memberid = memberid;
		this.bhit = bhit;
		this.bdate = bdate;
		this.rownum = rownum;
	}

	// 모든 변수 + memberDto, rownum
	public BoardDto(int bnum, String btitle, String bcontent, String memberid, int bhit, String bdate, int rownum,
			MemberDto memberDto) {
		super();
		this.bnum = bnum;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.memberid = memberid;
		this.bhit = bhit;
		this.bdate = bdate;
		this.rownum = rownum;
		this.memberDto = memberDto;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getBtitle() {
		return btitle;
	}

	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public int getBhit() {
		return bhit;
	}

	public void setBhit(int bhit) {
		this.bhit = bhit;
	}

	public String getBdate() {
		return bdate;
	}

	public void setBdate(String bdate) {
		this.bdate = bdate;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public MemberDto getMemberDto() {
		return memberDto;
	}

	public void setMemberDto(MemberDto memberDto) {
		this.memberDto = memberDto;
	}
	
	
}
