<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>

<%	
	String scheduleIdStr = request.getParameter("scheduleId");
	
	//에러 확인 용임
	if (scheduleIdStr == null || scheduleIdStr.trim().isEmpty()) {
    	return;
	}
	
	int scheduleId = Integer.parseInt(scheduleIdStr);

	String userId = (String) session.getAttribute("userId");
	
	if (userId == null) {
    	userId = "";
	}
	userId = userId.replace("'", "\\'");

	try {
		String sql = "SELECT * FROM seat WHERE schedule_id = ? ORDER BY seat_number";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleId);
		ResultSet rs = pstmt.executeQuery();
		
		// 70개 좌석 배치 리로드 될 때 변경된 죄석 데이터 반영하기 위해    	
		while (rs.next()) {
			int seat_number = rs.getInt("seat_number");
			String selected_user = rs.getString("selected_user");
			boolean isPaid = rs.getBoolean("is_paid");

			String btnClass = "btn-success"; // 선택 전 좌석 섹
        	
			if (isPaid) {
 				btnClass = "btn-secondary"; // 결제 완료된 좌석 색
			}
        	
			else if (selected_user != null) {
				if (selected_user.equals(userId)) {
					btnClass = "btn-warning"; // 본인이 선택한 좌석 색
				}
            	
				else {
					btnClass = "btn-secondary"; // 다른 사람이 선택한 좌석 색
				}
			}
			
        	//선택 불가 좌석 비활성화 추가
        	boolean isDisabled = btnClass.equals("btn-secondary") && selected_user != null && !selected_user.equals(userId);
%>
			<button class="btn seat-button <%= btnClass %>" <%= isDisabled ? "disabled" : "" %>
				onclick="selectSeat(this, <%= seat_number %>, '<%= userId %>', <%= scheduleId %>)"> <%= isPaid ? "X" : seat_number %>
			</button>
<%
    	}
    	rs.close();
    	pstmt.close();
    	conn.close();
	} catch (Exception e) {
    	out.print("에러: " + e.getMessage());
	}
%>
