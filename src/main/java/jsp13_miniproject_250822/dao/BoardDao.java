package jsp13_miniproject_250822.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jsp13_miniproject_250822.dto.BoardDto;

public class BoardDao {
	private String driverName = "com.mysql.cj.jdbc.Driver"; 
	private String url = "jdbc:mysql://localhost:3306/250822miniproject";
	private String username = "root";
	private String password = System.getenv("DB_PASSWORD");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	BoardDto boardDto = null;
	List<BoardDto> boardDtos = null;
	
	
	public static final int PAGESIZE = 10; // 한 페이지당 보이는 글 수
	public static final int BLOCKSIZE = 10; // 페이지 블록 크기 (하단에 보여지는 [1][2] ..)
	
	
	// 모든 글 목록 가져오는 메서드 + 페이징
	public List<BoardDto> getBoardList(int page) {
		// String sql = "SELECT * FROM board ORDER BY bnum DESC";
		String sql = "SELECT row_number() OVER(ORDER BY bnum) AS rownum, "
				+ "bnum, btitle, memberid, bhit, bdate  "
				+ "FROM board "
				+ "ORDER BY rownum DESC "
				+ "LIMIT ? OFFSET ?";
		int offset = (page - 1) * PAGESIZE;
		boardDtos = new ArrayList<>();
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, PAGESIZE);
			pstmt.setInt(2, offset);
			rs = pstmt.executeQuery();

			while (rs.next()) {			
				boardDto = new BoardDto();
				boardDto.setBnum(rs.getInt("bnum"));
				boardDto.setBtitle(rs.getString("btitle"));
				boardDto.setMemberid(rs.getString("memberid"));
				boardDto.setBhit(rs.getInt("bhit"));
				boardDto.setBdate(rs.getString("bdate"));
				boardDto.setRownum(rs.getInt("rownum"));
				boardDtos.add(boardDto);
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 페이징 된 모든 글 가져오기 실패");
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
		return boardDtos;
	}


	
	
	// 모든 글 개수 가져오는 메서드 (이건 결과값이 글 개수로 나옴!)
	public int getBoardCount() {
		String sql = "SELECT count(*) AS totalCount FROM board";
		int totalCount = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("totalCount");
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 모든 글 개수 가져오기 실패");
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
		return totalCount;
	}
	
	
	
	
	
	// 검색한 글 목록 가져오는 메서드 + 페이징
	public List<BoardDto> getSearchBoardList(int page, String searchType, String keyword) {
		String sql = "SELECT row_number() OVER(ORDER BY bnum) AS rownum, "
				+ "bnum, btitle, memberid, bhit, bdate FROM board b "
				+ "WHERE " + searchType + " LIKE ? "
				+ "ORDER BY bnum DESC "
				+ "LIMIT ? OFFSET ?";
	    int offset = (page - 1) * PAGESIZE;

		boardDtos = new ArrayList<>();
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, PAGESIZE);
			pstmt.setInt(3, offset);
			rs = pstmt.executeQuery();

			while (rs.next()) {			
				boardDto = new BoardDto();
				boardDto.setBnum(rs.getInt("bnum"));
				boardDto.setBtitle(rs.getString("btitle"));
				boardDto.setMemberid(rs.getString("memberid"));
				boardDto.setBhit(rs.getInt("bhit"));
				boardDto.setBdate(rs.getString("bdate"));
				boardDto.setRownum(rs.getInt("rownum"));
				boardDtos.add(boardDto);
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 검색한 글 가져오기 실패");
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
		return boardDtos;
	}
	
	
	
	
	
	// 검색 결과 글 총 개수 가져오는 메서드
	public int getSearchBoardCount(String searchType, String keyword) {
		String sql = "SELECT count(*) AS totalCount FROM board "
				+ "WHERE " + searchType + " LIKE ? ;";
		int totalCount = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("totalCount");
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 검색 글 개수 가져오기 실패");
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
		return totalCount;
	}
	
	
	
	
	// 글 작성, 등록 메서드
	public int boardWrite(String writer, String title, String content) {
		String sql = "INSERT INTO board (btitle, bcontent, memberid) VALUES (?, ?, ?)";
		int SqlResult = 0;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.executeUpdate();	
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 새 글 작성 실패");
			e.printStackTrace();
		} finally { 
			try {
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
		return SqlResult;
	}
	
	
	
	
	// 글 내용 보는 메서드
	public BoardDto boardView(int bnum) {
		String sql = "SELECT * FROM board WHERE bnum = ?";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				boardDto = new BoardDto();
				boardDto.setBnum(rs.getInt("bnum"));
				boardDto.setBtitle(rs.getString("btitle"));
				boardDto.setBcontent(rs.getString("bcontent"));
				boardDto.setMemberid(rs.getString("memberid"));
				boardDto.setBhit(rs.getInt("bhit"));
				boardDto.setBdate(rs.getString("bdate"));
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 글 불러오기 실패");
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
		return boardDto;
	}
	
	
	
	// 글 수정 메서드
	public int boardEdit(int bnum, String title, String content) {
		String sql = "UPDATE board SET btitle = ?, bcontent = ? WHERE bnum = ?";
		int sqlResult = 0;
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, bnum);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 글 수정 실패");
			e.printStackTrace();
		} finally { 
			try {
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
			
	
	
	
	// 게시글 눌렀을 때 조회수 올라가게 하는 메서드
	public void updateHit(int bnum) {
		String sql = "UPDATE board SET bhit = (bhit + 1) WHERE bnum = ?";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 조회수 에러");
			e.printStackTrace();
		} finally { 
			try {
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
	}
	
	
	
	
	
	// 게시글 삭제 메서드
	public void boardDelete(int bnum) {
		String sql = "DELETE FROM board WHERE bnum = ?";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("DB 에러 발생, 글 삭제 실패");
			e.printStackTrace();
		} finally { 
			try {
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
	}
	
	
	
	
	
	
	
	
	
	
	
}
