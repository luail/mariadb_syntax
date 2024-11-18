-- insert into : 테이블에 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);
-- 문자열은 일반적으로 작은따옴표 '' 를 사용
insert into author(id, name, email) values(3, kim, kim@naver.com);
-- select : 데이터조회, * : 모든컬럼을 의미.
select * from author;
select name, email author; 특정 컬럼만 조회한 경우.

-- post 데이터 1줄 추가
insert into post(id, title, contents) values(1, '안녕', '안녕하세용')
insert into post(id, title, contents, author_id) values(1, 'hello', 'hello....', 4)

-- 테이블 제약조건 조회, KEY값에 MUL 있으면 FK
select * from information_schema.key_column_usage where table_name = 'post';

-- insert문을 통해 author데이터 2개정도 추가, post 데이터 2개 정도 추가(1개는 익명)
insert into author(id, name,) values(4, 'ko');

-- update : 데이터 수정 update set으로 알면됨.
-- where문을 누락할 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set name='홍길동' where id=1; 
update duthor set name='홍길동2', email='hongildong@naver.com' where id=2;

-- delete : 데이터 삭제
-- where문을 누락할 경우 모든 데이터가 삭제됨에 유의.
delete from author where id = 5;

-- select : 조회
select * from author; -- 어떠한 조회조건 없이 모든 컬럼 조회
select * from author where id=1; --where 뒤에 조회조건을 통해 조회
select * from author where name='hongildong';
select * from author where id>3;
select * from author where id>2 and name='ko'; --또는 일 경우에는 or를 사용하면 됨

-- 중복제거 조회 : distinct
select distinct name from author

-- 정렬 : order by*** + 컬럼명
-- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
-- asc를 빼면 자동으로 오름차순, 내림차순으로 하고싶으면 desc.
select * from author order by name desc;

-- 멀티컬럼 order by*** :
-- 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬. 중복시, 그 다음 정렬옵션 적용.
select * from author order by name desc, email asc; --name으로 먼저 정렬, 중복시 email로 정렬.

-- limit : 결과값 개수 제한
select * from author order by id desc limit 2; --가장 최근에 가입한 사람 조회인데, 2명을 조회.

-- 별칭(alias)을 이용한 selecet
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a ; --원래는 네임과 이메일 앞에 어떤 테이블인지 표기해야함. 
select a.name, a.email from author a ; 

-- null을 조회조건으로 활용
select * from author where password is null;
select * from author where password is not null;

-- order by와 where의 차이
select * from customer order by customer_phone_num is null;
-- 끊어서 해석하면 customer중에서 찾아라, customer_phone_num가 널인 애들을, 오름차순으로 정리해라.
select * from customer where customer_phone_num is null;

-- 프로그래머스 sql 문제풀이
-- 여러 기준으로정렬하기
-- 상위 n개 레코드