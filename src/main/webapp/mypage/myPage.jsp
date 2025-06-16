<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="dao.ReservationRepository, dto.Reservation, java.util.List" %>

<%
	String username = (String) session.getAttribute("userId");
	if (username == null) {
		response.sendRedirect("../auth/login.jsp");
	    return;
	}

	Long userId = null;
	String findIdSql = "SELECT id FROM users WHERE username = ?";
	PreparedStatement pstmt = conn.prepareStatement(findIdSql);
	pstmt.setString(1, username);
	ResultSet rs = pstmt.executeQuery();

	if (rs.next()) {
	    userId = rs.getLong("id");
	} else {
	    out.println("존재하지 않는 사용자입니다.");
	    return;
	}
	rs.close();
	pstmt.close();

	ReservationRepository repo = new ReservationRepository(conn);
	List<Reservation> reservations = repo.getReservationsByUserId(String.valueOf(userId)); // 또는 userId.toString()
%>

<%
    Object uid = session.getAttribute("userId");
%>

<html>
<head>
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
<%@ include file="../menu.jsp" %> 
    <h2>마이페이지</h2>

<!-- 비밀번호 변경 -->
<h4>비밀번호 변경</h4>
<form action="updatePassword.jsp" method="post" class="mb-5">
    <div class="mb-3">
        <label>기존 비밀번호</label>
        <input type="password" name="currentPassword" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>새 비밀번호</label>
        <input type="password" name="newPassword" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-primary">비밀번호 변경</button>
</form>

<!-- 닉네임 변경 -->
<h4>닉네임 변경</h4>
<form action="updateNickname.jsp" method="post" class="mb-5">
    <div class="mb-3">
        <label>새 닉네임</label>
        <input type="text" name="nickname" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-secondary">닉네임 변경</button>
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
                <th>예매 일시</th>
                <th>취소</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (reservations.isEmpty()) {
        %>
            <tr><td colspan="6">예매 내역이 없습니다.</td></tr>
        <%
            } else {
                for (Reservation r : reservations) {
        %>
            <tr>
                <td><%= r.getMovieTitle() %></td>
                <td><%= r.getScreen() %></td>
                <td><%= r.getTime() %></td>
                <td><%= r.getSeat() %></td>
                <td><%= r.getReservedAt() %></td>
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
    
    <a href="deleteUser.jsp" class="btn btn-danger" onclick="return confirm('정말 탈퇴하시겠습니까?')">회원 탈퇴</a>
    
</div>
</body>
</html>
