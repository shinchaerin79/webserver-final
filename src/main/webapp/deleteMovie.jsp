<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="dbconn.jsp" %>

<%
    String id = request.getParameter("id");
    PreparedStatement stmt = null;

    try {
        String sql = "DELETE FROM Movie WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        int result = stmt.executeUpdate();

        if (result > 0) {
            // 삭제 성공 후 목록 페이지로 리다이렉트
            response.sendRedirect("editMovie.jsp");
        } else {
            out.println("<script>alert('삭제에 실패했습니다.');");
        }
    } catch (SQLException e) {
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); location.href='editMovie.jsp';</script>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
