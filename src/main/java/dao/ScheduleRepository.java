package dao;

import dto.Schedule;
import java.sql.*;
import java.util.*;

public class ScheduleRepository {

    private final Connection conn;

    public ScheduleRepository(Connection conn) {
        this.conn = conn;
    }

    public List<Schedule> getScheduleByDate(String date) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT * FROM schedule WHERE date = ? ORDER BY screen, time";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, date);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(mapRowToSchedule(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Schedule> getFilteredSchedule(String title, String time, String screen) {
        List<Schedule> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM schedule WHERE 1=1");

        if (!title.isEmpty()) sql.append(" AND title LIKE ?");
        if (!time.isEmpty()) sql.append(" AND time = ?");
        if (!screen.isEmpty()) sql.append(" AND screen = ?");

        try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (!title.isEmpty()) pstmt.setString(idx++, "%" + title + "%");
            if (!time.isEmpty()) pstmt.setString(idx++, time);
            if (!screen.isEmpty()) pstmt.setString(idx++, screen);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRowToSchedule(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean addSchedule(Schedule schedule) {
        String sql = "INSERT INTO schedule (title, screen, time, runtime, date) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, schedule.getTitle());
            pstmt.setString(2, schedule.getScreen());
            pstmt.setString(3, schedule.getTime());
            pstmt.setInt(4, schedule.getRuntime());
            pstmt.setDate(5, schedule.getDate());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteSchedule(int id) {
        String sql = "DELETE FROM schedule WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT * FROM schedule ORDER BY date, screen, time";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRowToSchedule(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateSchedule(Schedule schedule) {
        String sql = "UPDATE schedule SET title = ?, screen = ?, time = ?, runtime = ?, date = ? WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, schedule.getTitle());
            pstmt.setString(2, schedule.getScreen());
            pstmt.setString(3, schedule.getTime());
            pstmt.setInt(4, schedule.getRuntime());
            pstmt.setDate(5, schedule.getDate());
            pstmt.setInt(6, schedule.getId());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private Schedule mapRowToSchedule(ResultSet rs) throws SQLException {
        Schedule s = new Schedule();
        s.setId(rs.getInt("id"));
        s.setTitle(rs.getString("title"));
        s.setScreen(rs.getString("screen"));
        s.setTime(rs.getString("time"));
        s.setRuntime(rs.getInt("runtime"));
        s.setDate(rs.getDate("date"));
        return s;
    }
}
