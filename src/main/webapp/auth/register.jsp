<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>회원가입</h2>
    <form method="post" action="registerProcess.jsp">
        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">닉네임</label>
            <input type="text" name="nickname" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">가입하기</button>
        <a href="login.jsp" class="btn btn-secondary">로그인하러 가기</a>
    </form>
</div>
</body>
</html>
