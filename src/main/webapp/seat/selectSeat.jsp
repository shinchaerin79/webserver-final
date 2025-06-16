<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../dbconn.jsp" %>
<%
String userId = (String) session.getAttribute("userId");

if (userId == null) {
    String currentURL = request.getRequestURI();
    String query = request.getQueryString();
    String redirectURL = currentURL + (query != null ? "?" + query : "");

    String msg = java.net.URLEncoder.encode("로그인이 필요합니다. 로그인 후 이용해주세요.", "UTF-8");
    String encodedRedirect = java.net.URLEncoder.encode(redirectURL, "UTF-8");

    response.sendRedirect(request.getContextPath() + "/auth/login.jsp?msg=" + msg + "&redirect=" + encodedRedirect);
    return;
}

// 스케줄아이디 에러 확인 용
String scheduleIdStr = request.getParameter("scheduleId");
int scheduleId = -1;
if (scheduleIdStr != null && !scheduleIdStr.isEmpty()) {
    scheduleId = Integer.parseInt(scheduleIdStr);
} else {
    out.println("<script>alert('스케줄 ID가 유효하지 않습니다.'); history.back();</script>");
    return;
}


%>
<div class="container py-4">
<%@ include file="../menu.jsp" %> 
<html>
<head>
	<title>selectSeat</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		.seat-grid {
			display: grid;
			grid-template-columns: repeat(10, 50px);
			grid-gap: 10px;
			justify-content: center;
			margin-top: 30px;
		}
		.seat-button {
			width: 50px;
			height: 50px;
			font-size: 12px;
		}
		.screen-label {
    		width: 200px;
    		background-color: gray;
    		text-align: center;
    		color: white;
    		font-weight: bold;
    		margin: 0 auto 20px auto;
    		font-size: 18px;
    		padding: 5px 0;
		}
	</style>
	<script>
	const scheduleId = <%= scheduleId %>;
	
    function selectSeat(button, seatNumber, userID, schedule_Id) {
    	// 에러 해결 확인 용
    	console.log("선택된 좌석번호:", seatNumber);
        console.log("사용자 ID:", userID);
        console.log("스케줄 ID:", schedule_Id);
        
        // 이미 누군가 결제, 선택되었으면 선택 불가
        if (button.classList.contains('btn-secondary')) return;
		
        // 비동기식 데이터 전달
        fetch('seatUpdate.jsp', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'seat_number=' + seatNumber + '&user_id=' + userID + '&scheduleId=' + schedule_Id
        })
        
        .then(response => response.text())
        
        .then(data => {
            if (data.trim() === "SELECTED") { // 좌석 선택
                button.classList.remove('btn-success');
                button.classList.add('btn-warning');
            } 
            else if (data.trim() === "UNSELECT") { // 선택 취소
                button.classList.remove('btn-warning');
                button.classList.add('btn-success');
            } 
            else {
                alert("선택 실패: " + data);
            }
            
        });
    }

    function fetchSeatStatus() {
    	// 5초 후 리로드할 때 최신 상타 반영하기 위해
        fetch('seatStatus.jsp?scheduleId=' + scheduleId)
        .then(res => res.text())
        .then(html => {
            document.querySelector('.seat-grid').innerHTML = html;
        });
    }

    setInterval(fetchSeatStatus, 5000);
</script>


</head>
<body>
<div class="container py-4">
	<h2 class="text-center mb-4">좌석 선택</h2>
	
	<div class="d-flex justify-content-center gap-4 mb-3">
		<div>
			<button class="btn btn-success btn-sm"></button>
			<p class="mb-0">선택 가능</p>
		</div>
		<div>
			<button class="btn btn-secondary btn-sm"></button>
			<p class="mb-0">선택 불가</p>
		</div>
	</div>
	
	<div class="screen-label">영상 스크린</div>

	<div class="seat-grid">
	<jsp:include page="seatInit.jsp"/>
	<%
		try {
			String selectSql = "SELECT * FROM seat WHERE schedule_id = ? ORDER BY seat_number";
		    PreparedStatement pstmt = conn.prepareStatement(selectSql);
		    pstmt.setInt(1, scheduleId);
		    ResultSet rs = pstmt.executeQuery();

		    String safeUserId = userId != null ? userId.replace("'", "\\'") : "";

		    while (rs.next()) {
		        int seat_number = rs.getInt("seat_number");
		        String selected_user = rs.getString("selected_user");
		        boolean isPaid = rs.getBoolean("is_paid");
		        int schedule_id=rs.getInt("schedule_id");

		        String btnClass = "btn-success"; // 기본 좌석 색
		        
		        if (isPaid) btnClass = "btn-secondary"; // 결제 완료된 색
		        
		        else if (selected_user != null) {
		            if (selected_user.equals(userId)) btnClass = "btn-warning"; // 본인이 선택한 색
		            
		            else btnClass = "btn-secondary"; // 이미 다른 사람이 선택한 색
		        }
				
		        //선택할 수 없는 좌석 비활성화 추가
		        boolean isDisabled = btnClass.equals("btn-secondary") && selected_user != null && !selected_user.equals(userId);
		%>
		        <button class="btn seat-button <%= btnClass %>" 
		            <%= isDisabled ? "disabled" : "" %>
		            onclick="selectSeat(this, <%= seat_number %>, '<%= safeUserId %>', <%= scheduleId %>)">
		            <%= isPaid ? "X" : seat_number %>
		        </button>
	<%
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) { 
			out.println("에러: " + e.getMessage());
		}
	%>
	</div>

	<div class="text-center mt-4">
		<form action="seatPayment.jsp" method="post">
    		<input type="hidden" name="user_id" value="<%= session.getAttribute("userId") %>">
    		<button type="submit" class="btn btn-primary">결제하기</button>
		</form>
	</div>
</div>
</body>
</html>
</div>

