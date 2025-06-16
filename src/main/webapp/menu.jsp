<%@ page contentType="text/html; charset=utf-8" %>
<%
    String nickname = (String) session.getAttribute("nickname");
	String currentUserId = (String) session.getAttribute("userId"); 
%>

<div class="container mt-2 mb-1 text-end">
    <% if (nickname != null) { %>
        <span><%= nickname %> 님</span>
        <% if ("admin".equals(currentUserId)) { %>
            |
            <a href="<%= request.getContextPath() %>/admin/admin.jsp" class="text-decoration-none text-danger fw-bold">관리자 페이지</a>
        <% } %>
        |
        <a href="<%= request.getContextPath() %>/mypage/myPage.jsp" class="text-decoration-none">마이페이지</a>
        |
        <a href="<%= request.getContextPath() %>/auth/logout.jsp" class="text-decoration-none">로그아웃</a>
    <% } else { %>
        <a href="<%= request.getContextPath() %>/auth/login.jsp" class="text-decoration-none">로그인</a>
        |
        <a href="<%= request.getContextPath() %>/auth/register.jsp" class="text-decoration-none">회원가입</a>
    <% } %>
</div>

<header class ="pb-3 mb-4 border-bottom">
	<div class="container">
		<div class="d-flex flex-wrap align-itmes-center justify-content-center justify-content-lg-start">
			<a href="../welcome.jsp" class="d-flex align-items-center text-dark text-decoration-none">
				<svg width="32" height="32" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
					<path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5Z"/>
			  		<path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z"/>
			  	</svg>
				<span class="fs-4">Home</span>
			</a>
			<ul class="nav nav-pills">
			    <li class="nav-items"><a href="<%= request.getContextPath() %>/movie/movies.jsp" class="nav-link">영화 목록</a></li>
			    <li class="nav-items"><a href="<%= request.getContextPath() %>/notice/notice.jsp" class="nav-link">공지사항</a></li>
			    <li class="nav-items"><a href="<%= request.getContextPath() %>/schedule/scheduleView.jsp" class="nav-link">바로 예매</a></li>

			
			</ul>
		</div>
	</div>
</header>