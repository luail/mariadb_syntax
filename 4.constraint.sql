-- 제약조건 추가 방법 2가지
-- 1) 컬럼에 추가 2) 테이블에 추가

-- not null 제약조건 추가.
alter table author modify column email varchar(255) not null;

-- unique 제약조건 추가
alter table author modify column email varchar(255) unique ;
alter table author modify column email varchar(255) not null unique;

-- foreign key 제약조건 삭제 및 추가
-- 제약조건의 이름 확인 후 삭제 및 추가 가능.
-- 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';
-- 제약조건 삭제
alter table post drop foreign key post_ibfk_1;
-- 제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

-- delete, update 관련 제약 조건 테스트
-- on delete cascade 테스트
-- 제약조건 삭제
alter table post drop foreign key post_author_fk;
-- 제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on;


-- on delete set null set null 테스트
-- 제약조건 삭제
alter table post drop foreign key post_author_fk;
-- 제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update set null;

-- default옵션
alter table author modify column name varchar(255) default 'anonymous';
-- auto_increment
alter table author modify column id bigint auto_increment; 
alter table post modify column id bigint auto_increment; 

-- uuid
alter table post add column user_id char(36) default (UUID());