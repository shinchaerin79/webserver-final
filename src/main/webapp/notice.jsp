<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>공지사항</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>   
    <%@ include file="dbconn.jsp" %>
    
    <a href="editNotice.jsp" class="btn btn-primary">공지사항 관리</a>
    <h1>공지사항</h1>
    
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
        try {
            ResultSet rs = null;
            PreparedStatement pstmt = null;
            
        	String sql = "SELECT * FROM notice ORDER BY is_top DESC, writingTime DESC";
       	 	pstmt = conn.prepareStatement(sql);
        	rs = pstmt.executeQuery();

        	while (rs.next()) {
            	String n_id = rs.getString("n_id");
            	String time = rs.getString("writingTime");
            	String n_title = rs.getString("n_title");
            	String n_text = rs.getString("n_text");
            	boolean is_top = rs.getBoolean("is_top");
                    
        %>
        <div class="col">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="card-title"><strong><%= n_title %></strong></h2>
                    <p class="card-text"><%= n_text %></p>
                    <p>작성 일자: <%= time %></p>
                </div>
            </div>
        </div>
        <%
        		}
            } catch (SQLException ex) {
                out.println("공지사항 보기 실패 " + ex.getMessage());
            }
        %>
    </div>
</div>
</body>