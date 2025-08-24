package jsp13_miniproject_250822.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jsp13_miniproject_250822.dto.MemberDto;

public class MemberDao {
	private String driverName = "com.mysql.cj.jdbc.Driver"; 
	private String url = "jdbc:mysql://localhost:3306/250822miniproject";
	private String username = "root";
	private String password = System.getenv("DB_PASSWORD");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	// 로그인 확인하는 메서드
	public int loginCheck(String id, String pw) {
		String sql = "SELECT * FROM member WHERE memberid = ? AND memberpw = ?";
		int sqlResult = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {		
				sqlResult = 1;
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 로그인 실패");
			e.printStackTrace();
			
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return sqlResult;
	}
	
	
	
	
	
	
	
	
	// 회원가입 메서드
	public int memberJoin(MemberDto memberDto) {
		String sql = "INSERT INTO member (memberid, memberpw, membername, memberemail, memberbirth) VALUES (?, ?, ?, ?, ?)";
		int sqlResult = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDto.getMemberid());
			pstmt.setString(2, memberDto.getMemberpw());
			pstmt.setString(3, memberDto.getMembername());
			pstmt.setString(4, memberDto.getMemberemail());
			pstmt.setInt(5, memberDto.getMemberbirth());
			sqlResult = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 회원가입 실패");
			e.printStackTrace();
			
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return sqlResult;
	}
	
	
	
	
	// 회원 정보 수정하기 전, 아이디 통해서 회원 정보 불러오는 메서드
		public MemberDto memberInfo(String id) {
			String sql = "SELECT * FROM member WHERE memberid = ?";
			MemberDto memberDto = new MemberDto();
			
			try {
				Class.forName(driverName);
				conn = DriverManager.getConnection(url, username, password);
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {	
					memberDto.setMemberid(rs.getString("memberid"));
					memberDto.setMemberpw(rs.getString("memberpw"));
					memberDto.setMembername(rs.getString("membername"));
					memberDto.setMemberemail(rs.getString("memberemail"));
					memberDto.setMemberbirth(rs.getInt("memberbirth"));
				}
				
			} catch (Exception e) {
				System.out.println("DB 에러 발생, 회원 정보 가져오기 실패");
				e.printStackTrace();
				
			} finally {
				try {
					if (rs != null) {
						rs.close();
					}
					if (pstmt != null) {
						pstmt.close();
					}
					if (conn != null) {
						conn.close();
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return memberDto;
		}

	
	
	
	
	
	
	
	// 회원 정보 수정 메서드
	public int memberUpdate(MemberDto memberDto) {
		String sql = "UPDATE member SET memberpw = ?, membername = ?, memberemail = ?, memberbirth = ? WHERE memberid = ?";
		int sqlResult = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDto.getMemberpw());
			pstmt.setString(2, memberDto.getMembername());
			pstmt.setString(3, memberDto.getMemberemail());
			pstmt.setInt(4, memberDto.getMemberbirth());
			pstmt.setString(5, memberDto.getMemberid());
			
			sqlResult = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 회원 정보 수정 실패");
			e.printStackTrace();
			
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return sqlResult;
	}
}
