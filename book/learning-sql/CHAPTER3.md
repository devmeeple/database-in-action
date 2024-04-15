# 3. 쿼리 입문

select 문의 다른 부분들과 상호작용 방식에 대해 살펴보자.

## 3.1 쿼리 역학

쿼리가 서버로 전송될 때마다 서버는 구문을 실행하기 전에 다음 사항을 확인한다.

- 구문을 실행할 권한(permission)이 있는가?
- 원하는 데이터에 액세스 할 수 있는 권한이 있는가?
- 구문의 문법이 정확한가?

구문은 세 단계를 통과하면 **쿼리 옵티마이저**(query optimizer)로 전달된다. 옵티마이저는 from 절에 명명된 테이블에
조인할 순서 및 사용 가능한 인덱스를 확인한 다음, 서버가 쿼리 실행에 필요한 **실행 계획**(execution plan)을 선택한다.

> 데이터베이스가 서버가 실행 계획을 선택하는 방법을 이해하고 그로 인해 성능에 어떤 영향을 미치는지 아는 것은 중요하다.

## 3.2 쿼리 절

select 문은 여러 개의 구성요소 및 절로 구성된다.

| 절 이름     | 목적                              |
|----------|---------------------------------|
| select   | 쿼리 결과에 포함할 열을 지정                |
| from     | 데이터를 검색할 테이블과, 테이블을 조인하는 방법을 식별 |
| where    | 불필요한 데이터를 걸러냄                   |
| group by | 공통 열 값을 기준으로 행을 그룹화             |
| having   | 불필요한 그룹을 걸러냄                    |
| order by | 하나 이상의 열을 기준으로 최종 결과의 행을 정렬     |

## 3.3 Select 절

- 모든 열 중에 쿼리 결과에 포함하는 열을 결정하는 역할

select 절은 select 문의 첫 번째 절이지만 데이터베이스 서버가 판단하는 마지막 절 중 하나다. select 절의 역할을 이해하려면
from 절을 이해해야 한다.

select 절에는 다음과 같은 항목을 추가할 수 있다.

- 숫자 또는 문자열과 같은 리터럴
- 표현식(expression)
- 내장 함수(built-in function) 호출
- 사용자 정의 함수(user-defined function) 호출

### 3.3.1 열의 별칭

쿼리에서 반환한 열에 대한 레이블을 생성하지만 고유한 레이블을 지정할 수도 있다. 열 별칭을 두드러지게 하려면 별칭 이름 앞에
as 키워드를 사용할 수 있다.

```sql
SELECT language_id,
       'COMMON' AS language_usage -- 'COMMON' language_usage (AS 키워드를 사용하지 않는 방법도 있다.)
FROM language;
```

### 3.3.2 중복 제거

고유한(distinct) 집합으로 보고 싶을때 사용한다. select 키워드 바로 뒤에 distinct 키워드를 추가한다.

```sql
SELECT DISTINCT actor_id
FROM film_actor
ORDER BY actor_id;
```

> distinct 결과를 생성하려면 데이터를 정렬해야 한다. 따라서 결과셋의 용량이 클 때는 시간이 오래 걸릴 수 있다. 따라서
> distinct를 사용하는 함정에 빠지는 대신, 작업중인 데이터를 먼저 이해하고 중복 여부를 파악해야 한다.

## 3.4 From 절

from 절은 쿼리에 사용되는 테이블을 명시할 뿐만 아니라, 테이블을 서로 연결하는 수단도 함께 정의한다.

### 3.4.1 테이블 유형

- **영구 테이블**(permanent table): create table 문으로 생성
- **파생 테이블**(derived table): 하위 쿼리에서 반환되고 메모리에 보관된 행
- **임시 테이블**(temporary table): 메모리에 저장된 휘발성 데이터
- **가상 테이블**(virtual table): create view 문으로 생성

기존에 영구 테이블을 포함하는 것과 함께 각 테이블 유형은 from 절에 포함될 수 있다.

**파생 테이블**

서브쿼리(sub query)는 다른 쿼리에 포함된 쿼리를 의미한다. 서브쿼리는 괄호로 묶여 있다. from 절 내에서 서브쿼리는 명시된
다른 테이블과 상호작용할 수 있는 파생 테이블을 생성하는 역할을 한다.

