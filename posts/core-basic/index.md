# 김영한의 실전 데이터베이스 - 기본편

## 1.5 MySQL 설치 안내

- MySQL Community Server 8.0, Workbench
- Docker

## 2.1 실습 데이터 준비

- `CREATE DATABASE IF NOT EXISTS [table]`: 데이터베이스가 존재하지 않으면 생성
- `DROP TABLE IF EXISTS [table]`: 테이블이 존재하면 삭제
- `BIGINT`를 사용하는 이유: 서비스가 성장하면 데이터가 기하급수적으로 증가한다. 따라서 `INT`형이 아닌 `BIGINT`를 사용한다.

## 2.2 조인이 필요한 이유

- 데이터 중복(Redundancy)
- 갱신 이상(Update Anomaly)
- 삽입 이상(Insertion Anomaly)
- 삭제 이상(Deletion Anomaly)

- **문제를 해결하기 위해 정규화(Normalization)를 사용한다.** 정규화는 데이터의 중복을 최소화하고, 일관성을 유지하기 위해 논리적인 단위로 분리하는 과정이다.
- 분리한 데이터를 다시 연결하는 기술이 조인(JOIN)이다. 조인은 두 개 이상의 테이블을 특정 컬럼을 기준으로 연결하여 마치 하나의 테이블이었던 것처럼 보여주는 기술이다. 보통 기본키(Primary Key)와 외래키(Foreign Key)를 사용한다.
