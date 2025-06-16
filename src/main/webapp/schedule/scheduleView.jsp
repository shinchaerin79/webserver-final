<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %> 
<%@ page import="java.util.*, dao.ScheduleRepository, dto.Schedule" %>
<%@ page import="java.time.*, java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
 
<%
    String selectedDate = request.getParameter("date");
    if (selectedDate == null || selectedDate.isEmpty()) {
        selectedDate = LocalDate.now().toString();  // yyyy-MM-dd 형식
    }

    ScheduleRepository dao = new ScheduleRepository(conn);
    List<Schedule> schedules = dao.getScheduleByDate(selectedDate);
%>
<html>
<head>
    <title>상영 시간표</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .time-button {
            width: 100px;
            margin: 5px;
        }
        .movie-title {
            font-weight: bold;
            margin-top: 30px;
            font-size: 1.3rem;
            color: #333;
        }
        .screen-title {
            font-weight: bold;
            margin-top: 15px;
            font-size: 1.1rem;
            color: #555;
        }
    </style>
</head>
<body>
<div class="container py-4">
<%@ include file="../menu.jsp" %>   

    <h2 class="mb-4">전체 상영 시간표</h2>

    <!-- 날짜 선택 -->
    <form method="get" action="scheduleView.jsp" class="row g-3 mb-4">
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
        <div class="alert alert-warning">선택한 날짜에는 상영 일정이 없습니다.</div>
    <%
        } else {
            // 영화 제목 → 상영관 → 시간 목록으로 그룹화
            Map<String, Map<String, List<Schedule>>> movieMap = new LinkedHashMap<>();
            for (Schedule s : schedules) {
                movieMap.putIfAbsent(s.getTitle(), new LinkedHashMap<>());
                Map<String, List<Schedule>> screenMap = movieMap.get(s.getTitle());
                screenMap.putIfAbsent(s.getScreen(), new ArrayList<>());
                screenMap.get(s.getScreen()).add(s);
            }

            for (String movieTitle : movieMap.keySet()) {
    %>
        <div class="movie-title"><%= movieTitle %></div>
        <%
            Map<String, List<Schedule>> screenMap = movieMap.get(movieTitle);
            for (String screen : screenMap.keySet()) {
        %>
            <div class="screen-title">[<%= screen %>]</div>
            <div class="d-flex flex-wrap mb-3">
                <%
                    for (Schedule s : screenMap.get(screen)) {
                %>
				<%
				    LocalDate showDate = s.getDate().toLocalDate();
				    LocalTime showTime = LocalTime.parse(s.getTime());
				    LocalDateTime showDateTime = LocalDateTime.of(showDate, showTime);
				    LocalDateTime cutoff = showDateTime.minusMinutes(15);
				    boolean canReserve = LocalDateTime.now().isBefore(cutoff);
				%>
				<form action="../seat/selectSeat.jsp" method="get">
				    <input type="hidden" name="scheduleId" value="<%= s.getId() %>">
				    <input type="hidden" name="title" value="<%= s.getTitle() %>">
    				<input type="hidden" name="date" value="<%= s.getDate() %>">
				    <button type="<%= canReserve ? "submit" : "button" %>"
				            class="btn <%= canReserve ? "btn-outline-primary" : "btn-secondary" %> time-button"
				            <%= !canReserve ? "disabled" : "" %>>
				        <%= s.getTime() %> (<%= canReserve ? "예매 가능" : "마감" %>)
				    </button>
				</form>

                <%
                    }
                %>
            </div>
        <%
            }
        }
    }
    %>
</div>
</body>
</html>