```sql
SELECT concat(cust.last_name, ', ', cust.first_name) full_name
FROM (SELECT frist_name, last_name, email
      FROM customer
      WHERE first_name = 'JESSIE') cust; -- 서브쿼리 별칭 cust
```

서브쿼리는 별칭을 통해 참조된다. 참조된 데이터는 쿼리 기간 동안 메모리에 보관된 후 삭제된다.

**임시 테이블**

관계형 데이터베이스마다 구현 방식은 다르지만 휘발성의 임시 테이블을 정의할 수 있다. 이러한 테이블은 영구 테이블처럼
보이지만 어느 시점(보통 트랜잭션이 끝날 때 또는 데이터베이스 세션이 닫힐 때)에 사라진다.

```sql
CREATE TEMPORARY TABLE actors_j
(
    actor_id   smallint(5),
    first_name varchar(45),
    last_name  varchar(45)
);
```

> 대부분의 데이터베이스 서버는 세션이 종료될 때 임시 테이블을 삭제한다.

**가상 테이블(뷰)**

뷰는 데이터 딕셔너리에 저장된 쿼리다. 마치 테이블처럼 동작하지만 뷰에 저장된 데이터가 존재하지는 않는다. 이 때문에
가상 테이블이라고 부른다.

```sql
CREATE VIEW cust_vw AS
SELECT customer_id, first_name, last_name, active
FROM customer;
```

뷰를 작성하더라도 데이터가 추가 생성되거나 저장되지는 않는다. 서버는 이후 사용할 때 select 문 대신 뷰가 존재하므로
뷰 쿼리로 사용할 수 있다.

```sql
SELECT first_name, last_name
FROM cust_vw
WHERE active = 0;
```

복잡한 데이터베이스 설계를 단순화 하는 등 다양한 이유로 뷰가 만들어진다.

### 3.4.2 테이블 연결

둘 이상의 테이블이 있으면 테이블을 연결하는데 필요한 조건도 포함해야 한다.

- 테이블 연결(JOIN)

### 3.4.3 테이블 별칭 정의

- 전체 테이블 이름을 사용
- 각 테이블의 **별칭**을 할당하고 쿼리 전체에서 해당 별칭을 사용

별칭 이름을 적절하게 선택하여 사용하면 혼동을 일으키지 않고 더 간결한 진술이 가능하다.

## 3.5 Where 절

결과셋에 출력되기를 원하지 않는 행을 필터링하는 메커니즘이다.

```sql
-- 최소 일주일 동안 대여할 수 있는 G 등급의 영화만 출력
SELECT title
FROM film
WHERE rating = 'G'
  AND rental_duration >= 7;
```

조건과 함께 그룹화하려면 괄호를 사용한다.

## 3.6 Group by 절과 having 절

- 데이터를 열 값 별로 그룹화 하는 group by 절
- group by를 사용하여 행 그룹을 생성하려면 where 절에서 원시 데이터를 필터링할 수 있는 having을 사용하는 방식으로
  그룹화된 데이터를 정제할 수 있다.

## 3.7 Order by 절

- order by 절은 원시 열 데이터 또는 열 데이터를 기반으로 표현식을 사용하여 결과셋을 정렬하는 메커니즘이다.

쿼리에서 반환된 결과셋의 행은 특정 순서대로 나열되지 않는다. 결과셋을 원하는 기준으로 정렬하려면 서버에서 order by 절을
사용하여 정렬하도록 지시해야 한다.

### 3.7.1 내림차순 및 오름차순 정렬

- **오름차순**(descending) **내림차순**(ascending)

기본값은 오름차순이므로 내림차순 정렬을 사용하려면 desc 키워드를 추가해야 한다. 내림차순 정렬은 보통 '상위 5개 계좌의
잔고 표시'와 같은 쿼리 순서를 지정할 때 사용된다.

> MySQL에는 데이터를 정렬한 다음 첫 번째 x행을 제외한 모든 행을 버릴 수 있는 limit 절이 포함되어 있다.