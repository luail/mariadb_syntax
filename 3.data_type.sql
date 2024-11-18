-- tinyint는 -128~127까지 표현(1 byte 할당)
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;
-- date insert 테스트 : 200살 insert;
insert into author(id, age) values(6,200);
alter table author modify column age tinyint unsigned; --음의 표현영역을 양의 표현영역으로 옮겨옴.

-- decimal실습
-- decimal(정수부 자릿수, 소수부)
alter table post add column price decimal(10, 3);

-- decimal 소수점 초과 후 값 짤림 현상
insert into post(id, title, price) values(8, 'java programming', 10.33412);

-- 문자열 실습
alter table author add column self_introduction text;
insert into author (id, self_introduction) values(9, '고준혁입니다.');

-- varchar     vs     TEXT
--   가변             가변
-- index사용        index사용불가
-- 메모리활용       주로,디스크 활용
-- varchar가 더 빠르다.
-- 메모리가 더욱 비싸지만, 성능이 더욱 좋다.
-- 디스크를 활용하면 자원을 더 SAVE할 수 있다.
-- 빈번한 조회가 있다면 index가 있는 varchar가 더 좋다.

-- blob (바이너리데이터 = 이미지 또는 동영상을 이진법 형태로 데이터 변환한것.) 타입 실습
alter table author add column profile_image longblob;
insert into author (id, profile_image) values(9, LOAD_FILE('C:\\mococo.jpg'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입.
-- role컬럼 추가
alter table author add column role enum('user', 'admin') not null default 'user';
--not null 안넣으면 null값 가능해짐.

-- user 값 세팅 후 insert
insert into author(id, role) values(11, 'user');
-- users 값 세팅 후 insert
insert into author(id, role) values(12, 'users');
-- 아무것도 안넣고 insert(default 값)
insert into author(id) values(12);
insert into author(id, name, email, role) values(13, 'kojoon', 'kojoon@naver.com', 'admin');

-- date : 날짜, datetime : 날짜 및 시분초(microseconds)
-- datetime은 입력, 수정, 조회시에 문자열 형식을 활용한다.
alter table post add column created_time datetime default current_timestamp();
update post set created_time = '2024-11-18 06:10:48' where id = 5;

-- 조회 시 비교연산자 키워드 위주로 알자.
select * from author where id >= 2 and id <= 4;
select * from author where id between 2 and 4; --위의 >= 2 and <= 4 구문과 같은 구문
select * from author where id not(id < 2 or id > 4);
select * from author where id in(2,3,4);
-- select * from author where id in(select author_id from post); 로도 활용가능
-- 글을 한번이라도 쓴 사람들만 조회해라
select * from author where id not in (1,5);  --전체데이터가 1~5까지 밖에 없다는 가정.