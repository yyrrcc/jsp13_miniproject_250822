package jsp13_miniproject_250822.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jsp13_miniproject_250822.dto.ReplyDto;

public class ReplyDao {
	private String driverName = "com.mysql.cj.jdbc.Driver"; 
	private String url = "jdbc:mysql://localhost:3306/250822miniproject";
	private String username = "root";
	private String password = System.getenv("DB_PASSWORD");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	ReplyDto replyDto = null;
	List<ReplyDto> replyDtos = null;
	


	
	// 댓글 등록
	public int insertReply(int bnum, String writer, String content) {
        String sql = "INSERT INTO reply (bnum, memberid, rcontent) VALUES (?, ?, ?)";
        int sqlResult = 0;
        try {
        	Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bnum);
            pstmt.setString(2, writer);
            pstmt.setString(3, content);            
            sqlResult = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sqlResult;
    }
	
	
	
	
	
	// 댓글 목록 조회
	public List<ReplyDto> getReplyList(int bnum) {
		replyDtos = new ArrayList<>();
	    String sql = "SELECT * FROM reply WHERE bnum = " + bnum + " ORDER BY rid";
	    	try {
	    		Class.forName(driverName);
				conn = DriverManager.getConnection(url, username, password);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					replyDto = new ReplyDto();
					replyDto.setRid(rs.getInt("rid"));
					replyDto.setBnum(rs.getInt("bnum"));
					replyDto.setMembername(rs.getString("membername"));
					replyDto.setMemberid(rs.getString("memberid"));
					replyDto.setRcontent(rs.getString("rcontent"));
					replyDto.setRdate(rs.getString("rdate"));
					replyDtos.add(replyDto);
		        }
	    	 } catch (Exception e) {
				System.out.println("DB 에러 발생, 댓글 목록 가져오기 실패");
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
			return replyDtos;
		}
   

	
	
    
    // 특정 게시글 댓글 수 가져오기
    public int getReplyCount(int bnum) {
        String sql = "SELECT COUNT(*) AS replyCount FROM reply WHERE bnum = " + bnum;
        try {
        	Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("replyCount");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    
    
    

    
	// 댓글 삭제
    public int deleteReply(int replyId, String writer) {
        String sql = "DELETE FROM reply WHERE reply_id = ? AND writer = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, replyId);
            pstmt.setString(2, writer);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    
    
    
    
    
    
}
