<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ScheduleRepository" %>
<%@ include file="../dbconn.jsp" %> 

<%
    int id = Integer.parseInt(request.getParameter("id"));

    ScheduleRepository repo = new ScheduleRepository(conn);
    boolean result = repo.deleteSchedule(id);

    if (result) {
%>
    <script>
        alert("삭제가 완료되었습니다.");
        location.href = "scheduleManage.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("삭제 실패. 다시 시도해주세요.");
        history.back();
    </script>
<%
    }
%>
