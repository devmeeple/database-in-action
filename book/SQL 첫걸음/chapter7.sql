# 7-1 UNION으로 합집합 구하기
SELECT * FROM sample71_a;
SELECT * FROM sample71_b;

# 7-2 두 개의 SELECT 명령을 UNION해서 합집합 구하기
SELECT * FROM sample71_a
UNION
SELECT * FROM sample71_b;

# 7-3 두 개의 SELECT 명령에 UNION ALL을 적용해 합집합 구하기
SELECT * FROM sample71_a
UNION ALL
SELECT * FROM sample71_b;

# 7-4 sample72_x와 sample72_y
SELECT * FROM sample72_x;
SELECT * FROM sample72_y;

# 7-5 FROM 구로 곱집합 구하기
# FROM구에 테이블 두 개를 지정해 곱집합 구하기
SELECT * FROM sample72_x, sample72_y;

# 7-6 상품 테이블 작성하기
CREATE TABLE 상품 (
    상품코드 CHAR(4) NOT NULL,
    상품명  VARCHAR(30),
    메이커명 VARCHAR(30),
    가격  INTEGER,
    상품분류 VARCHAR(30),
    PRIMARY KEY (상품코드)
);
# 이미 상품테이블이 있어서 오류

# 7-7 재고수 테이블 작성하기
CREATE TABLE 재고수 (
    상품코드 CHAR(4),
    입고날짜 DATE,
    재고수 INTEGER
);
# 이미 테이블이 있어서 오류 기본키를 지정해 두는것이 좋음

# 7-8 상품 테이블과 재고수 테이블을 교차결합하기
SELECT * FROM 상품, 재고수;

# 7-9 상품코드가 같은 행을 검색하기
SELECT * FROM 상품, 재고수
WHERE 상품.상품코드 = 재고수.상품코드;

# 7-10 검색할 행과 반환할 열 제한하기
SELECT 상품.상품명, 재고수.재고수 FROM 상품, 재고수
WHERE 상품.상품코드 = 재고수.상품코드
AND 상품.상품분류 = '식료품';

# 7-11 메이커 테이블 작성하기
CREATE TABLE 메이커(
    메이커코드 CHAR(4) NOT NULL,
    메이커명 VARCHAR(30),
    PRIMARY KEY (메이커코드)
);
# 이미 작성

# 7-12 상품 테이블과 메이커 테이블을 내부결합하기
SELECT S.상품명, M.메이커명
FROM 상품2 S INNER JOIN 메이커 M
ON S.메이커코드 = M.메이커코드;

# 7-13 상품 테이블을 자기결합 하기
SELECT S1.상품명, S2.상품명
FROM 상품 S1 INNER JOIN 상품 S2
ON S1.상품코드 = S2.상품코드;

# 7-14 내부결합에서는 상품코드가 0009인 상품이 제외된다
SELECT 상품3.상품명, 재고수.재고수
FROM 상품3 INNER JOIN 재고수
ON 상품3.상품코드 = 재고수.상품코드
WHERE 상품3.상품분류 = '식료품';

# 7-15 외부결합으로 상품코드 0009인 상품도 결과에 포함하기
SELECT 상품3.상품명, 재고수.재고수
FROM 상품3 LEFT JOIN 재고수
ON 상품3.상품코드 = 재고수.상품코드
WHERE 상품3.상품분류 = '식료품';
