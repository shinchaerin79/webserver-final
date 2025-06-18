<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ScheduleRepository, dto.Schedule" %>
<%@ include file="../dbconn.jsp" %> 
 <div class="container py-4">
<%@ include file="../menu.jsp" %>   
 
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ScheduleRepository repo = new ScheduleRepository(conn);
    Schedule schedule = repo.getAllSchedules().stream()
        .filter(s -> s.getId() == id)
        .findFirst()
        .orElse(null);

    if (schedule == null) {
%>
    <script>alert("해당 상영 정보가 없습니다."); history.back();</script>
<% return; } %>
<html>
<head>
    <title>상영 시간표 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">상영 시간표 수정</h2>

    <form method="post" action="updateSchedule.jsp">
        <input type="hidden" name="id" value="<%= schedule.getId() %>">
        <div class="row g-3 mb-3">
            <div class="col-md-3">
                <input type="text" name="title" class="form-control" value="<%= schedule.getTitle() %>" required>
            </div>
            <div class="col-md-2">
                <input type="text" name="screen" class="form-control" value="<%= schedule.getScreen() %>" required>
            </div>
            <div class="col-md-2">
                <input type="text" name="time" class="form-control" value="<%= schedule.getTime() %>" required>
            </div>
            <div class="col-md-2">
                <input type="number" name="runtime" class="form-control" value="<%= schedule.getRuntime() %>" required>
            </div>
            <div class="col-md-3">
                <input type="date" name="date" class="form-control" value="<%= schedule.getDate() %>" required>
            </div>
        </div>
        <div class="text-end">
            <button type="submit" class="btn btn-primary">수정하기</button>
            <a href="scheduleManage.jsp" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>
</body>
</html>
</div>
