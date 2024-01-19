# 4. 필터링

- select, update, delete 문의 where 절에서 사용할 수 있는 다양한 유형의 필터조건

모든 SQL 데이터 문에는 SQL 문으로 수행되는 행 수를 제한하기 위해 하나 이상의 필터조건을 포함하는 **where** 절이 선택적으로
포함된다. 또한 select 문에는 그룹화된 데이터의 필터조건을 포함하는 having 절이 포함된다.

## 4.1 조건 평가

where 절은 and 또는 or 연산자로 구분된 하나 이상의 **조건**(condition)을 포함할 수 있다.

- and 연산자로 구분될 경우 행이 결과 셋에 포함되려면 모두 true로 평가되어야 한다.
- or 연산자로만 구성된 경우, 행이 결과에 포함되려면 조건 중 하나만 true면 된다.

### 4.1.1 괄호 사용

where 절에 and 및 or 연산자를 모두 사용하여 조건이 세 개 이상 포함될 경우, 데이터베이스 서버와 코드를 읽는 다른 사람을
위해 괄호를 써서 의도를 명확히 해야 한다.

```sql
WHERE (first_name = 'STEVEN' OR last_name = 'YOUNG')
AND create_date > '2006-01-01'
```

### 4.1.2 not 연산자 사용

not 연산자를 사용하지 않고 where 절을 다시 작성할 수도 있다.

```sql
WHERE first_name <> 'STEVEN' AND last_name <> 'YOUNG'
AND create_date > '2006-01-01'
```

## 4.2 조건 작성

조건은 하나 이상의 **연산자**와 결합된 하나 이상의 **표현식**으로 구성된다. 표현식은 다음 중 하나일 수 있다.

- 숫자
- 테이블 또는 뷰의 열
- 문자열
- 내장 함수
- 서브쿼리
- 표현식 목록

조건 내에서 사용되는 연산자는 다음과 같다.

- =, !=, <, >, <>, like, in 및 between과 같은 비교 연산자
- +, -, * 및 /와 같은 산술 연산자

## 4.3 조건 유형

### 4.3.1 동등조건

필터조건 중 자주 접하는 방식은 '**열 = 표현/값**' 형식이다.

```
title = 'RIVER OUTLAW'
amount = 373.25
film_id = (SELECT film_id FROM film WHERE title = 'RIVER OUTLAW') 
```

이러한 조건은 특정 열과 다른 표현/값을 동일시하기 때문에 **동등조건**(equality conditions)이라고 한다.

#### 부등 조건

**부등조건**(inequality conditions)은 두 표현식이 동일하지 않을 때 사용한다. 부등조건을 구축할 때는 != 또는 <> 연산자를
사용할 수 있다.

#### 동등조건을 사용한 데이터 변경

동등/부등조건은 보통 데이터를 수정할 때 사용된다.

```sql
-- rental 테이블에서 대여 날짜가 2004년인 행을 제거
DELETE
FROM rental
WHERE yaer(rental_date) = 2004;

-- 대여 날짜가 2005년 또는 2006년이 아닌 행을 제거
DELETE
FROM rental
WHERE year (reantal_date) <> 2005 AND year (rental_date) <> 2006;
```

> MySQL 세션은 기본적으로 자동 커밋 모드다.

### 4.3.2 범위조건

해당 식이 특정 범위 내에 있는지를 확인하는 **범위조건**(range conditions)을 작성할 수 있다. 보통 숫자 또는 시간 데이터로 작업할 때 발생한다.

#### between 연산자

범위에 상한과 하한 기준이 **모두** 있을 때, 각각의 개별 조건을 사용하는 대신 다음과 같이 between 연산자를 활용하는 하나의
조건을 사용할 수 있다.

```sql
SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';
```

이때 유의할 점이 있다.

- 항상 범위의 하한값을 먼저 지정하고 상한값을 두 번째로 지정해야 한다. 실수로 상한을 먼저 지정하면 정상적으로 데이터가 반환되지 않는다.
- 상한값과 하한값이 범위에 **포함**되어 결과셋에 포함된다.

