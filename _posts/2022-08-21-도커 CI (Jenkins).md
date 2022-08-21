---
layout: post
title: 도커 CI (Jenkins)
date: 2022-08-21
category: DevOps
use_math: true
---


## Jenkins

Jenkins는 소프트웨어 개발 시 CI 서비스를 제공하는 툴이다. 다수의 개발자들이 하나의 프로그램을 개발할 때 버전 충돌을 방지하기 위해 각자 작업한 내용을 공유 영역에 있는 Git등의 저장소에 빈번히 업로드함으로써 지속적 통합이 가능하도록 해 준다.


- 빌드 자동화 
- 자동화 테스트 
  - git과 같은 버전 관리 시스템과 연동하여 코드 변경을 감지하고 자동화 테스트 수행 
- 코드 품질 검사
  - 성능 측정
- 빌드 파이프라인 구성
  - 두 개 이상의 빌드 스크립트를 통합하여 빌드 파이프라인 구성 가능

---

## Jenkins 플러그인

Jenkins 플러그인은 Jenkins의 기능을 확장해주어 웬만한 작업을 파이프라인화 하여 관리하게 해준다. 플러그 인들은 젠킨스에 여러 유용한 기능들을 추가하여 생산성과 안전성을 높일 수 있다.

- Credential 플러그인 
  - AWS token, Git access token, secret key, ssh 등의 정보를 저장할 때 사용
- Pipeline 플러그인 
  - Jenkins의 파이프라인을 관리해주는 플러그인
  - 업스트림 및 다운 스트림 연결 작업을 미리보기로 시각화하고 처음부터 끝까지 빌드 프로세스에 대한 개요를 제공
- Docker 플러그인
  - Jenkins에서 도커를 사용하기 위한 플러그인

---

## Jenkins 설치

Jenkins 서버를 컨테이너 형태로 띄워본다. 

```
# jenkins 컨테이너 띄우기 
$ docker run --name jenkins -d -p 8080:8080 -v ~/jenkins:/var/jenkins_home -u root jenkins/jenkins:latest
```

![image](https://user-images.githubusercontent.com/61526722/185787784-ea1427be-92e8-4626-854e-77ac90eb0db1.png)

컨테이너를 띄우면 내 로컬에 jenkins라는 파일이 생기고, 그 안에는 jenkins를 실행하기 위한 파일들이 존재한다. 해당 파일들은 컨테이너 안의 /var/jenkins_home 안에 동일하게 존재한다. 

![image](https://user-images.githubusercontent.com/61526722/185788141-235d31a7-d355-4833-a647-c7f1c4117441.png)


최초로 Jenkins를 설치하면 아직 admin 계정이 생성되지 않은 상태이다.  

![image](https://user-images.githubusercontent.com/61526722/185787765-20724596-8c8f-4c26-95fc-04e33e21fcbc.png)


```
# Admin Password 확인 명령어 
$ docker exec -it jenkins bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"
```

![image](https://user-images.githubusercontent.com/61526722/185787837-1524a960-4ec0-4b83-a38a-9b23d8686d71.png)

위의 패스워드를 입력해주면 정상적으로 로그인 되는 것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/185787904-4bec9411-8c61-4204-9bef-430233ba359a.png)

install suggested plugins 를 선택하면 기본적인 플러그인들을 설치하게 된다. 설치가 끝나고 admin user를 설정해준다. 

![image](https://user-images.githubusercontent.com/61526722/185788364-cd46f206-f15e-4a78-8f39-291fb7932535.png)

이제 jenkins 대시보드가 정상적으로 띄워진 것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/185788367-d644e608-11d1-4801-8458-59a7e0024752.png)


jekins 관리 메뉴에서 security 의 manage users에서 테스트 계정을 만들어본다. 

![image](https://user-images.githubusercontent.com/61526722/185788385-fd2625ba-9d8a-4609-8b99-678319a65c78.png)


이제 테스트 계정 setting에서 time zone을  Asia/Seoul 로 설정해준다. 그럼 jenkins 설치는 끝났다.



---

## Jenkins 플러그인 설치

플러그인 설치는 Jenkins 관리 - System Configuration - 플러그인 관리 에서 진행한다. 설치 가능 탭에서 dsl, pipeline, git, docker, AWS, ssh 플러그인을 설치한다.

![image](https://user-images.githubusercontent.com/61526722/185788603-5dba96c7-530d-4092-a5e2-e5486b842a5b.png)

![image](https://user-images.githubusercontent.com/61526722/185788612-40ce8b1d-92a0-4721-937b-b05cfdffaab7.png)


---

## 인증 설정 

- ssh-key 생성 (로컬)
- Github 인증 설정 (ssh-key)
  - jenkins와 git 연결을 위한 인증 
  - git에 있는 코드를 jenkins로 가져오기 위함
- AWS 인증 설정 (aws-key)
  - AWS 계정을 만들 때 생성된 access key를 등록
- 배포 서버 인증 설정 (deploy-key)
  - 실제 컨테이너를 배포할 서버에 접근할 수 있는 AWS 키페어 (pem 키)를 jenkins에 등록 


```
# SSH Key 생성 명령어 :
$ ssh-keygen -b 2048 -t rsa
```


![image](https://user-images.githubusercontent.com/61526722/185788829-5f09f09a-ab38-4eec-921b-d49bbbf9c00b.png)


SSH 키를 생성하면 두 가지 키가 생성되는데, id_rsa는 private key이고, id_rsa.pub은 public key이다. private key는 젠킨스에 등록하고, public key는 git에 등록하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/185788939-0aa9185f-5e54-41f5-93d2-d6c7017aea43.png)

git에 ssh key를 등록하려면 setting - SSH and GPG keys - SSH keys - New SSH key 에 public key의 내용을 넣어준다. 


![image](https://user-images.githubusercontent.com/61526722/185789010-4520d616-e6f4-4a7f-ab22-b548cdcd8a73.png)

이제 jenkins에 키를 등록해주자. Jenkins 관리 - Manage Credentials - Stores scoped to Jenkins - Jenkins - 	Global credentials (unrestricted) - Add Credentials 

![image](https://user-images.githubusercontent.com/61526722/185789870-ada44ef9-3e71-48de-b5f2-174fc8f61d64.png)

AWS key를 추가하려면 같은 방법으로 kind만 AWS Credentials를 선택하면 된다. 같은 방법으로 pem 키도 등록한다. 

------

