package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Reservation;

public class ReservationRepository {
    private Connection conn;

    public ReservationRepository(Connection conn) {
        this.conn = conn;
    }

    public List<Reservation> getReservationsByUserId(String userId) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.reservation_id, r.seat_number, r.reserved_at, " +
                "s.title AS movie_title, s.screen, s.time " +
                "FROM reservation r " +
                "JOIN schedule s ON r.schedule_id = s.id " +
                "WHERE r.user_id = ? AND r.is_canceled = false " +
                "ORDER BY r.reserved_at DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getLong("reservation_id"));
                r.setSeat(rs.getString("seat_number"));
                r.setReservedAt(rs.getTimestamp("reserved_at"));
                r.setMovieTitle(rs.getString("movie_title"));
                r.setScreen(rs.getString("screen"));
                r.setTime(rs.getString("time"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean cancelReservation(long reservationId) {
        String selectSql = "SELECT seat_number, schedule_id FROM reservation WHERE reservation_id = ?";
        String cancelSql = "UPDATE reservation SET is_canceled = true WHERE reservation_id = ?";
        String resetSeatSql = "UPDATE seat SET is_paid = false, selected_user = NULL " +
                              "WHERE seat_number = ? AND schedule_id = ?";

        try (
            PreparedStatement selectStmt = conn.prepareStatement(selectSql);
            PreparedStatement cancelStmt = conn.prepareStatement(cancelSql);
            PreparedStatement resetSeatStmt = conn.prepareStatement(resetSeatSql)
        ) {
            // 1. reservation에서 seat_number와 schedule_id 가져오기
            selectStmt.setLong(1, reservationId);
            ResultSet rs = selectStmt.executeQuery();

            if (!rs.next()) return false; // 예약 정보 없으면 실패

            String seatNumber = rs.getString("seat_number");
            int scheduleId = rs.getInt("schedule_id");
            rs.close();

            // 2. 예약 취소 처리
            cancelStmt.setLong(1, reservationId);
            int cancelResult = cancelStmt.executeUpdate();

            // 3. 해당 좌석 상태 초기화 (선택 가능하도록)
            resetSeatStmt.setString(1, seatNumber);
            resetSeatStmt.setInt(2, scheduleId);
            int resetResult = resetSeatStmt.executeUpdate();

            return cancelResult > 0 && resetResult > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
