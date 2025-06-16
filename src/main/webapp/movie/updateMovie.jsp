<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="../dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // POST 요청이면 수정 처리
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String releaseDate = request.getParameter("releaseDate");
        int length = Integer.parseInt(request.getParameter("length"));
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");

        try {
            String sql = "UPDATE Movie SET name=?, releaseDate=?, length=?, description=?, genre=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, releaseDate);
            pstmt.setInt(3, length);
            pstmt.setString(4, description);
            pstmt.setString(5, genre);
            pstmt.setString(6, id);
            pstmt.executeUpdate();

            response.sendRedirect("editMovie.jsp");
            return;
        } catch (SQLException e) {
            out.println("수정 중 오류 발생: " + e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }

    // GET 요청이면 영화 정보 조회
    String name = "", releaseDate = "", description = "", genre = "";
    int length = 0;

    try {
        String sql = "SELECT * FROM Movie WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            releaseDate = rs.getString("releaseDate");
            length = rs.getInt("length");
            description = rs.getString("description");
            genre = rs.getString("genre");
        } else {
            out.println("<p>영화를 찾을 수 없습니다.</p>");
        }
    } catch (SQLException e) {
        out.println("영화 정보 불러오기 오류: " + e.getMessage());
    }
%>

<html>
<head>
    <title>updateMovie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <%@ include file="../menu.jsp" %>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">영화 수정</h1>
        </div>
    </div>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">영화 이름:</label>
            <input type="text" name="name" class="form-control" value="<%= name %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">개봉 날짜:</label>
            <input type="date" name="releaseDate" class="form-control" value="<%= releaseDate %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">영화 길이 (분):</label>
            <input type="number" name="length" class="form-control" value="<%= length %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">소개:</label>
            <textarea name="description" class="form-control" rows="3"><%= description %></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">장르:</label>
            <input type="text" name="genre" class="form-control" value="<%= genre %>">
        </div>
        <button type="submit" class="btn btn-primary">영화 정보 수정하기</button>
        <a href="editMovie.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>
<%
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
%>
