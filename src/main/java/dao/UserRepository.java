package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRepository {
    private Connection conn;

    public UserRepository(Connection conn) {
        this.conn = conn;
    }

    /** 회원가입 */
    public boolean insertUser(String username, String password, String nickname) {
        String sql = "INSERT INTO users (username, password, nickname) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, nickname);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 로그인 (ID + PW) 확인 */
    public String findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT nickname FROM users WHERE username = ? AND password = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("nickname");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 로그인 실패
    }

    /** 회원 정보 수정 */
    public boolean updateUserInfo(String username, String password, String nickname) {
        String sql = "UPDATE users SET password = ?, nickname = ? WHERE username = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, password);
            pstmt.setString(2, nickname);
            pstmt.setString(3, username);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 아이디 중복 확인 */
    public boolean isDuplicateUsername(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // 1개 이상이면 중복
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** 회원 정보 조회 (username으로) */
    public ResultSet getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            return pstmt.executeQuery(); // 호출한 JSP/Java에서 처리
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /** 회원 탈퇴 */
    public boolean deleteUser(String username) {
        String sql = "DELETE FROM users WHERE username = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
