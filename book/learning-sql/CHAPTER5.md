# 5. 다중 테이블 쿼리

가장 단순하고 일반적인 조인 **내부 조인**(inner join)

## 5.1 조인

조인은 테이블의 열을 하나의 결과셋에 포함하는 작업을 의미한다.

## 5.1.1 데카르트 곱

가장 쉬운 방법은 테이블을 쿼리 from 절에 주고 조인하는 것이다. 이러한 유형의 조인을 **교차 조인**(cross join)이라고 하지만 거의 사용하지 않는다.

```sql
SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a;
```

### 5.1.2 내부 조인

```sql
SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a ON c.address_id = a.address_id;
```