<%@ page contentType="text/html; charset=utf-8" %>
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
        <button type="submit" class="btn btn-primary">로그인</button>
        <a href="register.jsp" class="btn btn-secondary">회원가입</a>
    </form>
</div>
</body>
</html>
