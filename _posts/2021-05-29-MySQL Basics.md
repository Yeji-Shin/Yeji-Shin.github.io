---
layout: post
title: MySQL Basics
date: 2020-05-29
category: MySQL
---
# MySQL 기초 문법

### 기본 문법 

>SET
>SELECT... FROM ... JOIN ... (ON) ... WHERE... GROUP BY ... (HAVING) ... ORDER BY ... (LIMIT OFFSET) 


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
  - CASE ~ WHEN ~ THEN ~ ELSE END: WHEN 조건절이 참이면 THEN 절에 있는 내용 출력 아니면 ELSE 절에 있는 내용 출력, 마지막에는 END로 닫아주기
    CASE
      WHEN SEX_UPON_INTAKE LIKE '%Neutered%' OR SEX_UPON_INTAKE LIKE '%Spayed%'
      THEN 'O'
      ELSE 'X' 
    END as '중성화'
  - DATE_FORMAT(DATE,형식)을 통해 DATE의 형식을 바꾸기
  - DATE_FORMAT(DATETIME, '%Y-%M-%D)는 2014-December-25th DATE_FORMAT(DATETIME, '%Y-%m-%d)는 2016-04-02 이런 형식으로 나타냄
  - SELECT TOP 20 PERCENT * FROM CITY ORDER BY AREA DESC
  - SELECT TOP 20 * FROM CITY ORDER BY AREA DESC
  - SELECT * FROM TCIRY ORDER BY AREA DESC LIMIT 3 OFFSET 2: 처음부터 앞의 2개를 건너뛰고 이후 3개의 행을 구한다.
  
  
- ORDER BY 
  - ORDER BY ANIMAL_ID DESC: 역순정렬(내림차순)
  - ORDER BY ANIMAL_ID ASC: (오름차순)
  - 여러 조건을 한 줄에 사용 가능 ORDER BY ANIMAL_ID ASC, DATETIME DESC
  
  
- WHERE
  - 특정 조건을 만족하는 자료 찾기 WHERE INTAKE_CONDITION = 'Sick'
  - 특정 조건을 만족하지 않는 자료 찾기 WHERE INTAKE_CONDITION != 'Sick' OR WHERE INTAKE_CONDITION <> 'Sick'
  - WHERE NAME IS NOT NULL: NULL이 아닌 데이터 찾기
  - WHERE NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty'): IN은 불연속 데이터를 조사할 수 있음. 이름이 다음과 같은 데이터 찾기
  - WHERE NAME LIKE '%el%' AND ANIMAL_TYPE = 'DOG': 이름에 EL 이 들어가면서 개인 데이터 찾기
  - WHERE NAME NOT LIKE '%el%'
  - WHERE SALE LIKE '%30#%' ESCAPE '#': #를 이스케이프 문자로 지정하고 #다음의 %는 일반 문자로 해석
  - WHERE NAME BETWEEN '가' AND '사': BETWEEN은 연속된 범위만 조사할 수 있음
  
  
- LIMIT
  > 상위 N개의 데이터 조회하기 위해 사용
  - LIMIT 1: 맨 위에서부터 1개까지의 정보 조회
  - LIMIT 3: 맨 위에서부터 3개까지의 정보 조회
  - LIMIT 2,6: 위에서 2번째 부터 6번째까지의 정보 조회
  
  
- GROUP BY (+ HAVING)
  > 같은 그룹끼리 묶어서 조회하기
  - GROUP BY ANIMAL_TYPE: ANIMAL_TYPE 별로 데이터 조회
  - GROUP BY DEPART, GENDER: DEPART로 묶고 GENDER로 다시 묶기
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

- COUNT 함수
  - SELECT COUNT(*) FROM TSTAFF WHERE SALARY >= 400: 필드에 상관없이 결과의 레코드 개수 구하기
  - SELECT COUNT(NAME) FROM TSTAFF: NAME에 유효한 값이 ㅡㄹ어있는 레코드의 개수 조사
  - SELECT COUNT(*) FROM TSTAFF WHERE SCORE IS NULL

- 통계값 함수
  - SELECT SUM(POPU), AVG(POPU) FROM TCITY: 인구의 총합과 평균을 구하기
  - MIN
  - MAX
  - STDDEV
  - VARIANCE

- INSERT
  - INSERT INTO 테이블 VALUES 값목록
  - INSERT INTO TCITY (NAME, AREA, POPU, METRO, REGION) VALUES 
    ('서울', 6650, 684, 'Y', '경기),
    ('부산', 768, 8465,  'Y', '경상')
  - INSERT INTO TSTAFF(NAME, DEPART) SELECT NAME, REGION FROM TCITY WEHRE REGION =' 경기'

- DELETE
  - DELETE FROM TCITY WHERE REGION='경기'
  - TRUNCATE TABLE TCITY : ㅌ테이블에 있는 모든 것 다 지우기

- UPDATE
  - UPDATE TCITY SET POPU=1000, REGION='충청' WHERE NAME='서울'

- 서브쿼리
  - SELECT NAME FROM TCITY WHERE POPU=(SELECT MAX(POPU) FROM TCITY)
  - SELECT DELIVERY FROM TCATEGORY WHERE CATEGORY=(SELECT CATEGORY FROM TITEM WHERE ITEM='청바지'): 데이터가 담긴 테이블이 2개일때
