USE MovieDB

DROP TABLE IF EXISTS reviewdata;

CREATE TABLE reviewdata (
    review_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    movie_id INT NOT NULL COMMENT '영화 ID',
    writingTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
    scope INT CHECK (scope BETWEEN 1 AND 5) COMMENT '별점 (1~5)',
    contents TEXT COMMENT '관람평 내용',
    
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

select * from reviewdata;

INSERT INTO reviewdata (username, movie_id, scope, contents)
VALUES ('user123', 1, 5, '테스트 리뷰입니다.');

select * from reviewdata;

select * from reviewdata;

SHOW CREATE TABLE reviewdata;

ALTER TABLE reviewdata DROP FOREIGN KEY reviewdata_ibfk_1;

ALTER TABLE reviewdata MODIFY username VARCHAR(50) NOT NULL;

ALTER TABLE reviewdata 
ADD CONSTRAINT fk_review_username 
FOREIGN KEY (username) REFERENCES users(nickname) ON DELETE CASCADE;

ALTER TABLE reviewdata 
ADD CONSTRAINT fk_review_username 
FOREIGN KEY (username) REFERENCES users(nickname) ON DELETE CASCADE;