#### 문자열 범위

날짜 및 숫자 범위는 쉽게 이해할 수 있는 반면, 문자열 범위는 검색하는 조건을 만들 수도 있지만 가늠하기가 좀 어렵다.

```sql
-- 성(last name)이 특정 범위 내에 속하는 고객을 검색
SELECT last_name, first_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FR';
```

문자열 범위를 사용하려면 캐릭터셋의 문자 순서를 알아야 한다. (캐릭터 셋내에 문자가 정렬되는 순서 규칙을 콜레이션이라고 한다.)

### 4.3.3 멤버쉽 조건

in 연산자를 사용해서 집합의 값 개수에 관계없이 단일 조건을 작성할 수 있다. (표현식이 여러개 포함되어야 하는 경우 유용하다.)

```sql
SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG');
```

#### 서브쿼리 사용

서브쿼리로 즉시 집합을 생성할 수 있다.

```sql
-- 서브쿼리로 조건을 설정하고, 해당 등급의 영화를 출력한다. 기본 쿼리는 서브쿼리가 리턴하는 집합에서 등글 열의 값을 찾는다.
SELECT title, rating
FROM film
WHERE rating IN (SELECT rating FROM film WHERE title = '%PET%');
```

### not in 사용

특정 표현식이 집합 내에 존재하지 **않는지** 여부를 확인할 때 사용한다.

```sql
SELECT title, rating
FROM film
WHERE rating NOT IN ('PG-13', 'R', 'NC-17');
```

### 4.3.4 일치조건

부분 문자열 일치를 처리하는 **일치조건**(matching conditions)

#### 와일드카드 사용

- 특정 문자로 시작 · 종료하는 문자열
- 부분 문자열(substring)로 시작 · 종료하는 문자열
- 문자열 내에 특정 문자를 포함하는 문자열
- 문자열 내에 부분 문자열을 포함하는 문자열
- 개별 문자에 관계없이 특정 형식의 문자열

와일드카드 문자

| 와일드카드 문자 | 일치                   |
|----------|----------------------|
| _        | 정확히 한 문자             |
| %        | 개수에 상관없이 모든 문자(O 포함) |

검색 표현식을 활용하는 조건을 작성할 때는 다음과 같이 like 연산자를 사용할 수 있다.

```sql
-- 두 번째 위치에 A를 포함하고 네 번째 위치에 T를 포함하며 마지막 위치는 S로 끝나는 문자열 지정
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';
```

검색 표현식 사례

| 검색 표현식 | 해석                     |
|--------|------------------------|
| F%     | F로 시작하는 문자열            |
| %t     | t로 끝나는 문자열             |
| %bas%  | 문자열 'bas'를 포함하는 문자열    |
| t_     | 첫 번째 위치에 t가 있는 2글자 문자열 |

```sql
-- 성이 Q 또는 Y로 시작하는 모든 고객을 조회
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'Q%'
   OR last_name LIKE '%Y';
```

#### 정규 표현식 사용

와일드카드 문자로 유연성이 충분하지 않을 때는 정규 표현식(regular expressions)으로 검색식을 작성할 수 있다.

```sql
SELECT last_name, first_name
FROM customer
WHERE last_name REGEXP '^[QY]';
```

## 4.4 Null

null은 값이 없는 것을 의미한다. 하지만 다양한 경우가 있으므로 정의가 약간 불분명하다.

- 해당사항 없음(not applicable)
- 아직 알려지지 않은 값(value not yet known)
- 정의되지 않은 값(value undefined)

null로 작업할 때는 다음 사항들을 기억해야 한다.

- Null일 수는 있지만, null과 같을수는 없다.
- 두 개의 null은 서로 같지 않다.

is null 연산자: 표현식이 null인지 확인

```sql
SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NULL;
```

is not null: 값이 열에 할당되어 있는지 확인

```sql
SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NOT NULL;
```

데이터를 조회할 때는 필터조건에 따라 적절하게 사용하여 데이터가 누락되지 않도록 테이블에서 어떤 열이 null을 허용하는지
확인해야 한다.