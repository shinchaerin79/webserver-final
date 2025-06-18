<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Movies</title>
    <script>
    	function toggleDesc(id) {
        	
    		const desc = document.getElementById('desc-' + id);
        	const btn = event.target;
        	
        	if (desc.style.maxHeight === "60px") {
            	desc.style.maxHeight = "500px";
            	btn.innerText = "접기";
        	} 
        	
        	else {
            	desc.style.maxHeight = "60px";
           		btn.innerText = "더보기";
        	}
    	}
	</script>
    
</head>
<body>
<div class="container py-4">
	<%@ include file="../menu.jsp" %>   
    <%@ include file="../dbconn.jsp" %>

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
                        
						int movieId=Integer.parseInt(id);

                %>
    				<div class="col">
    					<div class="card h-100 text-center">
        					<div class="card-body d-flex flex-column">
								<img src='../resources/images/<%=posterName %>' class="card-img-top mb-2" style="height: 500px; width: 100%; object-fit: cover;">
								<h5 class="card-title"><%= name %></h5>
            
            					<div style="position: relative;">
									<p id="desc-<%=id%>" class="card-text" style="max-height: 60px; overflow: hidden; text-overflow: ellipsis; transition: max-height 0.3s ease;">
     									<%= description != null ? description : "설명이 없습니다." %>
                					</p>
                					
									<% 
										if (description != null && description.length() > 60) { 
									%>
										<button class="btn btn-link p-0" onclick="toggleDesc('<%=id%>')">더보기</button>
									<% 
										} 
									%>
            					</div>

            					<p><strong>개봉일:</strong> <%= releaseDate %> &nbsp;&nbsp; 영상 길이: <%= length %>분</p>
            					<p><strong>장르:</strong> <%= genre != null ? genre : "장르 미정" %></p>
            					<p> 
									<a href="../reviewList.do?title=<%= java.net.URLEncoder.encode(name, "utf-8") %>&movie_id=<%= movieId %>" class="btn btn-secondary btn-sm mt-auto">리뷰</a> 
									<a href="../schedule/movieSchedule.jsp?title=<%= java.net.URLEncoder.encode(name, "utf-8") %>" class="btn btn-primary btn-sm mt-auto">영화 예매하러 가기</a>
								</p>
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
</div>
</body>
</html>
