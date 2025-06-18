package mvc.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import mvc.database.DBConnection;

public class reviewDAO {	

    public List<reviewDTO> getReviewsByMovie(Long movieId) {
    	List<reviewDTO> list = new ArrayList<>();
        
    	try {
    		Connection conn = DBConnection.getConnection();
    		String sql = "SELECT * FROM reviewdata WHERE movie_id = ? ORDER BY writingTime DESC";
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		pstmt.setLong(1, movieId);
    		
    		System.out.println(">> DB 연결 성공");
    		
    		ResultSet rs = pstmt.executeQuery();
    		
    		
    		while (rs.next()) {
    			reviewDTO r = new reviewDTO();
    			
    			r.setReview_id(rs.getLong("review_id"));
    			r.setUsername(rs.getString("username"));
    			r.setMovie_id(rs.getInt("movie_id"));
    			r.setWritingTime(rs.getTimestamp("writingTime"));
    			r.setScope(rs.getInt("scope"));
    			r.setContents(rs.getString("contents"));
    			
    			list.add(r);
            }
    		rs.close();
    		
            System.out.println(">>> 리뷰 목록 불러오기 성공");

        } catch (Exception e) {
        	System.out.println(">>> 리뷰 목록 불러오기 중 오류 발생");
            e.printStackTrace();
        }
        
    	return list;
	}
    
	public void insertReview(reviewDTO review) {
		
    	try {
        	Connection conn = DBConnection.getConnection();
        	String sql = "INSERT INTO reviewdata (username, movie_id, scope, contents, writingTime) VALUES (?, ?, ?, ?, now())";
        	PreparedStatement pstmt = conn.prepareStatement(sql);
        	
        	pstmt.setString(1, review.getUsername());
        	pstmt.setInt(2, review.getMovie_id());
        	pstmt.setInt(3, review.getScope());
        	pstmt.setString(4, review.getContents());
        	
        	pstmt.executeUpdate();
        	
        	pstmt.close();
        	conn.close();
            
        } catch (Exception e) {
            System.out.println(">>> 리뷰 저장 중 오류 발생");
            e.printStackTrace();
        }
    }

    
	public Long getMovieIdByTitle(String title) {
        Long id = null;

        try {
        	Connection conn = DBConnection.getConnection();
        	String sql = "SELECT id FROM Movie WHERE name = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
            	id = rs.getLong("id");
            	
                System.out.println(">>> 영화 제목으로 ID 찾음: " + id);
                
            } else {
                System.out.println(">>> 해당 영화 제목 없음");
            }
            rs.close();
            pstmt.close();
            conn.close(); 
            
        } catch (Exception e) {
            System.out.println(">>> 영화 ID 찾는 중 오류 발생");
            e.printStackTrace();
        }

        return id;
    }
}
