---
layout: post
title: MySQL Basics
date: 2020-05-29
category: MySQL
---
# MySQL 기초 문법

### 기본 문법 
'''ruby
SET
SELECT
FROM
LEFT OUTER JOIN (ON)
WHERE 
ORDER BY
LIMIT
GROUP BY (HAVING)
'''
- SET
  > 어떤 변수에 특정 값을 할당하는 것으로 로컬 변수를 활용한 풀이 할 때 사용
  - SET @VAR := 5; : 사용자 정의 변수 선언 및 초기화 (:=은 대입연산자)
  - SET @A := 15, @B := 20;
- SELECT
  - SELECT COUNT(*): 데이터의 전체 행의 개수 확인
  - SELECT COUNT(NAME): NAME 열에 NULL이 아닌 행의 개수 확인 
  - SELECT COUNT(NAME) AS COUNT: 결과물의 열 이름을 COUNT로 설정
  - SELECT DISTINCT NAME: NAME 열에서 중복 데이터 제거 (DISTINCT는 옆에 온 모든 컬럼을 고려함)
  - SELECT COUNT(DISTINCT NAME): NAME 열에서 중복 데이터 제거한 후 개수 세기
  - SELECT (@HOUR := @HOUR +1) AS HOUR, (SELECT COUNT(*) FROM ANIMAL_OUTS WHERE HOUR(DATETIME) = @HOUR) AS COUNT: HOUR 변수의 값을 1씩 증가시키면서 그에 맞는 개수 세기
  - SELECT IFNULL (NAME, "No Name") AS NAME: NAME열이 NULL인 데이터의 값을 "No Name"으로 변경
- ORDER BY 
  - ORDER BY ANIMAL_ID DESC: 역순정렬(내림차순)
  - ORDER BY ANIMAL_ID ASC: (오름차순)
  - 여러 조건을 한 줄에 사용 가능 ORDER BY ANIMAL_ID ASC, DATETIME DESC
- WHERE
  - 특정 조건을 만족하는 자료 찾기 WHERE INTAKE_CONDITION = 'Sick'
  - 특정 조건을 만족하지 않는 자료 찾기 WHERE INTAKE_CONDITION != 'Sick' OR WHERE INTAKE_CONDITION <> 'Sick'
  - WHERE NAME IS NOT NULL: NULL이 아닌 데이터 찾기
- LIMIT
  > 상위 N개의 데이터 조회하기 위해 사용
  - LIMIT 1: 맨 위에서부터 1개까지의 정보 조회
  - LIMIT 3: 맨 위에서부터 3개까지의 정보 조회
  - LIMIT 2,6: 위에서 2번째 부터 6번째까지의 정보 조회
- GROUP BY (+ HAVING)
  > 같은 그룹끼리 묶어서 조회하기
  - GROUP BY ANIMAL_TYPE: ANIMAL_TYPE 별로 데이터 조회
  - GROUP BY는 WHERE이 아닌 HAVING과 함께 사용해야 함
  - GROUP BY NAME HAVING COUNT(NAME)>1: 이름이 2번 이상 쓰인 이름을 조회
  - GROUP BY HOUR(DATETIME) HAVING HOUR>=9 AND HOUR<=19: DATETIME의 시간만 추출하여 조회
- JOIN
  > 두 테이블의 데이터를 일정한 조건으로 연결하여 하나의 테이블 처럼 만드를 것
  - INNER JOIN: 교집합
  - LEFT OUTER JOIN: 공통적인 부분 + LEFT에 있는 것만
  - RIGHT OUTER JOIN: 공통적인 부분 + RIGHT에 있는 것만
  - LEFT OUTER JOIN + WHERE B.ID IS NULL: A-B
  - RIGHT OUTER JOIN + WHERE A.ID IS NULL: B-A
  - FULL OUTER JOIN: A와 B에 있는 것 모두
  - FULL OUTER JOIN + WHER A.ID IS NULL OR B.ID IS NULL:  교집합을 제외한 모든 부분

