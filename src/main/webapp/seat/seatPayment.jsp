<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>

<%	
	String userID = request.getParameter("user_id");
	int purchaseSeat = 0; // 구매할 좌석 개수 초기화

	if (userID == null || userID.trim().isEmpty()) {
		out.println("유저 이름이 없습니다.");
		return;
	}

	try {
		// 결제하기 위해 선택한 좌석 수 세기 위해
		String countSql = "SELECT COUNT(*) FROM seat WHERE selected_user = ? AND is_paid = false";
		PreparedStatement countStmt = conn.prepareStatement(countSql);
		countStmt.setString(1, userID);
		ResultSet rs = countStmt.executeQuery();
		
		if (rs.next()) {
			purchaseSeat = rs.getInt(1);
		}
		rs.close();
		countStmt.close();
		
		// 결제 페이지 닉네임 출력하기 위해
		String nicknameSql = "SELECT nickname FROM users WHERE id = ?";
		PreparedStatement nicknameStmt = conn.prepareStatement(nicknameSql);
		nicknameStmt.setString(1, userID);
		ResultSet nicknameRs = nicknameStmt.executeQuery();

		String nickname = "";
		
		if (nicknameRs.next()) {
			nickname = nicknameRs.getString("nickname");
			session.setAttribute("nickname", nickname);
		}

		nicknameRs.close();
		nicknameStmt.close();

		// 결제 처리
		String updateSql = "UPDATE seat SET is_paid = true WHERE selected_user = ? AND is_paid = false";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, userID);
		
		updateStmt.executeUpdate();
		updateStmt.close();

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
	<h1><%=session.getAttribute("nickname") %>님</h1>
	<h2><%= purchaseSeat %>개의 좌석 결제가 완료되었습니다.</h2>
	<p class="mb-4">결제 내역은 마이페이지에서 확인하실 수 있습니다.</p>
	<a href="./" class="btn btn-success me-2">마이페이지 가기</a><!-- 마이페이지 없을 수도... -->
	<a href="../movie/movies.jsp" class="btn btn-primary">영화 목록으로 돌아가기</a>
</body>
</html>
