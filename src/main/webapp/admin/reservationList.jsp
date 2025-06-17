<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ReservationRepository, dto.Reservation, java.util.List" %>
<%@ include file="../dbconn.jsp" %>

<%
	// 관리자 로그인 확인
	String userId = (String) session.getAttribute("userId");
    if (userId == null || !"admin".equals(userId)) {
        response.sendRedirect("../auth/login.jsp");
        return;
    }

    ReservationRepository dao = new ReservationRepository(conn);
    List<Reservation> reservations = dao.getAllReservationsGroupedByMovie();

    // 이전 영화 제목 저장용 변수 (그룹핑 용도)
    String currentMovie = "";
%>

<div class="container py-4">
<%@ include file="../menu.jsp" %> 

<html>
<head>
    <title>전체 예매 내역 (관리자)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>전체 예매 내역 (영화별)</h2>

    <% for (Reservation r : reservations) {
        if (!r.getMovieTitle().equals(currentMovie)) {
            currentMovie = r.getMovieTitle();
    %>
        <h4 class="mt-4 border-bottom pt-3"><%= currentMovie %></h4>
        <table class="table table-bordered mb-3">
            <thead class="table-light">
                <tr>
                    <th>상영관</th>
                    <th>시간</th>
                    <th>좌석</th>
                    <th>예매자 ID</th>
                    <th>예매 시각</th>
                </tr>
            </thead>
            <tbody>
    <% } %>
                <tr>
                    <td><%= r.getScreen() %></td>
                    <td><%= r.getTime() %></td>
                    <td><%= r.getSeat() %></td>
                    <td><%= r.getUserId() %></td>
                    <td><%= r.getReservedAt() %></td>
                </tr>
    <% 
        // 다음 영화로 넘어갈 때 table 닫기 생략 – 테이블은 위에서 새로 시작됨
    } %>
            </tbody>
        </table>
</body>
</html>
</div>