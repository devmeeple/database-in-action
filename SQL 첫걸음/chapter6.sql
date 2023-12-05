# 6-1 CREATE TABLE로 테이블 작성하기
CREATE TABLE sample62(
    no INTEGER NOT NULL,
    a VARCHAR(30),
    b DATE);

DESC sample62;

# 6-2 ALTER TABLE로 테이블에 열 추가하기
ALTER TABLE sample62 ADD newcol INTEGER;
DESC sample62;

# 6-3 ALTER TABLE로 열 속성 변경하기
ALTER TABLE sample62 MODIFY newcol VARCHAR(20);
DESC sample62;

# 6-4 ALTER TABLE로 열 이름 변경하기
ALTER TABLE sample62 CHANGE newcol c VARCHAR(20);
DESC sample62;

# 6-5 ALTER TABLE로 열 삭제하기
ALTER TABLE sample62 DROP c;
DESC sample62;

# 6-6 테이블 열에 제약 정의하기
CREATE TABLE sample631 (
    a INTEGER NOT NULL,
    b INTEGER NOT NULL UNIQUE,
    c VARCHAR(30)
);

# 6-7 테이블에 '테이블 제약'정의하기
CREATE TABLE sample632 (
    no INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name VARCHAR(30),
    PRIMARY KEY (no, sub_no)
);

# 6-8 '테이블 제약'에 이름 붙이기
CREATE TABLE sample632(
    no INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name VARCHAR(30),
    CONSTRAINT pkey_sample PRIMARY KEY (no, sub_no)
);
DESC sample632;

# 6-9 열 제약 추가하기
# c열에 NOT NULL 제약 걸기
ALTER TABLE sample631 MODIFY c VARCHAR(30) NOT NULL;

# 6-10 테이블에 제약 추가하기
# 기본키 제약 추가하기
ALTER TABLE sample631 ADD CONSTRAINT pkey_sample631 PRIMARY KEY (a);

# 6-11 열 제약 삭제하기
# c열의 NOT NULL 제약 없애기
ALTER TABLE sample631 MODIFY c VARCHAR(30);

# 6-12 테이블 제약 삭제하기
# pkey_sample631 제약 삭제하기
ALTER TABLE sample631 DROP CONSTRAINT pkey_sample631;

# 6-13 테이블 제약 삭제하기
# 기본키 제약 삭제하기
ALTER TABLE sample631 DROP PRIMARY KEY;

# 6-14 sample634 테이블 작성하기
CREATE TABLE sample634(
    p INTEGER NOT NULL,
    a VARCHAR(30),
    CONSTRAINT pkey_sample634 PRIMARY KEY (p)
);

# 6-15 sample634에 행 추가하기
INSERT INTO sample634 VALUES (1, '첫째줄');
INSERT INTO sample634 VALUES (2, '둘째줄');
INSERT INTO sample634 VALUES (3, '셋째줄');

# 6-16 sample634에 중복하는 행 추가하기(에러)
INSERT INTO sample634 VALUES (2, '넷째줄');

# 6-17 sample634에 중복된 값으로 갱신하기(에러)
UPDATE sample634 SET p = 2 WHERE p = 3;

# 6-18 a 열과 b 열로 이루어진 기본키
SELECT a, b FROM sample635;

# 6-19 인덱스 작성하기
CREATE INDEX isample65 ON sample62(no);

# 6-20 인덱스 삭제하기
DROP INDEX isample65 ON sample62;

# 6-21 EXPLAIN으로 인덱스 사용 확인하기 1 (MySQL)
EXPLAIN SELECT * FROM sample62 WHERE a = 'a';

# 6-22 EXPLAIN으로 인덱스 사용 확인하기 2 (MySQL)
EXPLAIN SELECT * FROM sample62 WHERE no > 10;

# 6-23 뷰 작성하기
CREATE VIEW sample_view67 AS SELECT * FROM sample54;
SELECT * FROM sample_view67;

# 6-24 열을 지정해 뷰 작성하기
CREATE VIEW sample_view_672(n, v, v2) AS
    SELECT no, a, a * 2 FROM sample54;
SELECT * FROM sample_view_672 WHERE n = 1;

# 6-25 뷰 삭제하기
DROP VIEW sample_view67;