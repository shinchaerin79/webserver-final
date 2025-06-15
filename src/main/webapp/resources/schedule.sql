use MovieDB;

CREATE TABLE schedule (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    screen VARCHAR(10) NOT NULL,
    time VARCHAR(10) NOT NULL,
    runtime INT NOT NULL,
    date DATE NOT NULL
);

INSERT INTO schedule (title, screen, time, runtime, date) VALUES
('파묘', '1관', '10:00', 123, '2025-06-06'),
('범죄도시4', '2관', '16:00', 110, '2025-06-06'),
('파묘', '4관', '11:00', 123, '2025-06-06'),
('파묘', '1관', '12:00', 123, '2025-06-07');


INSERT INTO schedule (title, screen, time, runtime, date) VALUES
('미션임파서블', '1관', '10:00', 123, '2025-06-10'),
('위키드', '2관', '16:00', 110, '2025-06-11'),
('해리포터3', '4관', '11:00', 123, '2025-06-10'),
('해리포터6', '1관', '12:00', 123, '2025-06-12');

INSERT INTO schedule (title, screen, time, runtime, date) VALUES
('어벤져스:엔드게임', '1관', '10:00', 240, '2025-06-16'),
('어벤져스:엔드게임', '2관', '14:30', 240, '2025-06-16'),
('어벤져스:엔드게임', '3관', '18:00', 240, '2025-06-17'),
('어벤져스:엔드게임', '1관', '11:00', 240, '2025-06-18');

INSERT INTO schedule (title, screen, time, runtime, date) VALUES
('어벤져스:엔드게임', '1관', '22:40', 240, '2025-06-15');

INSERT INTO schedule (title, screen, time, runtime, date) VALUES
('어벤져스:엔드게임', '1관', '22:55', 240, '2025-06-15');