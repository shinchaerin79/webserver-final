<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import ="java.sql.*"%>
<%@ include file ="dbconn.jsp" %>

<%
	request.setCharacterEncoding("utf-8");

	if(request.getMethod().equalsIgnoreCase("POST")){
		String realFolder = application.getRealPath("/resources/images");
		String encType="utf-8";
		
		int maxSize=5*1024*1024;
		MultipartRequest multi=new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
        
		// 이후 multi에서 파라미터를 받아야 함
        String name = multi.getParameter("name");
        String releaseDate = multi.getParameter("releaseDate");
        String lengthStr = multi.getParameter("length");
        int length = (lengthStr == null || lengthStr.isEmpty()) ? 0 : Integer.parseInt(lengthStr);  // 값이 없으면 기본 0
        String description = multi.getParameter("description");
        String genre = multi.getParameter("genre");
        
		Enumeration files = multi.getFileNames();
		String fname=(String)files.nextElement();
		String fileName=multi.getFilesystemName(fname);
		
		String sql = "INSERT INTO movie (name, releaseDate, length, description, genre, posterName) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, releaseDate);
        pstmt.setInt(3, length);
        pstmt.setString(4, description);
        pstmt.setString(5, genre);
        pstmt.setString(6, fileName);
        pstmt.executeUpdate();


        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}

        response.sendRedirect("editMovie.jsp"); // 성공 후 목록으로 이동
        return;
	}
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	<title>addMovie</title>
</head>
<body>
<div class="container py-4">
	<%@ include file="menu.jsp" %>   
	<div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
        	<h1 class="display-5 fw-bold">영화 추가</h1>   
      	</div>
    </div>
    <form method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">영화 이름:</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">개봉 날짜:</label>
            <input type="date" name="releaseDate" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">영화 길이 (분):</label>
            <input type="number" name="length" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">소개:</label>
            <textarea name="description" class="form-control" rows="3"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">장르:</label>
            <input type="text" name="genre" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">포스터 사진:</label>
            <input type="file" name="poster" class="form-control" accept="image/*">
        </div>
        <button type="submit" class="btn btn-success">영화 추가하기</button>
    </form>
    
</div>
</body>
</html>
