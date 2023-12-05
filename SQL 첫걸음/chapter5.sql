# sample51의 행 개수 구하기
SELECT * FROM sample51;
# COUNT로 행 개수 계산
SELECT COUNT(*) FROM sample51;

# 5-2 sample51의 행 개수를 WHERE 구를 지정하여 구하기
SELECT * FROM sample51 WHERE name = 'A';
SELECT COUNT(*) FROM sample51 WHERE name = 'A';

# 5-3 행 개수를 구할 때 NULL 값 다루기
SELECT * FROM sample51;
SELECT COUNT(no), COUNT(name) FROM sample51;

# 5-4 sample51 테이블
SELECT * FROM sample51;

# 5-5 DISTINCT로 중복 제거하기
SELECT ALL name FROM sample51;
# DISTINCT를 지정. 콤마는 붙이지 않는다
SELECT DISTINCT name FROM sample51;

# 5-6 중복을 제거한 뒤 개수 구하기
SELECT COUNT(ALL name), COUNT(DISTINCT name) FROM sample51;

# 5-7 SUM으로 합계 구하기
SELECT * FROM sample51;
# SUM으로 quantity열의 합계 구하기
SELECT SUM(quantity) FROM sample51;

# 5-8 AVG로 평균값 구하기
SELECT * FROM sample51;
SELECT AVG(quantity), SUM(quantity) / COUNT(quantity) FROM sample51;

# 5-9 AVG로 평균값 계산(NULL을 0으로 변환)
SELECT
    AVG(CASE WHEN quantity IS NULL THEN 0 ELSE quantity END) AS avgnull0
FROM sample51;

# 5-10 MIN, MAX로 최솟값, 최대값 구하기
SELECT * FROM sample51;
SELECT MIN(quantity), MAX(quantity), MIN(name), MAX(name)
FROM sample51;

# 5-11 sample51 테이블
SELECT * FROM sample51;

# 5-12 name 열로 그룹화하기
# GROUP BY 구에 name열을 지정해 그룹화 하기
SELECT name FROM sample51 GROUP BY name;

# 5-13 name 열을 그룹화해 계산하기
# GROUP BY 구와 집계함수를 조합
SELECT name, COUNT(name), SUM(quantity)
FROM sample51 GROUP BY name;

# 5-14 HAVING을 사용해 검색
SELECT name, COUNT(name) FROM sample51 GROUP BY name;
# HAVING구로 걸러내기
SELECT name, COUNT(name) FROM sample51
GROUP BY name HAVING COUNT(name) = 1;

# 5-15 집계한 결과 정렬하기
# name 열로 그룹화해 합계를 구하고 내림차순으로 정렬
SELECT name, COUNT(name), SUM(quantity)
FROM sample51 GROUP BY name ORDER BY SUM(quantity) DESC;

# 5-16 sample54 테이블
SELECT * FROM sample54;

# 5-17 sample54에서 a의 최솟값 검색하기
SELECT MIN(a) FROM sample54;

# 5-18 최솟값을 가지는 행 삭제하기
# 괄호로 서브쿼리를 지정해 삭제
# DELETE FROM sample54 WHERE a = (SELECT MIN(a) FROM sample54); 정상적인 오류
# 임시테이블, 혹은 변수로 처리
# SET @min_a = (SELECT MIN(a) FROM sample54);
# DELETE FROM sample54 WHERE a = @min_a;
SELECT * FROM sample54;

# 5-19 서브쿼리의 패턴
# 패턴1 하나의 값을 반환하는 패턴
SELECT MIN(a) FROM sample54;
# 패턴2 복수의 행이 반환되지만 열은 하나인 패턴
SELECT no FROM sample54;
# 패턴3 하나의 행이 반환되지만 열이 복수인 패턴
SELECT MIN(a), MAX(no) FROM sample54;
# 패턴4 복수의 행, 복수의 열이 반환되는 패턴
SELECT no, a FROM sample54;

# 5-20 SELECT 구에서 서브쿼리 사용하기(MySQL FROM 구 생략가능)
SELECT
    (SELECT COUNT(*) FROM sample51) AS sq1,
    (SELECT COUNT(*) FROM sample54) AS sq2;

# 5-21 SELECT 구에서 서브쿼리 사용하기(Oracle의 경우)
SELECT
    (SELECT COUNT(*) FROM sample51) AS sq1,
    (SELECT COUNT(*) FROM sample54) AS sq2 FROM DUAL;

# 5-22 SET 구에서 서브쿼리 사용하기
UPDATE sample54 SET a = (SELECT MAX(a) FROM sample54);

# 5-23 FROM 구에서 서브쿼리 사용하기
SELECT * FROM (SELECT * FROM sample54) sq;

# 5-24 FROM 구에서 서브쿼리 사용하기(AS로 지정)
SELECT * FROM (SELECT * FROM sample54) AS sq;

# 5-25 FROM 구에서 서브쿼리 사용하기(3단계)
SELECT * FROM (SELECT * FROM (SELECT * FROM sample54) sq1) sq2;

# 5-26 Oracle에서 LIMIT 구의 대체 명령
# SELECT * FROM (
#     SELECT * FROM sample54 ORDER BY a DESC
# ) sq
# WHERE ROWNUM <= 2;

# 5-27 VALUES 구에서 서브쿼리 사용하기
INSERT INTO sample541
VALUES ((SELECT COUNT(*) FROM sample51), (SELECT COUNT(*) FROM sample54));
SELECT *
FROM sample541;

# 5-28 SELECT 결과를 INSERT 하기
INSERT INTO sample541 SELECT 1, 2;
SELECT * FROM sample541;

# 5-22 테이블의 행 복사하기
# INSERT INTO sample542 SELECT * FROM sample543;

# 5-30 sample551 테이블과 sample552 테이블
SELECT * FROM sample551;
SELECT * FROM sample552;

# 5-31 EXISTS를 사용해 '있음'으로 갱신하기
UPDATE sample551 SET a = '있음' WHERE EXISTS(SELECT * FROM sample552 WHERE no2 = no);

SELECT * FROM sample551;

# 5-32 NOT EXISTS를 사용해 '없음'으로 갱신하기
UPDATE sample551 SET a = '없음' WHERE NOT EXISTS(SELECT * FROM sample552 WHERE no2 = no);

SELECT * FROM sample551;

# 5-33 열에 테이블명 붙이기
UPDATE sample551 SET a = '있음' WHERE
EXISTS(SELECT * FROM sample552 WHERE sample552.no2 = sample551.no);

# 5-34 IN을 사용해 조건식 기술
SELECT * FROM sample551 WHERE no IN (3, 5);

# 5-35 IN의 오른쪽을 서브쿼리로 지정하기
SELECT * FROM sample551 WHERE no IN (SELECT no2 FROM sample552);