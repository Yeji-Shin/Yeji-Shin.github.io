---
layout: post
title: 도커 컴포즈 (Grafana + MySQL 구성)
date: 2022-08-21
category: DevOps
use_math: true
---

## 1. Grafana 구성하기

Grafana를 아래와 같은 조건으로 구성해보자. Grafana의 기본 포트는 3000번이다. 

- Grafana의 3000번 포트는 호스트의 3000번 포트와 바인딩
- Grafana의 설정파일인 grafana.ini는 호스트에서 주입 가능하도록 구성하고 읽기전용 설정 
  - 호스트에서 설정파일 관리할 수 있게 구성
  - 컨테이너에서는 설정파일 변경하지 못하도록 구성
- Grafana의 로컬 데이터 저장 경로를 확인하여 도커 볼륨 마운트
  - Grafana가 내부적으로 데이터를 쌓는 경로를 도커 볼륨에 마운트하여 컨테이너가 종료되어도 로컬에 데이터가 남아있도록 구성 
- Grafana의 플러그인 추가 설치를 위한 환경변수 설정
- 로그 드라이버 옵션을 통해 로그 로테이팅
  - docker compose 에서 컨테이너를 띄울 때 옵션을 추가하여 데이터가 무한대로 쌓이지 않도록 구성

Grafana 도커 가이드

`https://grafana.com/docs/grafana/latest/installation/docker/`


```
# docker-composer.yml
version: '3.9'

services:
  grafana:
    image: grafana/grafana:8.2.2
    restart: unless-stopped
    environment:
      GF_INSTALL_PLUGINS: grafana-clock-panel
    ports:
    - 3000:3000
    volumes:
    - ./files/grafana.ini:/etc/grafana/grafana.ini:ro
    - grafana-data:/var/lib/grafana
    logging:
      driver: "json-file"
      options:
        max-size: "8m"
        max-file: "10"

volumes:
  grafana-data: {}
```

grafana 서비스의 이미지는 grafana/grafana:8.2.2로 한다. restart: unless-stopped는 서버가 종료되더라도 컨테이너를 다시 시작하는 옵션으로 서버가 재시작 되어도 자동으로 컨테이너가 켜져있다. GF_INSTALL_PLUGINS: grafana-clock-panel는 grafana-clock-panel 플러그인를 설치한다. 호스트의 3000번 포트와 컨테이너의 3000번 포트를 바인딩한다. /etc/grafana/grafana.ini는 grafana 컨테이너가 기본적으로 불러들이는 grafana 설정 파일이다. 호스트의 ./files/grafana.ini파일을 /etc/grafana/grafana.ini 경로에 읽기모드로 마운트시킨다. /var/lib/grafana는 로컬 데이터 저장소가 된다. 디폴트로 SQLite 를 사용하기 때문에 파일 형태로 데이터가 저장될 것이다.   "json-file"  드라이버를 사용하여 stdout과 stderror로 로그를 출력한다. 로그파일 하나당 8MB, 로그 파일은 10개 만든다. 


```
# ./files/grafana.ini
app_mode = production
instance_name = ${HOSTNAME}

#################################### Server ####################################
[server]
protocol = http
http_addr =
http_port = 3000

#################################### Logging ##########################
[log]
mode = console
level = info

#################################### Alerting ############################
[alerting]
enabled = true

```

