USE MovieDB;

-- 기존 테이블 삭제
DROP TABLE IF EXISTS reservation;

-- Reservation 테이블 생성
CREATE TABLE reservation (
    reservation_id   BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '예약 고유 ID',
    seat_number      VARCHAR(10) NOT NULL COMMENT '좌석 번호',
    reserved_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '예매 일시',
    is_canceled      BOOLEAN DEFAULT FALSE COMMENT '취소 여부',
    schedule_id      BIGINT NOT NULL COMMENT '스케줄 ID',
    user_id          BIGINT NOT NULL COMMENT '예매한 사용자 ID',

    FOREIGN KEY (schedule_id) REFERENCES schedule(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);
