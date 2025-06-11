<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="dao.ReservationRepository, dto.Reservation, java.util.List" %>

<%
    String userId = (String) session.getAttribute("userId");
/*     if (userId == null) {
        response.sendRedirect("../login.jsp");
        return;
    } */

    ReservationRepository repo = new ReservationRepository(conn);
    List<Reservation> reservations = repo.getReservationsByUserId(userId);
%>

<html>
<head>
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>마이페이지</h2>

    <!-- 사용자 정보 수정 -->
    <form action="updateInfo.jsp" method="post" class="mb-5">
        <div class="mb-3">
            <label>새 비밀번호</label>
            <input type="password" name="password" class="form-control">
        </div>
        <div class="mb-3">
            <label>별명</label>
            <input type="text" name="nickname" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">수정하기</button>
    </form>

    <!-- 예매 내역 -->
    <h4>예매 내역</h4>
    <table class="table">
        <thead>
            <tr>
                <th>영화 제목</th>
                <th>상영관</th>
                <th>시간</th>
                <th>좌석</th>
                <th>취소</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (reservations.isEmpty()) {
        %>
            <tr><td colspan="5">예매 내역이 없습니다.</td></tr>
        <%
            } else {
                for (Reservation r : reservations) {
        %>
            <tr>
                <td><%= r.getMovieTitle() %></td>
                <td><%= r.getScreen() %></td>
                <td><%= r.getTime() %></td>
                <td><%= r.getSeat() %></td>
                <td>
                    <form action="cancelReservation.jsp" method="post">
                        <input type="hidden" name="reservationId" value="<%= r.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">취소</button>
                    </form>
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
