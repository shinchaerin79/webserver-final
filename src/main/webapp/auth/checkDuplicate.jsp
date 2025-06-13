<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="dao.UserRepository" %>

<%
    String username = request.getParameter("username");
    if (username == null || username.trim().isEmpty()) {
        out.print("empty");
        return;
    }

    UserRepository repo = new UserRepository(conn);
    boolean isDuplicate = repo.isDuplicateUsername(username);

    if (isDuplicate) {
        out.print("duplicated");  // 이미 존재
    } else {
        out.print("available");   // 사용 가능
    }
%>
