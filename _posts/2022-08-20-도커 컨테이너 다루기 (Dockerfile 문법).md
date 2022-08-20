---
layout: post
title: 도커 컨테이너 다루기 (Dockerfile 문법)
date: 2022-08-20
category: DevOps
use_math: true
---

Dockerfile에서 자주 사용하는 문법들을 살펴보자. 

https://docs.docker.com/engine/reference/builder/


## FROM 

```
FROM <image>[:<tag>] [AS <name>]
```

- 어떤 베이스 이미지를 사용할지 설정해주는 명령어
- 도커파일은 FROM으로 시작해야 함
- tag를 지정해주지 않으면 자동으로 latest 버전을 사용함
- name 지정은 이후의 FROM 문에서 작성된 이미지를 참조하기 위해 사용함


## ARG

```
ARG <key>=<value>
```

- FROM 보다 먼저 나올 수 있는 유일한 명령어
- 이미지 빌드를 위해 Dockerfile 내에서 사용하기 위한 값 (Dockerfile 내에서만 사용 가능)
- 빌드 시점에서 사용, 그러므로 설정을 유지하지 않으려면 ARG 사용
- FROM 이전에 있는 ARG 는 FROM 에서만 사용 가능함
- docker build 명령어에 --build-arg 옵션으로 전달하거나 덮어쓸 수 있음

```
ARG CODE_VERSION=latest
FROM base:${CODE_VERSION}
```

```
docker build . \
  --no-cache \
  -t nginx:latest \
  --build-arg NGINX_VERSION=${nginx_version} \
```

