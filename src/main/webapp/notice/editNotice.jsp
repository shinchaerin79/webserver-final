<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");

	String action = request.getParameter("action");
	String n_id = request.getParameter("n_id");
	
	// 상단에 고정하는 기능
	if ("top".equals(action) && n_id != null) {
    	
		boolean is_top = Boolean.parseBoolean(request.getParameter("is_top"));
        
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE notice SET is_top=? WHERE n_id=?");
			pstmt.setBoolean(1, is_top);
			pstmt.setString(2, n_id);
			pstmt.executeUpdate();
			pstmt.close();
		} 
		catch (Exception e) {
			out.println("상단 고정 오류: " + e.getMessage());
		}
	}
	
	// 공지사항 삭제 기능
	else if ("delete".equals(action) && n_id != null) {
			try {
				PreparedStatement pstmt = conn.prepareStatement("DELETE FROM notice WHERE n_id=?");
				pstmt.setString(1, n_id);
				pstmt.executeUpdate();
				pstmt.close();
			} 
			catch (Exception e) {
				out.println("삭제 오류: " + e.getMessage());
			}
	        
		} 
%>

<html>
<head>
    <title>공지사항 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <%@ include file="../menu.jsp" %>   
	<h1>공지사항</h1>
	
	<br>
	<a href="addNotice.jsp" class="btn btn-success">공지사항 작성하기</a>
	<a href="notice.jsp" class="btn btn-primary">공지사항으로 돌아가기</a>
	
	<br>
	<br>

    <div class="row row-cols-1 row-cols-md-3 g-4">
		<%
			try {
				String sql = "SELECT * FROM notice ORDER BY is_top DESC, writingTime DESC";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();

				while (rs.next()) {
					String id = rs.getString("n_id");
					String title = rs.getString("n_title");
					String text = rs.getString("n_text");
					String date = rs.getString("writingTime");
					boolean top = rs.getBoolean("is_top");
		%>
        <div class="col">
            <div class="card h-100">
                <div class="card-body">
					<h5 class="card-title"><%= title %></h5>
					<p class="card-text"><%= text %></p>
					<p>작성일: <%= date %></p>
					
					<!-- 상단에 고정 버튼 -->
					<form method="post" style="display:inline;">
						<input type="hidden" name="action" value="top">
						<input type="hidden" name="n_id" value="<%= id %>">
						<input type="hidden" name="is_top" value="<%= !top %>">
						<button type="submit" class="btn btn-sm <%= top ? "btn-secondary" : "btn-warning" %>">
							<%= top ? "고정 해제" : "상단 고정" %>
						</button>
					</form>
					
					<!-- 공지사항에 삭제 버튼 -->
					<form method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
						<input type="hidden" name="action" value="delete">
						<input type="hidden" name="n_id" value="<%= id %>">
						<button type="submit" class="btn btn-danger btn-sm">삭제</button>
					</form>
                </div>
            </div>
        </div>
        <%
                }
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("공지 불러오기 오류: " + e.getMessage());
            }
        %>
    </div>
</div>
</body>
</html>
