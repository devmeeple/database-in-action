# 김영한의 실전 데이터베이스 - 기본편

## 1.5 MySQL 설치 안내

- MySQL Community Server 8.0, Workbench
- Docker

## 2.1 실습 데이터 준비

- `CREATE DATABASE IF NOT EXISTS [table]`: 데이터베이스가 존재하지 않으면 생성
- `DROP TABLE IF EXISTS [table]`: 테이블이 존재하면 삭제
- `BIGINT`를 사용하는 이유: 서비스가 성장하면 데이터가 기하급수적으로 증가한다. 따라서 `INT`형이 아닌 `BIGINT`를 사용한다.
