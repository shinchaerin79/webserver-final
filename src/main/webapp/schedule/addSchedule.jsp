<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %> 
<%@ page import="java.sql.Date, dao.ScheduleRepository, dto.Schedule" %>

<%
    request.setCharacterEncoding("utf-8");

    String title = request.getParameter("title");
    String screen = request.getParameter("screen");
    String time = request.getParameter("time");
    int runtime = Integer.parseInt(request.getParameter("runtime"));
    String dateStr = request.getParameter("date");

    Date date = Date.valueOf(dateStr);  // yyyy-MM-dd 형식 → java.sql.Date

    Schedule schedule = new Schedule();
    schedule.setTitle(title);
    schedule.setScreen(screen);
    schedule.setTime(time);
    schedule.setRuntime(runtime);
    schedule.setDate(date);

    ScheduleRepository repo = new ScheduleRepository(conn);
    boolean result = repo.addSchedule(schedule);

    if (result) {
%>
    <script>
        alert("상영 시간표가 성공적으로 등록되었습니다.");
        location.href = "scheduleManage.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("등록 실패. 다시 시도해주세요.");
        history.back();
    </script>
<%
    }
%>
