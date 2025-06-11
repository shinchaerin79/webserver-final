<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>상영 시간표 등록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>상영 시간표 등록</h2>
    <form method="post" action="addSchedule.jsp">
        <div class="mb-3">
            <label class="form-label">영화 제목</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">상영 시간 (예: 14:00)</label>
            <input type="text" name="time" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">상영관</label>
            <select name="screen" class="form-select" required>
                <option value="">선택</option>
                <option value="1관">1관</option>
                <option value="2관">2관</option>
                <option value="4관">4관</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">러닝타임 (분)</label>
            <input type="number" name="runtime" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">등록</button>
        <a href="scheduleManage.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>
