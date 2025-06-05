<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Movie" %>
<jsp:useBean id="movieDAO" class="dao.MovieRepository" scope="session"/>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Movies</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>   
    <div class="row">
        <%
            ArrayList<Movie> listOfMovies = movieDAO.getAllMovies();
            for (int i = 0; i < listOfMovies.size(); i++) {
                Movie movie = listOfMovies.get(i);
        %>
        <div class="col-md-4 mb-4">
            <div class="p-4 bg-body-tertiary rounded-3 h-100">
                <h2 class="fw-bold"><%= movie.getName() %></h2>
                <p><%= movie.getDescription() %></p>
                <p><strong>개봉일:</strong> <%= movie.getReleaseDate() %></p>
                <p><strong>장르:</strong> <%= movie.getGenre() %></p> 
                <input type="submit" value="예매 시간 확인" class="btn btn-primary"/>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

</body>