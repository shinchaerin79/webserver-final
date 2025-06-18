<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Welcome</title>
</head>
<body>
<div class="container py-4">
	<%@ include file="menu.jsp" %>   
     
	<%! String greeting="영화 예매 홈페이지에 오신 것을 환영합니다";
	String tagline="Welcome to MovieTime Homepage!"; %>
	
	<div class="p-4 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
        	<h1 class="display-5 fw-bold"><%=greeting%></h1>
        	<p class="col-md-8 fs-4">MovieTime</p>      
      	</div>
    </div>
    <div class="row align-items-md-stretch   text-center">
      <div class="col-md-12">
        <div class="h-100 p-5">
          <h3><%=tagline%></h3>   
          <%
          response.setIntHeader("Refresh", 5);
          Date day=new java.util.Date();
          String am_pm;
          int hour=day.getHours();
          int minutes=day.getMinutes();
          int second=day.getSeconds();
          if (hour / 12==0) {
        	  am_pm="AM";
          } else {
        	  am_pm="PM";
        	  hour=hour - 12;
          }
          String CT= hour + ":" + minutes + ":" + second + " " + am_pm;
          out.println("현재 접속 시각: " + CT + "\n");
          %>      
        </div>
      </div>   
    </div> 
    
<h2 class="mt-5 mb-3">진행 중인 이벤트</h2>
<div class="row">
    <div class="col-md-6 mb-3">
        <div class="alert alert-info">
            <h5 class="alert-heading">🍿 주말 예매 30% 할인!</h5>
            <p>이번 주 금~일요일까지 모든 영화 예매 시 30% 할인 혜택을 드립니다. <br>지금 바로 예매하세요!</p>
            <hr>
            <a href="./schedule/scheduleView.jsp" class="btn btn-sm btn-primary">예매하러 가기</a>
        </div>
    </div>
    <div class="col-md-6 mb-3">
        <div class="alert alert-success">
            <h5 class="alert-heading">🎁 리뷰 작성 이벤트</h5>
            <p>관람 후 리뷰를 남기면 추첨을 통해 <strong>영화관람권</strong>을 드립니다! <br>당첨자는 매주 월요일 공지됩니다.</p>
            <hr>
            <a href="./movie/movies.jsp" class="btn btn-sm btn-success">리뷰 작성하러 가기</a>
        </div>
    </div>
</div>
    
    
</div>
</body>
</html>