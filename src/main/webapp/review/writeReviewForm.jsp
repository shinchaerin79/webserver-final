<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="mvc.model.reviewDTO" %>
<%@ page import="java.util.List" %>
<%@ include file="../dbconn.jsp" %>

<html>
<head>
    <title>영화 관람평</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
	List<reviewDTO> reviews = (List<reviewDTO>) request.getAttribute("reviews");
    String title = request.getParameter("title");
    Long movie_id = null;

    if (title != null) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT id FROM Movie WHERE name = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            rs = stmt.executeQuery();
            if (rs.next()) {
                movie_id = rs.getLong("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        }
    }
    

    String nickName = (String) session.getAttribute("nickname");
    if (nickName == null) {
        String currentURL = request.getRequestURI();
        String query = request.getQueryString();
        String redirectURL = currentURL + (query != null ? "?" + query : "");

        String msg = java.net.URLEncoder.encode("로그인이 필요합니다. 로그인 후 이용해주세요.", "UTF-8");
        String encodedRedirect = java.net.URLEncoder.encode(redirectURL, "UTF-8");

        response.sendRedirect(request.getContextPath() + "/auth/login.jsp?msg=" + msg + "&redirect=" + encodedRedirect);
        return;
    }

%>
<body>
<div class="container py-4">
	<%@ include file="../menu.jsp" %>  
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
        	<h1 class="display-5 fw-bold"> <%= title %> 영화 관람평</h1>  
      	</div>
    </div>
    <div class="card-body">
    	<% if (movie_id == null) { %>
    		<p class="text-danger">영화 정보를 찾을 수 없습니다. 잘못된 접근입니다.</p>
		<% } 
    		else { 
	
	%>
                <form action="<%= request.getContextPath() %>/addReview.do" method="post">
                    <input type="hidden" name="username" value="<%=nickname%>">
                    <input type="hidden" name="movie_id" value="<%= movie_id != null ? movie_id : "" %>">
                    <input type="hidden" name="title" value="<%= title %>">

                    <div class="mb-3">
                        <label class="form-label">평점</label>
                        <select name="scope">
                        <option value="1">*</option>
                        <option value="2">**</option>
                        <option value="3">***</option>
                        <option value="4">****</option>
                        <option value="5" selected>*****</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">내용</label>
                        <textarea name="contents" class="form-control" rows="6" required></textarea>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success">리뷰 작성 완료</button>
                    </div>
                </form>
                <% } %>
            </div>
        </div>
</div>
</body>
</html>
