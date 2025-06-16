use MovieDB;

CREATE TABLE users (
    id     		BIGINT PRIMARY KEY AUTO_INCREMENT,
    username    VARCHAR(30) NOT NULL,
    password    VARCHAR(100) NOT NULL,
    nickname 	VARCHAR(50) NOT NULL,
    role        VARCHAR(50) NOT NULL DEFAULT 'USER',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME     DEFAULT NULL
);

ALTER TABLE users ADD UNIQUE (username);

select * from users;