<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="dao.UserRepository" %>

<%
    String userId = (String) session.getAttribute("userId");
    String password = request.getParameter("password");
    String nickname = request.getParameter("nickname");

    if (userId != null && password != null && nickname != null) {
        UserRepository repo = new UserRepository(conn);
        boolean updated = repo.updateUserInfo(userId, password, nickname);
        if (updated) {
%>
    <script>
        alert("정보가 수정되었습니다.");
        location.href = "myPage.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("수정 실패. 다시 시도해주세요.");
        history.back();
    </script>
<%
        }
    }
%>
