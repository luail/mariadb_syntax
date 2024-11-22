-- 여러 사용자가 1개의 글을 수정할 수 있다 가정 후 DB 리뉴얼
-- author와 post가 n:m 관계가 되어 관계 테이블을 별도로 생성.

create table author(id bigint auto_increment primary key,
email varchar(255) not null unique, name varchar(255),
created_time datetime defualt current_timestamp());

create table post(id bigint auto_increment primary key,
title varchar(255) not null, contents varchar(3000),
created_time datetime defualt current_timestamp());

-- 1:1 관계인 author_address
-- 1:1 관계의 보장은 author_id unique 설정
create table author_address(id bigint auto_increment primary key,
country varchar(255), city varchar(255), street varchar(255),
author_id bigint not null unique, foreign key(author_id) references author(id));

-- author_post는 연결 테이블로 생성
create table author_post(id bigint auto_increment primary key,
author_id bigint not null, post_id bigint not null,
foreign key(author_id) references author(id),
foreign key(post_id) references post(id)); 

-- 복합키로 author_post 생성
-- 복합키로 인덱스를 타게 하려면 where 조건에 복합키 두개 다 넣어야 인덱스를 탄다.
create table author_post2(
author_id bigint not null,
post_id bigint not null,
primary key(author_id, post_id),
foreign key(author_id) references author(id),
foreign key(post_id) references post(id)
);

-- 내 id로 내가 쓴 글 조회
select *
from post p
inner join author_post ap on p.id=ap.post_id
where ab.author_id = 1;

-- 글 2번 이상 쓴 사람에 대한 정보 조회
select a.*
from author a
inner join author_post ap on a.id = ap.author_id
group by a.id having count(a.id)>=2
order by author_id;
