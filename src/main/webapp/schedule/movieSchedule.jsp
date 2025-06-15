<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.time.*, java.time.format.DateTimeFormatter" %>
<%
    String userId = (String) session.getAttribute("userId");

    if (userId == null) {
        String title = request.getParameter("title");
        String redirect = "../schedule/movieSchedule.jsp?title=" + java.net.URLEncoder.encode(title, "UTF-8");
        String msg = java.net.URLEncoder.encode("로그인이 필요합니다. 로그인 후 이용해주세요.", "UTF-8");
        response.sendRedirect("../auth/login.jsp?msg=" + msg + "&redirect=" + java.net.URLEncoder.encode(redirect, "UTF-8"));
        return;
    }
%>

<%@ include file="../dbconn.jsp" %>
<%@ page import="java.util.*, dao.ScheduleRepository, dto.Schedule" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.time.LocalDate" %>

<%
    String title = request.getParameter("title");
    String selectedDate = request.getParameter("date");

    if (selectedDate == null || selectedDate.isEmpty()) {
        selectedDate = LocalDate.now().toString();
    }

    if (title != null) {
        title = URLDecoder.decode(title, "UTF-8");
    }

    ScheduleRepository dao = new ScheduleRepository(conn);
    List<Schedule> schedules = dao.getScheduleByTitleAndDate(title, selectedDate);
%>

<html>
<head>
    <title><%= title %> 상영 시간표</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2><%= title %> - 상영 시간표</h2>

    <form method="get" action="movieSchedule.jsp" class="row g-3 mb-4">
        <input type="hidden" name="title" value="<%= title %>">
        <div class="col-md-4">
            <input type="date" name="date" class="form-control" value="<%= selectedDate %>">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary">날짜 선택</button>
        </div>
    </form>

    <h5>선택한 날짜: <%= selectedDate %></h5>

    <%
        if (schedules.isEmpty()) {
    %>
        <div class="alert alert-warning">해당 영화는 선택한 날짜에 상영되지 않습니다.</div>
    <%
        } else {
            Map<String, List<Schedule>> screenMap = new LinkedHashMap<>();
            for (Schedule s : schedules) {
                screenMap.putIfAbsent(s.getScreen(), new ArrayList<>());
                screenMap.get(s.getScreen()).add(s);
            }

            for (String screen : screenMap.keySet()) {
    %>
        <div class="mb-2 fw-bold">[<%= screen %>]</div>
        <div class="d-flex flex-wrap mb-4">
            <%
                for (Schedule s : screenMap.get(screen)) {
            %>
			<%
			    LocalDate showDate = s.getDate().toLocalDate();
			    LocalTime showTime = LocalTime.parse(s.getTime()); // "HH:mm"
			    LocalDateTime showDateTime = LocalDateTime.of(showDate, showTime);
			    LocalDateTime cutoff = showDateTime.minusMinutes(15);
			    boolean canReserve = LocalDateTime.now().isBefore(cutoff);
			%>
			<form action="selectSeat.jsp" method="get">
			    <input type="hidden" name="scheduleId" value="<%= s.getId() %>">
			    <button type="<%= canReserve ? "submit" : "button" %>"
			            class="btn <%= canReserve ? "btn-outline-primary" : "btn-secondary" %> me-2 mb-2"
			            <%= !canReserve ? "disabled" : "" %>>
			        <%= s.getTime() %> (<%= canReserve ? "예매 가능" : "예매 마감" %>)
			    </button>
			</form>

            <%
                }
            %>
        </div>
    <%
            }
        }
    %>
</div>
</body>
</html>
