# 덤프파일 생성 : dumpfile.sql이라는 이름의 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql
# 한글 깨질때
mysqldump -u root -p board -r dumpfile.sql
# 덤프파일 적용(복원)
# <가 특수문자로 인식되어, window에서 적용이 안 될 경우, git bash 터미널 창을 활용
mysql -u root -p board < dumpfile.sql  (오른쪽 쿼리를 board에 적용하겠다.)

# dump파일을 github에 업로드

# 리눅스에서 mariadb설치
apt-get install mariadb-server

# mariadb 서버 실행
sudo systemctal start mariadb

# mariadb 접속 : 1234
mariadb -u root -p 
create database board;

# git 설치
sudo apt-get install git

# git에서 repository clone
git clone 레포지토리 주소(https://github.com/luail/mariadb_syntax)

# mariadb 덤프파일 복원
