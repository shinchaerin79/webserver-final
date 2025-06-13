<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="utils.PasswordUtil" %>
<%
    String username = request.getParameter("username");
    String rawPassword = request.getParameter("password");
    String password = PasswordUtil.encrypt(rawPassword);  // 암호화 후 비교

    String sql = "SELECT nickname FROM users WHERE username = ? AND password = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            String nickname = rs.getString("nickname");
            session.setAttribute("username", username);
            session.setAttribute("nickname", nickname);
%>
            <script>
                alert("로그인 성공! 환영합니다, <%= nickname %>님.");
                location.href = "../welcome.jsp"; 
            </script>
<%
        } else {
%>
            <script>
                alert("아이디 또는 비밀번호가 올바르지 않습니다.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("오류 발생. 다시 시도해주세요.");
        history.back();
    </script>
<%
    }
%>
