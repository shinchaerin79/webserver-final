<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>

<%
	String username = request.getParameter("user_id"); // 예: cofls
	int purchaseSeat = 0;

	if (username == null || username.trim().isEmpty()) {
		out.println("유저 이름이 없습니다.");
		return;
	}

	Long realUserId = null;

	try {
		// 1. username으로 숫자 ID 조회
		String idSql = "SELECT id, nickname FROM users WHERE username = ?";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, username);
		ResultSet idRs = idStmt.executeQuery();

		String nickname = "";

		if (idRs.next()) {
			realUserId = idRs.getLong("id");
			nickname = idRs.getString("nickname");
			session.setAttribute("nickname", nickname);
		} else {
			out.println("해당 사용자 정보가 없습니다.");
			return;
		}

		idRs.close();
		idStmt.close();

		// 2. 결제할 좌석 수 세기
		String countSql = "SELECT COUNT(*) FROM seat WHERE selected_user = ? AND is_paid = false";
		PreparedStatement countStmt = conn.prepareStatement(countSql);
		countStmt.setString(1, username);
		ResultSet rs = countStmt.executeQuery();

		if (rs.next()) {
			purchaseSeat = rs.getInt(1);
		}
		rs.close();
		countStmt.close();

		// 3. 결제 처리
		String updateSql = "UPDATE seat SET is_paid = true WHERE selected_user = ? AND is_paid = false";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, username);
		updateStmt.executeUpdate();
		updateStmt.close();

		// 4. reservation 테이블에 예매 내역 저장
		String insertSql = "INSERT INTO reservation (seat_number, schedule_id, user_id) " +
		                   "SELECT CAST(seat_number AS CHAR), schedule_id, ? " +
		                   "FROM seat WHERE selected_user = ? AND is_paid = true";
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setLong(1, realUserId);  // 숫자형 user_id
		insertStmt.setString(2, username);  // selected_user는 여전히 username
		insertStmt.executeUpdate();
		insertStmt.close();

		conn.close();
	} catch (Exception e) {
		out.println("에러 발생: " + e.getMessage());
		return;
	}
%>

<html>
<head>
	<title>결제 결과</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5 text-center">
	<h1><%= session.getAttribute("nickname") %>님</h1>
	<h2><%= purchaseSeat %>개의 좌석 결제가 완료되었습니다.</h2>
	<p class="mb-4">결제 내역은 마이페이지에서 확인하실 수 있습니다.</p>
	<a href="../mypage/myPage.jsp" class="btn btn-success me-2">마이페이지 가기</a>
	<a href="../movie/movies.jsp" class="btn btn-primary">영화 목록으로 돌아가기</a>
</body>
</html>
