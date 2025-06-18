<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>

<%
    String userId = (String) session.getAttribute("userId");
System.out.println("세션 userId 값: " + userId);

    if (userId == null) {
        response.sendRedirect("../auth/login.jsp");
        return;
    }

    String newNickname = request.getParameter("nickname");
    System.out.println("입력된 닉네임: " + newNickname);

    String checkSql = "SELECT nickname FROM users WHERE username = ?";
    String updateSql = "UPDATE users SET nickname = ? WHERE username = ?";

    try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
        checkStmt.setString(1, userId);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            String currentNickname = rs.getString("nickname");
            System.out.println("현재 닉네임: " + currentNickname);

            if (currentNickname.equals(newNickname)) {
%>
                <script>
                    alert("기존 닉네임과 같습니다.");
                    history.back();
                </script>
<%
            } else {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, newNickname);
                    updateStmt.setString(2, userId);
                    System.out.println("닉네임 변경 시도: " + currentNickname + " ➡ " + newNickname);
                    int result = updateStmt.executeUpdate();
                    System.out.println("변경된 행 수: " + result);
                    updateStmt.executeUpdate();
                    session.setAttribute("nickname", newNickname);
%>
                    <script>
                        alert("닉네임이 성공적으로 변경되었습니다.");
                        location.href = "myPage.jsp";
                    </script>
<%
                }
            }
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
