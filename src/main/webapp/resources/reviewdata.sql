USE MovieDB

DROP TABLE IF EXISTS reviewdata;

CREATE TABLE reviewdata (
    review_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    movie_id INT NOT NULL COMMENT '영화 ID',
    writingTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
    scope INT CHECK (scope BETWEEN 1 AND 5) COMMENT '별점 (1~5)',
    contents TEXT COMMENT '관람평 내용',
    
    FOREIGN KEY (username) REFERENCES users(nickname) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

-- 기존 외래키 삭제
ALTER TABLE reviewdata
DROP FOREIGN KEY fk_review_username;

-- 외래키 다시 생성 (ON DELETE CASCADE + ON UPDATE CASCADE)
ALTER TABLE reviewdata
ADD CONSTRAINT fk_review_username
FOREIGN KEY (username) REFERENCES users(nickname)
ON DELETE CASCADE
ON UPDATE CASCADE;