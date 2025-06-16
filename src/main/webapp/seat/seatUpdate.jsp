<%@ page contentType="text/plain; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>

<%
	String seatNumberStr = request.getParameter("seat_number");
	String userId = request.getParameter("user_id");
	String scheduleIdStr = request.getParameter("scheduleId");

	if (seatNumberStr == null || userId == null || scheduleIdStr == null ||
    	seatNumberStr.trim().isEmpty() || userId.trim().isEmpty() || scheduleIdStr.trim().isEmpty()) {
    	out.print("ERROR: Missing or empty parameters");
    	return;
	}

	int seatNumber = 0;
	int scheduleId = 0;

	try {
    	seatNumber = Integer.parseInt(seatNumberStr);
    	scheduleId = Integer.parseInt(scheduleIdStr);
	} 
	catch (NumberFormatException e) {
    	out.print("ERROR: Invalid number format");
    	return;
	}


    try {
    	String checkSql = "SELECT selected_user FROM seat WHERE seat_number = ? AND schedule_id = ?";
    	PreparedStatement checkStmt = conn.prepareStatement(checkSql);
    	checkStmt.setInt(1, seatNumber);
    	checkStmt.setInt(2, scheduleId);
    	ResultSet rs = checkStmt.executeQuery();

    	if (rs.next()) {
    	    String selectedUser = rs.getString("selected_user");
			
    	    // 좌석 선택시 색 초록->회색 선택 메시지
    	    if (selectedUser == null) {
    	        String updateSql = "UPDATE seat SET selected_user = ? WHERE seat_number = ? AND schedule_id = ?";
    	        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
    	        updateStmt.setString(1, userId);
    	        updateStmt.setInt(2, seatNumber);
    	        updateStmt.setInt(3, scheduleId);
    	        updateStmt.executeUpdate();
    	        out.print("SELECTED");
    	    } 
    	    
    	    // 좌석 취소 시 회색->초록 선택 해체 메시지
    	    else if (selectedUser.equals(userId)) {
    	        String updateSql = "UPDATE seat SET selected_user = NULL WHERE seat_number = ? AND schedule_id = ?";
    	        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
    	        updateStmt.setInt(1, seatNumber);
    	        updateStmt.setInt(2, scheduleId);
    	        updateStmt.executeUpdate();
    	        out.print("UNSELECT");
    	    } 
    	    
    	    // 혹시 모를 오류 대비 이미 선택되었다는 메시지
    	    else {
    	        out.print("ALREADY_SELECTED");
    	    }
    	    
    	    // 혹시 모를 오류 대비
    	} else {
    	    out.print("NOT_FOUND");
    	}

        rs.close();
        checkStmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();  // 로그 확인
        out.print("ERROR");
    }
%>
