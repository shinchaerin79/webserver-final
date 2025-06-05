USE MovieDB;

create table Movie(
	m_name varchar(100) not null,
	primary key(m_name)
);

INSERT into Movie values('마블');