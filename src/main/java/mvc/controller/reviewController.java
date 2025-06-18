package mvc.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvc.model.reviewDAO;
import mvc.model.reviewDTO;

public class reviewController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	processReview(request, response);
    }

    private void processReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	reviewDAO dao = new reviewDAO();
    	String path = request.getServletPath();

    	if (path.equals("/reviewList.do")) {
    		
    		String movieIdStr = request.getParameter("movie_id");
    		String title = request.getParameter("title");
    		Long movieId = null;

    		try {
    			if (movieIdStr != null && !movieIdStr.isEmpty()) {
    				movieId = Long.parseLong(movieIdStr);
    			} 
    			else if (title != null && !title.isEmpty()) {
    				movieId = dao.getMovieIdByTitle(title);
    			}
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    		
    		//에러 해결 용
    		if (movieId == null) {
    			response.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 영화 정보를 찾을 수 없습니다.");
    			return;
    		}
    		
    		List<reviewDTO> reviews = dao.getReviewsByMovie(movieId);
    		
    		request.setAttribute("reviews", reviews);
    		request.setAttribute("title", title);
    		
    		request.getRequestDispatcher("/review/review.jsp").forward(request, response);
    	} 
		
    	else if (path.equals("/addReview.do")) {
    		
    		if (request.getMethod().equalsIgnoreCase("GET")) {
    			
    			String title = request.getParameter("title");
    			String movieId = request.getParameter("movie_id");
    			
    			request.setAttribute("title", title);
    			request.setAttribute("movie_id", movieId);
    			
    			request.getRequestDispatcher("/review/writeReviewForm.jsp").forward(request, response);
    		}
    		
    		else if (request.getMethod().equalsIgnoreCase("POST")) {
    			
    			String username = request.getParameter("username");
    			String title = request.getParameter("title");
    			String movieIdStr = request.getParameter("movie_id");
    			String scopeStr = request.getParameter("scope");
    			String contents = request.getParameter("contents");
    			
				// username 디버깅용 출력
				System.out.println(">>> username: " + username);
				System.out.println(">>> movieId: " + movieIdStr);
				System.out.println(">>> scope: " + scopeStr);
				System.out.println(">>> contents: " + contents);

				try {
					Long movieId = Long.parseLong(movieIdStr);
					int scope = Integer.parseInt(scopeStr);
					
					reviewDTO dto = new reviewDTO();
					dto.setUsername(username);
					dto.setMovie_id(movieId.intValue());
					dto.setScope(scope);
					dto.setContents(contents);
					
					dao.insertReview(dto);
					
					// 저장 후 리뷰 목록으로 되돌아가게 하는 거
					response.sendRedirect(
						request.getContextPath() + "/reviewList.do?title=" + URLEncoder.encode(title, "utf-8") + "&movie_id=" + movieId
					);
				} catch (Exception e) {
					e.printStackTrace();
					response.getWriter().write("리뷰 저장 중 오류가 발생했습니다.");
				}
			}
		} 
		
		else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}
}