<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	<title>editMovie</title>
	<script type="text/javascript">
    function deleteMovie(id) {
        if (confirm("정말로 이 영화를 삭제하시겠습니까?")) {
            window.location.href = "deleteMovie.jsp?id=" + id;
        }
    }
</script>
</head>
<body>
<div class="container py-4">
	<%@ include file="menu.jsp" %>   
	<%@ include file="dbconn.jsp" %>
	
	<div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
        	<h1 class="display-5 fw-bold">영화 추가/수정/삭제</h1>   
      	</div>
    </div>
    <a href="addMovie.jsp" class="btn btn-primary">영화 추가</a>
    
    <%
            ResultSet rs = null;
            PreparedStatement stmt = null;
            try {
                String sql = "SELECT * FROM Movie";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
	%>
             	<div class="row row-cols-1 row-cols-md-3 g-4">
                <%
                    while (rs.next()) {
                        String id = rs.getString("id");
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        String releaseDate = rs.getString("releaseDate");
                        int length = rs.getInt("length");
                        String genre = rs.getString("genre");
                        String posterName = rs.getString("posterName");
                %>
    				<div class="col">
    					<div class="card h-100 text-center" style="height: 700px;"> <!-- 전체 카드 높이 고정 -->
        					<div class="card-body d-flex flex-column" style="overflow: hidden;">
            					<img src='./resources/images/<%=posterName %>' class="card-img-top mb-2" style="height: 500; width: 100%; object-fit: cover;">
            					<h5 class="card-title"><%= name %></h5>
            					<p class="card-text" style="flex-grow: 1; overflow: hidden; text-overflow: ellipsis; max-height: 60px;">
                					<%= description != null ? description : "설명이 없습니다." %>
            					</p>
            					<p><strong>개봉일:</strong> <%= releaseDate %> &nbsp;&nbsp; 영상 길이: <%= length %>분</p>
            					<p><strong>장르:</strong> <%= genre != null ? genre : "장르 미정" %></p>
            					<div class="mt-auto">
                				<a href="updateMovie.jsp?id=<%= id %>" class="btn btn-primary btn-sm">영화 수정</a>
                				<a href="#" onclick="deleteMovie('<%=id %>')" class="btn btn-danger btn-sm">영화 삭제</a>
            				</div>
        				</div>
    				</div>
    			</div>  
     <%
                }
            } catch (SQLException ex) {
                out.println("영화 목록 보기 실패: " + ex.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        %>
</div>
</body>
</html>