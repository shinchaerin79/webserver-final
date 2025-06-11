USE MovieDB;

drop table if exists notice;

create table notice (
    n_id int AUTO_INCREMENT primary key,
    writingTime timestamp default CURRENT_TIMESTAMP,
    n_title varchar(255) not null,
    n_text TEXT not null, 
    is_top boolean not null default false
);

INSERT into notice (n_title, n_text, is_top)
values ('어벤져스 상영 시작', '24일부터 상영이 시작되었습니다.', false);