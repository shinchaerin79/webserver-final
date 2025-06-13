<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="utils.PasswordUtil" %>
<%
    String username = request.getParameter("username");
    String rawPassword = request.getParameter("password");
    String password = PasswordUtil.encrypt(rawPassword);  // 암호화
    String nickname = request.getParameter("nickname");

    String sql = "INSERT INTO users (username, password, nickname) VALUES (?, ?, ?)";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        pstmt.setString(3, nickname);
        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
            <script>
                alert("회원가입이 완료되었습니다.");
                location.href = "login.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("회원가입 실패. 다시 시도하세요.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("오류 발생. 다시 시도하세요.");
        history.back();
    </script>
<%
    }
%>
