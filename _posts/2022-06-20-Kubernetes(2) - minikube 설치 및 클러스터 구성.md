---
layout: post
title: Kubernetes(2) - minikube 설치 및 클러스터 구성
date: 2022-06-20
category: DevOps
use_math: true
---

## minikube 

쿠버네티스는 오케스트레이션 시스템으로 컨테이너를 클러스터 레벨에서 효율적으로 관리하는 시스템이다. minikube는 작은 쿠버네티스로 간단한 쿠버네티스 환경을 구성할 수 있는 솔루션이다. 따라서 실제 운영환경에서 쓰기 어렵지만 쿠버네티스 학습 목적으로 활용하기 좋다. 

minikube는 드라이버를 선택하여 원하는 가상환경(docker, podman, virtualbox, vmware 등)에서 구성가능하다.

## minikube 설치

https://minikube.sigs.k8s.io/docs/start/

minikube는 아래 환경이 만족한 상태에서 원활하게 작동한다.

![image](https://user-images.githubusercontent.com/61526722/174470323-9764d91c-ff94-45a2-93f4-8ca818421bcb.png)

#### 바이너리 파일을 사용해 다운받기

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
```

![image](https://user-images.githubusercontent.com/61526722/174470386-dd2cd8cf-4af8-4e5a-8e20-64858fc34669.png)

```bash
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

![image](https://user-images.githubusercontent.com/61526722/174470418-128c38cd-468d-49c1-8ca4-b22a1f2c42aa.png)

------

## 쿠버네티스 클러스터 구성 

minikube start로 local 환경에 쿠버네티스 클러스터를 구성할 수 있다. 


#### docker 위에 클러스터 구성

minikube로 docker 가상환경 드라이버를 이용해 docker container 위에서 쿠버네티스 클러스터를 구성해본다.  

```bash
$ minikube start --driver docker
```

![image](https://user-images.githubusercontent.com/61526722/174470597-225ea7e5-a6f3-4add-877e-2db279aa21ea.png)

#### config 파일 형식

kubectl이 클러스터와 통신하기 위해서 필요한 config 파일은 아래 위치에 존재한다. yaml 형식의 파일이다. 

```bash
$ cat ~/.kube/config
```
![image](https://user-images.githubusercontent.com/61526722/174470667-df74f135-9861-4961-8e1a-39c2c1d10682.png)

clusters 키는 관리할 클러스터 목록, contexts 키는 어떤 클러스터와 통신을할지에 대한 인증과 관련된 설정, users 키는 인증 사용자 정보를 담고 있다. context는 cluster와 user를 조합하여 해당 cluster에 해당 user 정보로 인증하겠다는 뜻이다. 따라서 contexts를 어떻게 설정하느냐에 따라 어떤 클러스터에 어떤 유저로 접속하겠다가 결정된다. 또한, 현재 kubectl이 사용하는 context 정보가 current-context에 기입된다. 

#### 노드 정보 확인 

현재 kubectl이 접속하게 될 노드 정보를 확인한다.

```bash
$ kubectl get nodes
```

![image](https://user-images.githubusercontent.com/61526722/174470804-68f09358-32e8-479c-a5f6-513493dc958a.png)

node의 이름은 minikube이고, 7m58s 전에 생성되었다는 것을 알 수 있다. 

#### 클러스터 정보 확인

```bash
$ kubectl cluster-info
```

![image](https://user-images.githubusercontent.com/61526722/174470893-ba1d5719-a748-4580-b025-d8a198ef5d00.png)

#### 쿠버네티스 클러스터 상태 확인

```bash
$ minikube status
```

![image](https://user-images.githubusercontent.com/61526722/174470921-990bd4cb-6f7b-4afb-aefd-9d8cb88f8f29.png)

minikube 위에서 클러스터가 잘 실행되고 있음을 알 수 있다. 

#### minikube 기본 명령어 

```bash
$ minikube stop      # 클러스터 중지 
$ minikube start     # 클러스터 시작 
$ minikube pause     # 클러스터 일시중지 
$ minikube unpause   # 클러스터 재개 
$ minikube delete    # 클러스터 삭제  
```

#### minikube addon

minikube는 addon이라는 설치 도구를 제공하는데, kubernetes에서는 사용할 수 없다. 

```bash 
$ minikube addons list  # minikube가 제공하는 addon list
$ minikube addons enable [ADDON NAME]  # 해당 ADDON 에 필요한 컨테이너 이미지 다운로드 및 활성화 
$ minikube addons disable [ADDON NAME] # 애드온 비활성화
```

![image](https://user-images.githubusercontent.com/61526722/174471162-c80db31c-4822-4b2a-8515-83f509d87ba1.png)

![image](https://user-images.githubusercontent.com/61526722/174471261-7eeb7eae-9edc-49fc-9eaa-0ee3768de9e2.png)

#### minikube ssh 

아까 kubectl 에 노드가 한 개 있었는데 그 노드의 ssh 에 접근한다. 

```bash
$ minikube ssh  # 클러스터 노드에 SSH 접속
```

![image](https://user-images.githubusercontent.com/61526722/174471353-d93613d7-f950-475c-8007-cb1cad987056.png)

minikube의 클러스터를 구성하고 있는 docker container로 들어간 상태이다. 

#### minikube kubectl

minikube는 kubectl이라는 sub command를 사용해 클러스터 버전과 동일한 kubectl 버전을 이용하도록 한다. 

```bash
$ minikube kubectl  # 쿠버네티스 클러스터 버전과 대응되는 kubectl 
```

![image](https://user-images.githubusercontent.com/61526722/174471418-baaa2999-ce2d-42ca-9dc1-73dee1b8bd9c.png)
