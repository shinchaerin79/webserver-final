<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="mvc.model.reviewDTO" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="java.sql.*" %>
<%
	List<reviewDTO> reviews = (List<reviewDTO>) request.getAttribute("reviews");
	String titleParam = request.getParameter("title");
	
	int movieId = -1;
	
	if (titleParam != null && !titleParam.trim().isEmpty()) {
		String sql = "SELECT * FROM Movie WHERE name = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, titleParam);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			movieId = rs.getInt("id");
		}
		rs.close();
		pstmt.close();
	}
	String encodedTitle = titleParam != null ? java.net.URLEncoder.encode(titleParam, "utf-8") : "";
%>
<html>
<head>
    <title>영화 관람평</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    .review-card {
        margin-bottom: 20px;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        padding: 20px;
        background-color: #ffffff;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .review-header {
        font-weight: 600;
        font-size: 1.2rem;
        margin-bottom: 10px;
    }
    .review-score {
        color: #ffc107; /* gold color for stars */
        margin-bottom: 10px;
    }
    .review-content {
        font-size: 1rem;
        color: #333;
        margin-bottom: 10px;
        white-space: pre-wrap;
    }
    .review-time {
        font-size: 0.85rem;
        color: #888;
        text-align: right;
    }
</style>
<body>
<div class="container py-4">
	<%@ include file="../menu.jsp" %> 
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
        	<h1 class="display-5 fw-bold">영화 관람평</h1>  
      	</div>
    </div>

    <button 
    onclick="location.href='addReview.do?title=<%= encodedTitle %>&movie_id=<%= movieId %>'"
    class="btn btn-success">
    관람평 작성하러 가기
</button>
    <br>
	
    <%
        if (reviews == null || reviews.isEmpty()) {
    %>
    	<br>
        <h3>아직 작성된 관람평이 없습니다.</h3>
        <p>관람평을 작성해주세요.</p>
    <%
        } else {
    %>	
    	
    
            <%
    			for (reviewDTO review : reviews) {
			%>
			    <br>
    			<div class="review-card">
        			<div class="review-header"><%= review.getUsername() %></div>
        			<div class="review-score">
            			<% for (int i = 0; i < review.getScope(); i++) { %>
                			★
            			<% } %>
            			<% for (int i = review.getScope(); i < 5; i++) { %>
                			☆
            			<% } %>
        			</div>
        		<div class="review-content"><%= review.getContents() %></div>
        		<div class="review-time"><%= review.getWritingTime() %></div>
   	 		</div>
          <%
              }
			%>
       <%
          }
    	%>
</div>
</body>
</html>