![image](https://user-images.githubusercontent.com/61526722/185737244-99e2fafd-e447-4847-bb99-5d0551450efd.png)


## ENV

```
ENV <key>=<value>  # 한 번에 여러개의 값을 설정할 때
ENV key value  # 한 번에 한개의 값을 설정할 때
```

- 이미지 빌드를 위해 Dockerfile 내에서 사용하기 위한 값 (ARG와 동일)
- 런타임 시점에 사용, 그러므로 설정을 유지하려면 ENV 사용
- docker run 명령어에 --e or --env <key>=<value> 옵션으로 전달하거나 덮어쓸 수 있음
- 컨테이너 안에서 환경변수로 남기 때문에 docker inspect를 사용하여 값 확인 가능
- ARG와 같이 사용하면 항상 ENV 변수가 ARG 변수를 덮어쓰게 됨
  
  
  
## RUN

```
RUN ["executable", "param1", "param2"]  
```
  
- 이미지 레이어를 만들어 내는 명령어
- 라이브러리 설치를 하는 부분에서 주로 활용
  
```
RUN pip install numpy
```
  
  
  
## CMD 

```
CMD ["executable","param1","param2"] # (exec form, this is the preferred form)
CMD ["param1","param2"] # (as default parameters to ENTRYPOINT)
CMD command param1 param2 # (shell form)
```
  
- 이미지로부터 컨테이너를 생성하여 최초로 실행하는 명령어
- CMD는 하나만 있어야 함.
- CMD가 여러 줄이면 마지막 줄만 실행됨
- docker run 명령어를 실행할 때 변경 가능

```
CMD [ "sh", "-c", "echo $HOME" ]
```

## ENTRYPOINT
  
```
ENTRYPOINT ["executable", "param1", "param2"]
```
  
- 이미지로부터 컨테이너를 생성하여 최초로 실행하는 명령어
- 변하지 않고 항상 실행되는 명령어 
  
## WORKDIR
```
WORKDIR /path/to/workdir
```
  
- Dockerfile의 RUN, CMD, ENTRYPOINT, COPY, ADD 명령에 대한 작업 디렉토리 설정하는 명령어
- 여러번 사용 가능, 상대 경로가 제공된 경우 이전 WORKDIR 명령의 경로에 대해 상대적임
- 우분투의 cd 명령어라고 생각하면 됨
  
```
WORKDIR /a
WORKDIR b
WORKDIR c
RUN pwd  # /a/b/c
```
  
## COPY
  
```
# COPY <호스트OS 파일 경로> <Docker 컨테이너 안에서의 경로>
COPY [--chown=<user>:<group>] <src>... <dest>
COPY [--chown=<user>:<group>] ["<src>",... "<dest>"]
```
  
- 호스트의 파일 또는 디렉토리를 컨테이너 안의 경로로 복사하는 명령어
- src는 호스트 운영체제, dest는 컨테이너 내의 경로
- 호스트에서 컨테이너 단순히 복사만을 처리할 때 사용
- 리눅스 환경에서 소유자와 소유그룹 수정 가능 
  
```
COPY test.sh /root/copy/test.sh
```
  

## ADD
  
```
# ADD <호스트OS 파일 경로> <Docker 컨테이너 안에서의 경로>
ADD [--chown=<user>:<group>] <src>... <dest>
ADD [--chown=<user>:<group>] ["<src>",... "<dest>"]
```
- 호스트의 파일 또는 디렉토리를 컨테이너 안의 경로로 복사하는 명령어
- 원격 파일 다운로드, 압축 해제도 가능
- 리눅스 환경에서 소유자와 소유그룹 수정 가능 
  
  
```
ADD test.sh /root/add/test.sh
ADD http://~~~~~~/index.php /root/add_url/index.php
```

## HEALTHCHECK

```
HEALTHCHECK [OPTIONS] CMD command
```

- 컨테이너의 프로세스 상태를 체크하는 명령어
- 하나의 명령만이 유효하고, 만약 여러개가 있다면 가장 마지막에 선언된 HEALTHCHECK가 적용
- HEALTHCHECK의 처음 상태는 starting 이고, HEALTHCHECK가 통과될 때 마다 healthy (이전 상태와 상관없이) 가 됨
- 옵션에 정한 일정 횟수가 실패된다면 unhealthy 상태가 됨
  
  
  - --interval=DURATION (default: 30s): 헬스 체크 간견
  - --timeout=DURATION (default: 30s): 타임 아웃 시간
  - --start-period=DURATION (default: 0s): 컨테이너 초기화 시간
  - --retries=N (default: 3): 타임 아웃 횟수
  
  - 0: success - the container is healthy and ready for use
  - 1: unhealthy - the container is not working correctly
  - 2: reserved - do not use this exit code
  
```
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1  
```

  
## LABEL 

```
LABEL <key>=<value> <key>=<value> <key>=<value> ...
```

- 이미지의 메타데이터를 설정하는 명령어
- 이미지의 버전 정보, 작성자, 코멘트와 같이 이미지 상세 정보를 작성
- docker image inspect --format="{{ .Config.Lables }}" [이미지명]

  
## EXPOSE

```
EXPOSE <port> [<port>/<protocol>...]
```
  
- 해당 컨테이너가 런타임에 지정된 네트워크 포트에서 수신 대기중 이라는것을 알려주는 명령어
- 일반적으로 dockerfile을 작성하는 사람과 컨테이너를 직접 실행할 사람 사이에서 공개할 포트를 알려주기 위해 문서 유형으로 작성할 때 사용됨
- 퍼블리싱을 해주지 않기 때문에 실제로 포트를 열기 위해선 container run 에서 -p 옵션을 사용해야 함 
- 프로토콜을 지정하지 않으면 기본값은 TCP
  
```
EXPOSE 8080  # 이 컨테이너가 8080 port를 사용한다
```
  
  
## USER
  
```
USER <user>[:<group>]
USER <UID>[:<GID>]
```

- 컨테이너를 사용할 기본 사용자를 지정하기 위한 명령어
- 도커 이미지 보안을 위해 사용함
- RUN, CMD, ENTRYPOINT와 같은 명령을 실행하기 위한 특정 사용자를 지정해야 하는 상황에서 사용
- 그륩명과 GID는 생략이 가능
- 
