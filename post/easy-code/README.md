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
