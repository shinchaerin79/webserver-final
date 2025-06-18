<%@ page contentType="text/html; charset=utf-8" %>
<%
    String nickname = (String) session.getAttribute("nickname");
%>

<div class="container mt-2 mb-1 d-flex justify-content-between align-items-center">
	<div>
        <a href="<%= request.getContextPath() %>/welcome.jsp">
            <img src="<%= request.getContextPath() %>/resources/images/logo.png" alt="로고" style="height: 80px;">
        </a>
    </div>
    
    <div class="text-end">
	    <% if (nickname != null) { %>
	        <span><%= nickname %> 님</span>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
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
	</div>

<header class ="pb-3 mb-5 border-bottom">
	<div class="container">
        <div class="d-flex flex-wrap justify-content-center align-items-center">
            <ul class="nav nav-pills gap-xxl-5 fs-5">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/movie/movies.jsp" class="nav-link">영화 목록</a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/notice/notice.jsp" class="nav-link">공지사항</a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/schedule/scheduleView.jsp" class="nav-link">바로 예매</a>
                </li>
            </ul>
		</div>
	</div>
</header>