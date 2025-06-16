
USE MovieDB

drop table seat;

CREATE TABLE seat (
    seat_number INT NOT NULL,
    schedule_id INT NOT NULL,
    selected_user VARCHAR(50),
    is_paid BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (seat_number, schedule_id),
    FOREIGN KEY (schedule_id) REFERENCES schedule(id) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM seat WHERE schedule_id = 9;
