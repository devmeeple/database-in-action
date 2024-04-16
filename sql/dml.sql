# 테이블에 데이터 추가하기 값을 추가할 때는 속성의 순서에 맞게 작성해야함

INSERT INTO employee VALUES (1, 'MESSI', '1987-02-01', 'M',  'DEV_BACK', 100000000, null);
# INSERT INTO employee VALUES (1, 'JANE', '1996-05-05', 'F',  'DSGN', 40000000, null); primary key(기본키) 위배: 기본키는 중복되면 안된다. 이미 1번이 존재한다.
# INSERT INTO employee VALUES (2, 'JANE', '1996-05-05', 'F',  'DSGN', 40000000, null); constraint(제약조건) 위배: salary의 값은 50000000(5천만) 이상이어야 한다.
# INSERT INTO employee VALUES (2, 'JANE', '1996-05-05', 'F',  'DSGN', 90000000, 111); foreign key 참조 제약조건 위배
INSERT INTO employee VALUES (2, 'JANE', '1996-05-05', 'F',  'DSGN', 90000000, null);

# 어떤 제약조건이 위배되었는지 구체적으로 확인하기(MySQL)
SHOW CREATE TABLE employee;

# 값 넣기 열 지정(순서가 자유롭다)
INSERT INTO employee(id, name, birth_date, sex, position) VALUES (3, 'JENNY', '2000-10-12', 'F', 'DEV_BACK');

# 데이터 조회(전체)
SELECT * FROM employee;

# 데이터 수정하기
UPDATE employee SET dept_id = 1003 WHERE id = 1;
SELECT * FROM employee WHERE id = 1;

# 개발팀 연봉을 두 배로 인상
UPDATE employee SET salary = salary * 2 WHERE dept_id = 1003;

# 프로젝트 ID 2003에 참여한 임직원의 연봉을 두 배로 인상
# UPDATE employee, works_on  SET salary = salary * 2 WHERE id = empl_id and proj_id = 2003;

# 직관적으로 작성하기
# UPDATE employee
# SET salary = salary * 2
# WHERE employee.id = works_on.empl_id and proj_id = 2003;

# 데이터 삭제하기
# John이 퇴사 하게되어 정보를 삭제한다
# John의 아이디는 8이다, John은 project 2001에 참여했다
DELETE FROM employee WHERE id = 8;

# Jane이 휴직하게되어 프로젝트에서 하차했다. 아이디는 2
# DELETE FROM works_on WHERE empl_id = 2;

# 현재 Dingyo가 두 프로젝트에 참여하고 있었는데 2002에서 하차하고 2001에 집중한다. 아이디는 5
# DELETE FROM works_on WHERE empl_id = 5 and proj_id = 2002;

# 2001외에 프로젝트를 모두 하차한다
# DELETE FROM works_on WHERE empl_id = 5 and proj_id <> 2001;
# DELETE FROM works_on WHERE empl_id = 5 and proj_id != 2001;

# 회사에 사정 상 모든 프로젝트가 취소됐다.
# DELETE FROM project;

# 데이터 조회
# ID가 9인 임직원의 이름과 직군 조회
SELECT name, position FROM employee WHERE id = 9;

# 프로젝트 2002를 리딩하는 임직원의 ID, 이름, 직군
# SELECT employee.id, employee.name, employee.position
# FROM project, employee
# WHERE project.id = 2002 AND project.leader_id = employee.id

# AS 사용하기
# SELECT e.id, e.name, e.position
# FROM project AS p, employee AS e
# WHERE p.id = 2002 AND p.leader_id = e.id;

# SELECT e.id AS leader_id, e.name AS leader_name, e.position
# FROM project AS p, employee AS e
# WHERE p.id = 2002 AND p.leader_id = e.id;

# DISTINCT 사용하기
# 디자이너들이 참여하고 있는 프로젝트의 ID와 이름을 알고 싶다
# SELECT DISTINCT p.id, p.name
# FROM employee AS e, works_on AS w, project AS p
# WHERE e.position = 'DSGN'
#   AND    e.id = w.empl_id AND w.proj_id = p.id;

