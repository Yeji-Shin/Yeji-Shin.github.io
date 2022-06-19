---
layout: post
title: Docker(3) - Docker Compose 설치
date: 2022-06-19
category: DevOps
use_math: true
---

## Docker Compose 설치

https://docs.docker.com/compose/install/

#### 1. 설치 

python package manager인 pip를 사용하거나 linux는 미리 컴파일된 바이너리 파일을 이용해 설치하면 된다. 해당 바이너리 파일을 다운로드 받아 실행파일 경로에 복사를 한다.

```bash
$ curl -SL https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
```

![image](https://user-images.githubusercontent.com/61526722/174465659-455d8609-58a3-479b-bda8-5487552af227.png)

설정해준 경로에 파일이 만들어 진것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/174465757-f0efda6b-2664-4855-ab58-98187a082b5d.png)

지정한 버전에 맞게 docker-compose가 설치되었다. 

![image](https://user-images.githubusercontent.com/61526722/174465801-2b12c3b0-564a-43a5-bd25-d5433059c40b.png)


#### 2. 실행 권한 부여 

해당 파일에 실행 권한을 부여한다. 

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

![image](https://user-images.githubusercontent.com/61526722/174465723-7794ce6e-69dc-461a-a9d4-ad1c293b3ea3.png)




