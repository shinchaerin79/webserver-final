<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>

<%
	String scheduleIdStr = request.getParameter("scheduleId");
	
	//에로 확인 용
	if (scheduleIdStr == null) {
        out.println("ERROR: schedule_id가 없습니다.");
        return;
    }

    int scheduleId = 0;
    
    try {
        scheduleId = Integer.parseInt(scheduleIdStr);
    } 
    catch (NumberFormatException e) {
        out.println("ERROR: schedule_id가 유효하지 않습니다.");
        return;
    }

    if (conn == null) {
        out.println("DB 연결 실패 (conn == null)");
        return;
    }

	try {
		String checkSql = "SELECT COUNT(*) FROM seat WHERE schedule_id = ?";
		PreparedStatement checkStmt = conn.prepareStatement(checkSql);
		checkStmt.setInt(1, scheduleId);
		ResultSet checkRs = checkStmt.executeQuery();
		
		checkRs.next();

		int count = checkRs.getInt(1);
		
        //초기 좌석 배치 데이터 삽입->영화,상영시간 새로 생길 때마다 만들어짐
		if (count == 0) {
			String insertSql = "INSERT INTO seat (seat_number, schedule_id, is_paid, selected_user) VALUES (?, ?, false, null)";
			PreparedStatement insertStmt = conn.prepareStatement(insertSql);
			
            // 적당히 70개 좌석 배치함
			for (int seatNum = 1; seatNum <= 70; seatNum++) {
				insertStmt.setInt(1, seatNum);
				insertStmt.setInt(2, scheduleId);
				
				insertStmt.executeUpdate();
			}

			insertStmt.close();
		}          

		checkRs.close();
		checkStmt.close();
		conn.close();
    } catch (Exception e) {
        e.printStackTrace();  // 콘솔에 에러 로그
        out.println("에러 발생: " + e.toString());
    }
%>
