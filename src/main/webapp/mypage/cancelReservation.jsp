<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="dao.ReservationRepository" %>

<%
    String reservationIdStr = request.getParameter("reservationId");
    int reservationId = Integer.parseInt(reservationIdStr);

    ReservationRepository repo = new ReservationRepository(conn);
    boolean result = repo.cancelReservation(reservationId);

    if (result) {
%>
    <script>
        alert("예매가 취소되었습니다.");
        location.href = "myPage.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("취소 실패. 다시 시도해주세요.");
        history.back();
    </script>
<%
    }
%>
