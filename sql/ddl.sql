CREATE TABLE employee(
    id INT PRIMARY KEY ,
    name VARCHAR(30) NOT NULL,
    birth_date DATE,
    sex CHAR(1) CHECK(sex in ('M', 'F')),
    position VARCHAR(10),
    salary INT DEFAULT 50000000,
    dept_id INT,
#     FOREIGN KEY (dept_id) references department(id)
#     ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK(salary >= 50000000)
);