![image](https://user-images.githubusercontent.com/61526722/185783118-6d9efda7-7c9f-4cc3-909c-47a8a56c4b08.png)

![image](https://user-images.githubusercontent.com/61526722/185783101-e7f163c7-c824-4119-95ee-ca26e50f5e89.png)

인터넷으로 grafana가 접속된다. grafana의 기본 사용자 값은 admin / admin 이다. 

![image](https://user-images.githubusercontent.com/61526722/185783254-6615048b-bcc0-4272-9e97-8954a67813e9.png)

server adimin에 setting 을 들어가면 현재 세팅 값들을 알 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/185783304-8ea1ef73-417f-4e19-a303-26cd913bf199.png)


데이터베이스는 sqlite3을 사용하고 있는 것을 볼 수 있다. 경로는 grafana.db를 바라보고 있다.  

![image](https://user-images.githubusercontent.com/61526722/185783323-c4c73b1d-2e53-4f78-a8df-ea1384208212.png)


이제 볼륩까지 포함하여 docker-compose를 제거한다. 

![image](https://user-images.githubusercontent.com/61526722/185783372-c9243b06-08e9-4f7b-9f32-b1ea0a568f26.png)




---

## 2. Grafana + MySQL 구성하기

Grafana + MySQL을 아래와 같은 조건으로 구성해보자. Grafana는 기본적으로 데이터를 저장할 때 SQLite DB를 사용한다. SQLite는 파일 형태의 데이터베이스 인데, 이 데이터베이스가 로컬 경로에 저장된다. 하지만 데이터가 많아지는 것을 대비하여 MySQL을 사용하도록 한다. 

- 1단계 요구사항 포함
- grafana.ini를 통해 database 설정을 sqlite에서 MySQL로 변경
- MySQL 컨테이너를 docker-compose에 db 서비스로 추가
- grafana 서비스가 db 서비스를 database로 연결하도록 구성
- MySQL의 로컬 데이터 저장 경로 확인하여 도커 볼륨 마운트

MySQL 도커 가이드

`https://hub.docker.com/_/mysql`

```
# docker-compose.yml
version: '3.9'

services:
  db:
    image: mysql:5.7
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: grafana
      MYSQL_DATABASE: grafana
      MYSQL_USER: grafana
      MYSQL_PASSWORD: grafana
    volumes:
    - mysql-data:/var/lib/mysql
    logging:
      driver: "json-file"
      options:
        max-size: "8m"
        max-file: "10"

  grafana:
    depends_on:
    - db
    image: grafana/grafana:8.2.2
    restart: unless-stopped
    environment:
      GF_INSTALL_PLUGINS: grafana-clock-panel
    ports:
    - 3000:3000
    volumes:
    - ./files/grafana.ini:/etc/grafana/grafana.ini:ro
    - grafana-data:/var/lib/grafana
    logging:
      driver: "json-file"
      options:
        max-size: "8m"
        max-file: "10"

volumes:
  mysql-data: {}
  grafana-data: {}
```

새롭게 db 라는 서비스가 만들어진다. db 서비스는 네가지 환경변수를 가진다. 루트 계정의 패스워드, 데이터 베이스 이름, 사용자명, 사용자 패스워드도 모두 grafana로 설정한다. 

![image](https://user-images.githubusercontent.com/61526722/185783458-a998dded-d3d6-4c63-97a0-49f38b7740a0.png)

MySQL은 기본적으로 `/var/lib/mysql` 경로에 데이터를 쌓는다. 이 데이터를 호스트에서 영구적으로 관리하기 위해서 도커 볼륨으로 mysql-data 경로에 연결한다. 따라서 volumes 옵션에 mysql-data를 명시해준다. grafana 서비스는 depends_on 옵션으로 db 서비스가 만들어진 후에 만들어진다. 

```
# ./files/grafana.ini
app_mode = production
instance_name = ${HOSTNAME}

#################################### Server ####################################
[server]
protocol = http
http_addr =
http_port = 3000

#################################### Database ####################################
[database]
type = mysql
host = db:3306
name = grafana
user = grafana
password = grafana


#################################### Logging ##########################
[log]
mode = console
level = info

#################################### Alerting ############################
[alerting]
enabled = true
```

이제 도커 컴포즈를 실행해보자. 

![image](https://user-images.githubusercontent.com/61526722/185783684-60121d7d-71b3-45f1-b875-4de54475e357.png)

![image](https://user-images.githubusercontent.com/61526722/185783709-d761e6c1-481a-4756-aa1f-3b5b77e55724.png)

아까와 다르게 database setting이 mysql로 변경되었다. 

![image](https://user-images.githubusercontent.com/61526722/185783730-ae4a0f5d-5ef6-43a7-98bc-1d62d738af83.png)

데이터의 보관이 영구적으로 일어나는지 확인해보자. server admin으로 들어가서 사용자를 만든다. 

![image](https://user-images.githubusercontent.com/61526722/185783796-257f18ee-d7ec-4f63-80c7-9b0fe509de77.png)

사용자가 만들어 진것을 확인하고 로그아웃을 한다. 

![image](https://user-images.githubusercontent.com/61526722/185783808-4036c7fc-195f-470e-98ab-0b1b540808df.png)

이 상태로 도커 컴포즈를 삭제해본다. 컨테이너와 네트워크가 모두 삭제되었다. 볼륨은 삭제하지 않음

![image](https://user-images.githubusercontent.com/61526722/185783837-30df2d3e-9a03-4d11-b8e7-345ceaa9ed42.png)

다시 도커 컴포즈를 실행해본다. 

![image](https://user-images.githubusercontent.com/61526722/185783890-5dcd6551-6640-45f2-b231-0e3edddab577.png)

그리고 아까 만든 사용자명으로 로그인이 되는 것을 볼 수 있다. 이렇게 볼륨을 호스트에 영구적으로 보관한다. 






