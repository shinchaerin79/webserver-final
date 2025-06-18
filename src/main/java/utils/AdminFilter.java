package utils;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AdminFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession(false);

        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            request.setAttribute("msg", "관리자만 접근 가능합니다.");
            request.getRequestDispatcher("/auth/login.jsp").forward(req, res);
            return;
        }

        chain.doFilter(req, res); // 통과
    }
}
