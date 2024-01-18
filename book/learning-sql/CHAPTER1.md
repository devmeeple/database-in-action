# 1. 배경

## 1.1 데이터베이스 소개

데이터베이스는 관련 정보의 집합이다.

- 각 테이블에는 엔티티를 설명하는데 필요한 추가 정보와 함께 기본키가 포함된다.
- 정규화란 외래키를 제외하고 각각의 독립적인 정보가 한 위치에만 저장되도록 데이터베이스 설계를 수정하는 절차

### 주요 용어와 정리

| 용어                  | 정의                                                          |
|---------------------|-------------------------------------------------------------|
| 엔티티(entity)         | 사용자들이 관심을 갖는 모든 요소(고객, 부품 등)                                |
| 열(column)           | 테이블에 저장된 개별적인 데이터 조각                                        |
| 행(row)              | 엔티티 혹은 엔티티에 대한 작업 시 함께 동작하는 열의 집합. 레코드라고도 부름                |
| 테이블(table)          | 행의 집합                                                       |
| 결과셋(result set)     | 비 지속적 테이블의 다른 이름으로, 보통 SQL 쿼리의 결과물                          |
| 기본 키(primary key)   | 테이블의 각 행에 대한 고유 식별자로 사용할 수 있는 하나 이상의 열                      |
| 외래 키(foreign key)   | 다른 테이블에서 단일 행을 식별하는 데 사용할 수 있는 하나 이상의 열                     |
| 복합 키(compound key)  | 2개 이상의 열이 결합하여 고유한 값을 가지는 기본 키                              |
| 자연 키(natural key)   | 엔티티의 정보 중 고유한 값을 가져서 각 행마다 식별할 수 있는 의미를 가지는 열               |
| 대리 키(surrogate key) | 엔티티에서 파생된 정보가 아닌 임의의 고유 식별자. 일련번호와 같은 가상의 값으로 기본 키 역할을 하는 열 |

## 1.2 SQL

### 1.2.1 SQL 문 클래스

- SQL 스키마 문(SQL schema statement): 데이터베이스에 저장된 데이터 구조를 정의
- SQL 데이터 문(SQL data statement): 스키마 문으로 정의한 데이터 구조를 조작할 때 사용
- SQL 트랜잭션 문(SQL transaction statement): 트랜잭션의 시작과 종료 및 롤백에 사용

```sql
-- 스키마 문: corp_id, name이라는 두 개의 열을 가지고 기본 키는 corp_id인 테이블을 생성
CREATE TABLE corporation
(
    corp_id  SMALLINT,
    name     VARCHAR(30),
    CONSTANT pk_corporation PRIMARY KEY (corp_id)
);

-- 데이터 문: corp_id 열의 값을 27, name 열의 값은 Acme Paper Corporation인 행을 추가
INSERT INTO corporation (corp_id, name)
VALUES (27, 'Acme Paper Corporation');

-- 셀렉트 문
SELECT name
FROM corporation
WHERE corp_id = 27;
```

### 1.2.3 SQL 예제

- select, from, where

쿼리를 구성할 때는 보통 가장 먼저 필요한 테이블을 정하고 from 절을 추가한다. 이후 데이터 필터링하는 조건을 where 절에 덧붙인다. 마지막으로 테이블에서 검색할
열을 결정하고 이를 select 절에 추가한다.

