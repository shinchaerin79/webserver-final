<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="dao.UserRepository" %>

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
%>
    <script>
        alert("로그인이 필요합니다.");
        location.href = "../auth/login.jsp";
    </script>
<%
        return;
    }

    UserRepository repo = new UserRepository(conn);
    boolean result = repo.deleteUser(username);

    if (result) {
        session.invalidate(); // 세션 삭제
%>
    <script>
        alert("회원 탈퇴가 완료되었습니다.");
        location.href = "../welcome.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("회원 탈퇴에 실패했습니다.");
        history.back();
    </script>
<%
    }
%>
