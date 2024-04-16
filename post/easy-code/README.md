#  시니어 백엔드 개발자가 알려주는 데이터베이스 개론 & SQL

[시니어 백엔드 개발자가 알려주는 데이터베이스 개론 & SQL](https://www.inflearn.com/course/%EB%B0%B1%EC%97%94%EB%93%9C-%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4-%EA%B0%9C%EB%A1%A0/dashboard)
정리

## SQL로 데이터 처리하기

### 테이블에 데이터 추가 / 수정 / 삭제하기

`WHERE` 조건을 생략하여 수정, 삭제가 가능하지만 **생략 시 데이터 전체에 영향을 준다. 따라서 어떤 데이터를 수정, 삭제하는지 명확하게 조건을 사용해야 한다.** 

추가하기

```sql
INSERT INTO table_name VALUES (comma-seperated all values);  -- 모든 열에 데이터 추가
INSERT INTO table_name (attributes list) VALUES (attributes list 순서와 동일 comma-seperated values); -- 일부 지정하여 추가
INSERT INTO table_name VALUES (..., ..), (..., ..), (..., ..); -- 여러개의 데이터를 한 테이블에 추가
```

수정하기

```sql
UPDATE  table_name(s) -- 테이블명, 복수로 지정 가능
SET attribute = value [, attribute = value, ..] -- 열 = 값, 열 = 값
[WHERE condition(s)]; -- 조건, 조건이 없으면 테이블의 모든 행에 해당
```

삭제하기

```sql
DELETE FROM table_name [WHERE condition(s)];
```


###  데이터 조회하기(SELECT)

SELECT로 조회할 때 조건을 포함해서 조회한다면 조건과 관련된 속성에 `index`가 걸려있어야 한다. 그렇지 않다면 데이터가
많아질수록 조회 속도가 느려진다.

```sql
SELECT attribute(s)
FROM table(s)
[WHERE condition(s)] 
```

AS

- 테이블이나  attribute(속성)에 별칭(Alias)를 붙일 때 사용, 생략 가능

DISTINCT

- SELECT 결과에서 중복되는 튜플을 제외할 때 사용

LIKE

- LIKE: 문자열 pattern matching
- reserved character: `%` 0개 이상의 임의의 개수를 가지는 문자를 의미
- `_`: 하나의 문자를 의미
- escape character: `\`: 예약 문자를 escape 처리하여 본연의 문자로 사용

*(Asterisk)

- 선택된 튜플에 모든 attributes를 보여주고 싶을 때 사용

### 쿼리 안의 쿼리(subquery)

서브쿼리(subquery)

- subquery(nested query 또는 inner query): SELECT, INSERT, UPDATE, DELETE에 포함된 query
- outer query(main query): sub query를 포함하는 query
- subquery는 ()안에 기술됨
- v IN (v1, v2, v3, ...): v가 (v1, v2, v3, ....) 중에 하나와 값이 같다면 TRUE를 반환
  - (v1, v2, v3, ...)는 명시적인 값들의 집합이거나 subquery의 결과(set or multiset)일 수도 있음
  - v NOT IN (v1, v2, v3, ...): v가 (v1, v2, v3, ...) 의 모든 값과 값이 다르다면 TRUE를 반환 

- correlated query: subquery 바깥쪽 query의 attribute를 참조할 때, correlated subquery라고 지칭
- EXISTS: subquery의 결과가 최소 하나의 row라도 있다면 TRUE 반환
- NOT EXISTS: subquery의 결과가 단 하나의 row도 없다면 TRUE 반환

IN, EXISTS는 서로 바꿔가며 사용가능하다.

- v comparison_operator ANY (subquery): subquery가 반환한 결과들 중에 단 하나라도 v와의 비교 연산이 TRUE라면 TRUE를 반환한다.
- `SOME`, `ANY`와 같은 역할

v comparison_operator ALL (subquery): subquery가 반환한 결과들과 v와의 비교 연산이 모두 TRUE라면 TRUE를 반환

### three-valued logic

SQL에서 `NULL`이란 `unkown`, `unavailable or withheld`, `not applicable`을 의미한다. (알려지지 않음, 사용할 수 없음, 해당사항 없음)

- SQL에서 NULL과 비교 연산을 하게 되면 결과는 `unknown`이다.
  -TRUE 일 수도 있고 FALSE 일 수도 있다는 의미다.
- three-valued logic: 비교/논리 연산의 결과로 TRUE, FALSE, UNKNOWN을 가진다.

WHERE 절의 조건은 결과가 TRUE인 행만 선택된다. 즉 결과가 FALSE, UNKNOWN 이면 선택되지 않는다.

### 테이블 조인(JOIN)

두 개 이상의 테이블에 데이터를 한 번에 조회하는 방법이다. 여러 종류의 `JOIN`이 존재한다.

`implicit join` VS `explicit join`

```sql
SELECT d.name
FROM employee AS e, department AS d
WHERE e.id = 1 AND e.dept_id = d.id;
```

- `implicit join`이란 `FROM`절에는 테이블을 나열하고 `WHERE`절에 `JOIN CONDITION`을 명시하는 방식이다.
  - old-style join syntax
- `WHERE`절에 `SELECTION CONDITION`과 `JOIN CONDITION`이 같이 있기 때문에 가독성이 떨어진다.
- 복잡한 `JOIN` 쿼리를 작성하다 보면 실수할 가능성이 높다.

```sql
SELECT d.name
FROM employee AS e JOIN department AS d ON e.dept_id = d.id
WHERE e.id = 1;
```

- `explicit join`이란 `FROM`절에 `JOIN` 키워드와 함께 연결 테이블을 명시하는 방식이다.
- `FROM`절에서 `ON` 뒤에 `CONDITION`이 명시된다.
- 가독성이 좋다.
- 복잡한 `JOIN`쿼리 작성에 비교적 유리하다.

INNER JOIN, OUTER JOIN

INNER JOIN

```sql
FROM 테이블1 [INNER] JOIN 테이블2 ON 조건
```

- `INNER JOIN`은 `JOIN CONDITION`을 만족하는 행들로 결과 테이블을 만든다.
- `JOIN CONDITION`에 사용가능한 연산자(operator): =, <, >, <> 등 여러 비교 연산자
- `JOIN CONDITION`에서 `NULL`값을 가지는 행은 결과 테이블에 포함하지 않는다.

OUTER JOIN

```sql
FROM 테이블1 LEFT [OUTER] JOIN 테이블2 ON 조건
FROM 테이블1 RIGHT [OUTER] JOIN 테이블2 ON 조건
FROM 테이블1 FULL [OUTER] JOIN 테이블2 ON 조건
```

- `JOIN CONDITION`을 만족하지 않는 행도 포함하여 결과 테이블을 만든다.
- `JOIN CONDITION`에 사용가능한 연산자(operator): =, <, >, <> 등 여러 비교 연산자

EQUI JOIN

- `JOIN CONDITION`에 =(equality comparator)를 사용하는 `JOIN`을 의미한다.
- 이때 `EQUI JOIN`을 바라보는 두 가지 시각이 존재한다.
  - INNER, OUTER JOIN 구분없이 =를 사용한 JOIN 이라면 EQUI JOIN을 의미한다.
  - INNER JOIN으로 한정해서 =를 사용한 경우에만 EQUI JOIN을 의미한다.

USING

```sql
FROM 테이블1 [INNER] JOIN 테이블2 USING(열 이름...)
FROM 테이블1 LEFT [OUTER] JOIN 테이블2 USING(열 이름...)
FROM 테이블1 RIGHT [OUTER] JOIN 테이블2 USING(열 이름...)
FROM 테이블1 FULL [OUTER] JOIN 테이블2 USING(열 이름...)
```

- 테이블을 `EQUI JOIN`할 때 조인하는 열 이름이 같다면 `USING` 키워드를 사용하여 간단하게 작성할 수 있다.
- 이 때 같은 열 이름은 결과 테이블에서 한번만 표시된다.

NATURAL JOIN

```sql
FROM 테이블1 NATURAL [INNER] JOIN 테이블2
FROM 테이블1 NATURAL LEFT [OUTER] JOIN 테이블2
FROM 테이블1 NATURAL RIGHT [OUTER] JOIN 테이블2
FROM 테이블1 NATURAL FULL [OUTER] JOIN 테이블2
```

- 같은 이름을 가지는 모든 `attribute pair`에 대해서 `EQUI JOIN`을 수행
- `JOIN CONDITION`을 따로 명시하지 않음

CROSS JOIN

- 테이블의 `tuple pair`로 만들 수 있는 모든 조합(=Cartesian product)를 결과 테이블로 반환한다.
- `JOIN CONDITION`을 따로 명시하지 않음
- `IMPLICIT CROSS JOIN`: FROM 테이블1, 테이블2
- `EXPLICIT CROSS JOIN`: FROM 테이블1 CROSS JOIN 테이블2

> - MySQL에서는 CROSS JOIN = INNER JOIN = JOIN 이다.
> - CROSS JOIN에 ON(or USING) 키워드를 사용하면 INNER JOIN 으로 동작한다.
> - INNER JOIN(or JOIN)이 ON(or USING) 없이 사용되면 CROSS JOIN으로 동작한다.

SELF JOIN

- 자기 자신에게 `JOIN`하는 경우
