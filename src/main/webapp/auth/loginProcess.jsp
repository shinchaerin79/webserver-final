<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../dbconn.jsp" %>
<%@ page import="utils.PasswordUtil" %>

<%
    String username = request.getParameter("username");
    String rawPassword = request.getParameter("password");
    String redirect = request.getParameter("redirect");

    String password = PasswordUtil.encrypt(rawPassword);  // 비밀번호 암호화

    String sql = "SELECT nickname, role FROM users WHERE username = ? AND password = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            String nickname = rs.getString("nickname");
            String role = rs.getString("role"); 
            
            session.setAttribute("userId", username);
            session.setAttribute("nickname", nickname);
            session.setAttribute("role", role); 
            
            // 관리자면 관리자 페이지로 이동
            if ("ADMIN".equals(role)) {
                response.sendRedirect("../admin/admin.jsp");
                return;
            }

            // 일반 사용자
            if (redirect != null && !redirect.isEmpty()) {
                response.sendRedirect(redirect);
            } else {
                response.sendRedirect("../welcome.jsp");
            }
        } else {
            // 로그인 실패 → login.jsp로 msg와 redirect 파라미터 전달
            String msg = java.net.URLEncoder.encode("아이디 또는 비밀번호가 올바르지 않습니다.", "UTF-8");
            String target = "login.jsp?msg=" + msg;
            if (redirect != null && !redirect.isEmpty()) {
                target += "&redirect=" + java.net.URLEncoder.encode(redirect, "UTF-8");
            }
            response.sendRedirect(target);
        }

    } catch (Exception e) {
        e.printStackTrace();
        String msg = java.net.URLEncoder.encode("오류가 발생했습니다. 다시 시도해주세요.", "UTF-8");
        response.sendRedirect("login.jsp?msg=" + msg);
    }
%>
