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

- 베이스 이미지를 설정해주는 명령어
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
  
  
  
## RUN

```
RUN ["executable", "param1", "param2"]  
```
  
- 이미지 레이어를 만들어 내는 명령어
- 패키지 설치 등에 사용
  
```
RUN pip install numpy
```
  
- RUN:
- ENV
- ADD
- COPY
- WORKDIR
  
  
## CMD 

```
CMD ["executable","param1","param2"] # (exec form, this is the preferred form)
CMD ["param1","param2"] # (as default parameters to ENTRYPOINT)
CMD command param1 param2 # (shell form)
```

- CMD는 하나만 있어야 함.
- CMD가 여러 줄이면 마지막 줄만 실행됨

