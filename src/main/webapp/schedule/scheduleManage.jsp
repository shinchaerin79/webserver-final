<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %> 
<%@ page import="java.util.*, dao.ScheduleRepository, dto.Schedule" %>
 
<%
    String title = request.getParameter("title");
    String time = request.getParameter("time");
    String screen = request.getParameter("screen");

    if (title == null) title = "";
    if (time == null) time = "";
    if (screen == null) screen = "";

    ScheduleRepository dao = new ScheduleRepository(conn);
    List<Schedule> schedules = dao.getFilteredSchedule(title, time, screen);
%>
<div class="container py-4">
<%@ include file="../menu.jsp" %>   

<html>
<head>
    <title>상영 시간표 관리 (관리자)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .section-title {
            margin-top: 40px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 1.3rem;
        }
    </style>
</head>
<body>
<div class="container mt-5">

    <h2 class="mb-4">상영 시간표 관리 (관리자)</h2>

    <!-- 등록 버튼 -->
    <div class="mb-3 text-end">
        <a href="scheduleForm.jsp" class="btn btn-success">상영 시간표 등록</a>
    </div>

    <!-- 검색 폼 -->
    <div class="section-title">상영 시간표 검색</div>
    <form class="row g-3 mb-4" method="get" action="scheduleManage.jsp">
        <div class="col-md-4">
            <input type="text" name="title" class="form-control" placeholder="영화 제목" value="<%= title %>">
        </div>
        <div class="col-md-3">
            <input type="text" name="time" class="form-control" placeholder="상영 시간 (예: 14:00)" value="<%= time %>">
        </div>
        <div class="col-md-3">
            <select name="screen" class="form-select">
                <option value="">상영관 선택</option>
                <option value="1관" <%= screen.equals("1관") ? "selected" : "" %>>1관</option>
                <option value="2관" <%= screen.equals("2관") ? "selected" : "" %>>2관</option>
                <option value="4관" <%= screen.equals("4관") ? "selected" : "" %>>4관</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">검색</button>
        </div>
    </form>

    <!-- 상영 시간표 목록 -->
    <div class="section-title">상영 시간표 목록</div>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>영화 제목</th>
                <th>상영 시간</th>
                <th>상영관</th>
                <th>러닝타임</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (schedules.isEmpty()) {
            %>
            <tr>
                <td colspan="5" class="text-center">검색 결과가 없습니다.</td>
            </tr>
            <%
                } else {
                    for (Schedule s : schedules) {
            %>
            <tr>
                <td><%= s.getTitle() %></td>
                <td><%= s.getTime() %></td>
                <td><%= s.getScreen() %></td>
                <td><%= s.getRuntime() %>분</td>
                <td>
                    <a href="scheduleEdit.jsp?id=<%= s.getId() %>" class="btn btn-warning btn-sm">수정</a>
                    <a href="deleteSchedule.jsp?id=<%= s.getId() %>" 
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

</div>
</body>
</html>
</div>
