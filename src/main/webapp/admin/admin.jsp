<%@ page contentType="text/html; charset=utf-8" %>

<%
if (!"admin".equals(session.getAttribute("userId"))) {
    response.sendRedirect("../auth/login.jsp");
    return;
}
%>
<div class="container py-4">
<%@ include file="../menu.jsp" %> 
<html>
<head>
    <title>관리자 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>관리자 기능</h2>
    <div class="d-grid gap-3 col-6 mx-auto mt-4">
        <a href="../movie/editMovie.jsp" class="btn btn-outline-primary">영화 목록 관리</a>
        <a href="../notice/editNotice.jsp" class="btn btn-outline-primary">공지사항 관리</a>
        <a href="../schedule/scheduleManage.jsp" class="btn btn-outline-primary">상영 시간표 관리</a>
        <a href="../admin/reservationList.jsp" class="btn btn-outline-primary">전체 사용자 영화별 예매 내역 조회</a>

    </div>
</div>
</body>
</html>
</div>
