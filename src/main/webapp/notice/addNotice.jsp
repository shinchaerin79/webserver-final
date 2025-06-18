<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String title = request.getParameter("n_title");
		String content = request.getParameter("n_text");
		String topParam = request.getParameter("top");
		
		boolean is_top = topParam != null && topParam.equals("on"); // 상단 고정처리 용

		String sql = "INSERT INTO notice (n_title, writingTime, n_text, is_top) VALUES (?, CURRENT_TIMESTAMP, ?, ?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setBoolean(3, is_top);
			
			pstmt.executeUpdate();
			pstmt.close();

			response.sendRedirect("notice.jsp"); // 작성 후 영화 목록으로 이동
			return;
            
		} catch (SQLException e) {
			out.println("공지 등록 실패: " + e.getMessage());
		} 
		finally {
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>공지 작성</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="../menu.jsp" %>
    
	<div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">공지 작성</h1>
        </div>
    </div>
    
	<a href="notice.jsp" class="btn btn-primary">공지사항으로 돌아가기</a>
	
	<form method="post">
		<div class="mb-3">
			<label class="form-label">제목:</label>
			<input type="text" name="n_title" class="form-control" required>
		</div>

		<div class="mb-3">
			<label class="form-label">내용:</label>
			<textarea name="n_text" class="form-control" rows="5" required></textarea>
		</div>
		
		<div class="form-check mb-3">
			<input type="checkbox" name="top" class="form-check-input" id="topCheck">
			<label class="form-check-label" for="topCheck">상단에 고정</label>
		</div>
		
		<button type="submit" class="btn btn-success">공지 게시</button>
	</form>
</div>
</body>
</html>