# LIKE
# 이름이 N으로 시작하거나 N으로 끝나는 임직원들의 이름 조회
SELECT name
FROM employee
WHERE name LIKE 'N%' OR name LIKE '%N';

# 이름에 NG가 들어가는 임직원들의 이름 조회
SELECT name
FROM employee
WHERE name LIKE '%NG%';

# 이름이 J로 시작하는, 총 4글자의 이름을 가지는 임직원의 이름 조회
SELECT name
FROM employee
WHERE name LIKE 'J____';
# WHERE name LIKE '%J' AND LENGTH(name) = 4;

# Escape 문자와 함께 LIKE 사용하기
# %로 시작하거나 _로 끝나는 프로젝트 이름 조회
# SELECT name
# FROM project
# WHERE name LIKE '\%%' OR name LIKE '%\_';

# *(Asterisk) 사용하기
# ID가 9인 임직원의 모든 attributes
SELECT * FROM employee WHERE id = 9;

# subquery 쿼리를 한번에 사용하기
# ID가 14인 임직원보다 생일이 빠른 임직원의 ID, 이름, 생일 조회(기존에 알고있던 방법으로는 두번에 나눠서 작성해야함)
# SELECT birth_date FROM employee WHERE id = 14;
# SELECT id, name, birth_date FROM employee WHERE birth_date < '1992-08-04';
SELECT id, name, birth_date FROM employee
WHERE birth_date < (
    SELECT birth_date FROM employee WHERE id = 14
    );

# ID가 1인 임직원과 같은 부서 같은 성별인 임직원들의 ID와 이름과 직군 조회
SELECT id, name, position
FROM employee
WHERE (dept_id, sex) = (
SELECT dept_id, sex
FROM employee
WHERE id = 1
);

# ID가 5인 임직원과 같은 프로젝트에 참여한 임직원들의 ID

# 1) 두번에 나눠서 조회하기
# SELECT proj_id FROM works_on WHERE empl_id = 5; 임직원이 일하고 있는 프로젝트를 조회
# SELECT DISTINCT empl_id
# FROM works_on
# WHERE empl_id != 5 AND (proj_id = 2001 OR proj_id = 2002);

# 2) 개선하기
# SELECT DISTINCT empl_id
# FROM works_on
# WHERE empl_id != 5 AND proj_id IN (2001, 2002);

# 3) 서브쿼리 사용
# SELECT DISTINCT empl_id FROM works_on
# WHERE empl_id != 5 AND proj_id IN
# (SELECT proj_id FROM works_on WHERE empl_id = 5);

# ID가 7 또는 12인 임직원이 참여한 프로젝트 ID와 이름 조회
# SELECT p.id, p.name
# FROM project AS p
# WHERE EXISTS (
#     SELECT *
#     FROM works_on AS w
#     WHERE w.proj_id = p.id AND w.empl_id IN (7, 12)
# );

# 2000년대생이 없는 부서의 ID와 이름을 조회
# SELECT d.id, d.name
# FROM department AS d
# WHERE NOT EXISTS(
#     SELECT *
#     FROM employee e AS e
#     WHERE e.dept_id = d.id AND e.birth_date >= '2000-01-01'
# );

# 리더보다 높은 연봉을 받는 부서원을 가진 리더의 ID, 이름, 연봉 조회
# SELECT e.id, e.name, e.salary
# FROM department AS d, employee AS e
# WHERE d.leader_id = e.id AND e.salary < ANY (
#     SELECT salary
#     FROM employee
#     WHERE id <> d.leader_id AND dept_id = e.dept_id
# );

# ID가 13인 임직원과 한번도 같은 프로젝트에 참여하지 못한 임직원들의 ID, 이름, 직군 조회
# SELECT DISTINCT id, e.name, e.position
# FROM employee AS e, works_on AS w
# WHERE e.id = w.empl_id AND w.proj_id <> ALL(
#     SELECT proj_id
#     FROM works_on
#     WHERE empl_id = 13
# );
