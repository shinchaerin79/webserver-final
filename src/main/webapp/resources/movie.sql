USE MovieDB;

drop table Movie;

create table if not exists Movie(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name varchar(100) not null,
	releaseDate DATE,
	length int default 0,
	posterName varchar(100),
	genre varchar(100),
	description TEXT
);

INSERT INTO Movie (name, releaseDate, length, posterName, genre, description)
VALUES
('어벤져스:엔드게임', '2019-04-24', 240, 'endGame.jpg', '액션', '마지막으로 지구를 살리려 모든 것을 건 타노스와 최후의 전쟁을 치른다....');

INSERT INTO Movie (name, releaseDate, length, posterName, genre, description)
VALUES
('뽀로로 극장판 슈퍼스타 대모험', '2023-12-08', 120, 'superstar.jpg', '애니메이션', '뽀로로와 친구들은 전 우주를 통틀어 최고의 슈퍼스타를 뽑는 음악 축제 ‘파랑돌 슈퍼스타 선발대회’ 축제에 참가하기 위해 모험을 떠난다...');

INSERT INTO Movie (name, releaseDate, length, posterName, genre, description)
VALUES
('드래곤 길들이기', '2025-06-06', 125, 'drangon.jpg', '판타지', '수백년간 지속되어온 바이킹과 드래곤의 전쟁. 드래곤을 없애는 것이 삶의 모든 목적인 바이킹들과 다른 신념을 가진 ‘히컵’은 무리 속에 속하지 못하고 족장인 아버지에게도 인정받지 못한다..');


