<%@ page contentType="text/html; charset=utf-8" %>
<%
    String msg = request.getParameter("msg");
	String redirect = request.getParameter("redirect");

    if (msg != null && !msg.isEmpty()) {
%>
    <div class="alert alert-warning text-center" style="margin: 20px;">
        <%= msg %>
    </div>
<%
    }
%>
<div class="container py-4">
<%@ include file="../menu.jsp" %>   
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>로그인</h2>
    <form method="post" action="loginProcess.jsp">
        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <% if (redirect != null && !redirect.isEmpty()) { %>
            <input type="hidden" name="redirect" value="<%= redirect %>">
        <% } %>

        <button type="submit" class="btn btn-primary">로그인</button>
        <a href="register.jsp" class="btn btn-secondary">회원가입</a>
    </form>
</div>
</body>
</html>
</div>
