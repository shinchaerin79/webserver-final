<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ScheduleRepository, dto.Schedule" %>
<%@ include file="../dbconn.jsp" %> 
 
<%
    request.setCharacterEncoding("utf-8");

    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String screen = request.getParameter("screen");
    String time = request.getParameter("time");
    int runtime = Integer.parseInt(request.getParameter("runtime"));
    java.sql.Date date = java.sql.Date.valueOf(request.getParameter("date"));

    Schedule schedule = new Schedule();
    schedule.setId(id);
    schedule.setTitle(title);
    schedule.setScreen(screen);
    schedule.setTime(time);
    schedule.setRuntime(runtime);
    schedule.setDate(date);

    ScheduleRepository dao = new ScheduleRepository(conn);
    boolean result = dao.updateSchedule(schedule);

    if (result) {
%>
    <script>
        alert("수정이 완료되었습니다.");
        location.href = "scheduleManage.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("수정 실패. 다시 시도해주세요.");
        history.back();
    </script>
<%
    }
%>
