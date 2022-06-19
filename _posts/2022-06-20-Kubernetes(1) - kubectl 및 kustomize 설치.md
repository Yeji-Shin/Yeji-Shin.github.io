---
layout: post
title: Kubernetes(1) - kubectl 및 kustomize 설치
date: 2022-06-20
category: DevOps
use_math: true
---

## Kubectl

kubectl은 쿠버네티스를 위한 커맨드라인 도구로, 쿠버네티스 API 서버와 통신하여 사용자 명령을 전달하는 CLI 도구이다. 

![image](https://user-images.githubusercontent.com/61526722/174466798-a48d15d2-7a13-47ca-bd9e-de7259de5fa0.png)

쿠버네티스는 클러스터 시스템으로 master node와 worker node가 있다. Master node 안에는 API 서버가 존재하는데 이를 사용해 쿠버네티스 클러스터에 연결해 명령어를 주고 받는다. kubectl를 통해 API 서버에 인증을 하고 API 서버에 여러가지 쿠버네티스 명령어를 전달한다. 

![image](https://user-images.githubusercontent.com/61526722/174466815-f0ca3e97-73db-4a2f-886f-a9b06276cae2.png)


## kubectl 설치

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management

#### 1. Update the apt package index and install packages needed to use the Kubernetes apt repository

```bash
$ sudo apt-get update
$ sudo apt-get install -y apt-transport-https ca-certificates curl
```

![image](https://user-images.githubusercontent.com/61526722/174466953-d0e4f2ee-bdc2-49e0-8c63-bd84f65105a3.png)

![image](https://user-images.githubusercontent.com/61526722/174467019-806a591a-e848-43c5-b081-02664986a519.png)


#### 2. Download the Google Cloud public signing key

```bash
$ curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
```

![image](https://user-images.githubusercontent.com/61526722/174467109-c5a2feac-bdc6-47ad-9485-33eb1e5e575d.png)


#### 3. Add the Kubernetes apt repository

```bash
$ echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

![image](https://user-images.githubusercontent.com/61526722/174467157-33e7419d-8e2b-48c7-8455-7c76a780da05.png)


#### 4. Update apt package index with the new repository and install kubectl

```bash
$ sudo apt-get update && sudo apt-get install -y kubectl
```

![image](https://user-images.githubusercontent.com/61526722/174467178-f5ae7706-a7bf-471f-ac2e-4073ab44dd42.png)


## kustomize

kustomize는 컨테이너 기반의 어플리케이션을 효율적으로 운영하도록 도와주는 클러스터 오케스트레이션 시스템이다. 오케스트레이션 시스템에 올라가게 될 어플리케이션 정보들을 쿠버네티스 매니페스트의 형태로 관리하는데 이러한 매니페스트의 관리는 kubectl에서 진행할 수 있지만 어플리케이션의 개수가 많아지면 관리가 불편해진다. 이를 해결하기 위해 다양한 오픈소스들이 생겨나는데 현재는 kustomize와 helm이라는 도구가 가장 많이 사용된다. kustomize는 kubectl 안에 내장된 함수이다. 쿠버네티스 매니페스트들을 chart 로 패키징하게 되는데 Helm은 이를 기반으로 어플리케이션을 관리하는 도구이다. 

![image](https://user-images.githubusercontent.com/61526722/174467573-641a6ea9-ab97-4af4-83d3-a4a2a3c4bc74.png)

![image](https://user-images.githubusercontent.com/61526722/174467578-f4b98e5c-e046-4d31-aae5-64c8d88530c9.png)

기본적인 쿠버네티스 매니페스트 파일 구조인 base에 overlay라는 파일을 patch 해서 여러 환경에 적용할 수 있다. 예를 들어 특정 러플리케이션을 스테이징 환경용으로도 배포하고 싶고, prod 환경용으로 배포하고 싶을 때 각각 환경별로 특정값을 다르게 할 수 있다.

## kustomize 설치 

https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/

바이너리를 직접 받아서 설치를 진행한다. 

#### 1. Download kustomize binary


```bash
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/kustomize/${KUSTOMIZE_VERSION}/hack/install_kustomize.sh"  | bash
```

![image](https://user-images.githubusercontent.com/61526722/174467676-a4f92a2a-50e0-44fc-a7f4-2b2338bca42d.png)


#### 2. Install to /usr/local/bin

```bash
sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize
```

![image](https://user-images.githubusercontent.com/61526722/174467748-fcd077cd-2519-42c4-98d7-953489b2203e.png)


잘 설치된 것을 확인할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/174467740-e74f1048-b93b-41b8-9b98-95405c48ded7.png)


