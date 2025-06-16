<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="utils.PasswordUtil" %>

<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("../auth/login.jsp");
        return;
    }

    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");

    String encryptedCurrent = PasswordUtil.encrypt(currentPassword);
    String encryptedNew = PasswordUtil.encrypt(newPassword);

    String checkSql = "SELECT * FROM users WHERE username = ? AND password = ?";
    String updateSql = "UPDATE users SET password = ? WHERE username = ?";

    try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
        checkStmt.setString(1, userId);
        checkStmt.setString(2, encryptedCurrent);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, encryptedNew);
                updateStmt.setString(2, userId);
                updateStmt.executeUpdate();
%>
                <script>
                    alert("비밀번호가 성공적으로 변경되었습니다.");
                    location.href = "myPage.jsp";
                </script>
<%
            }
        } else {
%>
            <script>
                alert("기존 비밀번호가 일치하지 않습니다.");
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
