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

-- like*** : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%h'; --h로 끝나는 타이틀 검색.
select * from post where title like 'h%'; --h로 시작하는 타이틀 검색.
select * from post where title like '%h%'; --h가 포함되어있는 타이틀 검색.

-- regexp : 정규표현식을 활용한 조회
-- not regexp도 활용 가능.
select * from post where title regexp '[a-z]'; --하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]'; --하나라도 한글이 포함되어 있으면.

-- 날짜변환 cast, convert : 숫자->날짜, 문자->날짜
select cast(20241119 as date);
select convert(20241119, date);
select cast('20241119' as date);
select convert('20241119', date);
-- 문자->숫자 변환
select cast('12' as unsigned);
select convert('12', unsigned);

-- 날짜 조회 방법
-- like패턴, 부등호 활용, date_format
select * from post where created_time like '2024-11%'; --문자열처럼 조회
select * from post where created_time >= '2024-01-01' and created_time < '2025-01-01'; 
--date_format활용
select date_format(created_time, '%Y-%m-%d') from post; --연월일만 뽑아서 조회
select date_format(created_time, '%H:%i:%s') from post; --시분초만 뽑아서 조회
select * from post where date_format(created_time, '%Y')='2024';
select * from post where cast(date_format(created_time, '%Y')='2024' as unsigned) = 2024;

-- 오늘 날짜 및 시간.
select now();