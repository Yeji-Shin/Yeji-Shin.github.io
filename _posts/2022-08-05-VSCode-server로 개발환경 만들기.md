---
layout: post
title: VSCode-server로 개발환경 만들기
date: 2022-08-05
category: Python
use_math: true
---

# VSCode-server로 개발환경 만들기

Window PC에서 VS code-server를 통해 외부에서 접속 가능한 개발환경을 만드는 방법을 알아본다. 

## code-server란? 

vs code-server는 electron 기반 오픈소스인 VS Code를 Node.js 통해 Server를 올리고 크롬 브라우져에서 직접 VS Code 에디터를 사용할 수 있도록 만들어진 오픈소스이다.

- Code everywhere
  - Code on your Chromebook, tablet, and laptop with a consistent development environment.
  - Develop on a Linux machine and pick up from any device with a web browser.
- Server-powered
  - Take advantage of large cloud servers to speed up tests, compilations, downloads, and more.
  - Preserve battery life when you’re on the go as all intensive tasks runs on your server.
  - Make use of a spare computer you have lying around and turn it into a full development environment.

윈도우 환경에서 우분투 환경을 만든 뒤에 VS code-server를 실행시킴으로써 언제 어디서나 Chrome 브라우져가 있는 곳이라면 내 PC환경의 VS code editor를 통해 개발할 수 있는 환경을 만들어보겠다. 

## 1. Ubuntu에 필수 프로그램 및 code-server 설치

```
$ sudo apt-get update
$ sudo apt-get install build-essential net-tools
$ wget -q https://github.com/cdr/code-server/releases/download/3.4.1/code-server_3.4.1_amd64.deb  # code-server 다운로드 
$ sudo dpkg -i code-server_3.4.1_amd64.deb  # 파일 압축 풀기
$ export PASSWORD=password >> ~/.bashrc # .bashrc (로그인할 때 실행되는 개인 사용자 시작파일)에 비밀번호 저장
$ echo $PASSWORD  # 환경변수가 잘 들어갔는지 확인 (생략가능)
$ source ~/.bashrc  # .bashrc 파일의 변경사항 바로 적용
$ sudo ufw allow 8080/tcp # 8080 port 방화벽 해제
```

## 2.  VS Code extensions 패키지를 설치 후, code-server 실행

```
$ code-server --install-extension ms-vscode.cpptools ms-vscode.cpptools formulahendry.terminal hookyqr.beautify
$ code-server
```

![image](https://user-images.githubusercontent.com/61526722/183006386-7fbb6639-19bb-494f-bd17-464dea1a35f3.png)

이제 크롬브라우져에서 http://localhost:8080에 접속하면 위와 같이 VS Code 에디터가 동작하고 에디터에 설치한 확장 패키지가 적용된 것을 볼 수 있다.

![image](https://user-images.githubusercontent.com/61526722/183006546-756bfd2c-f096-44ab-bc35-988a2df2d5e4.png)

## 3. port forwarding

이제 외부에서 나의 VSCode 에디터에 접속하기 위한 포트 포워딩을 실행한다. 

공유기 설정을 바꾸기 위해 http://192.168.0.1/에 접속한다. (ipTIME 공유기) 관리도구 -> 고급 설정 -> NAT/라우터 관리 -> 포트포워드 설정 에 들어가서 새규칙을 추가한다. 

![image](https://user-images.githubusercontent.com/61526722/183007087-480c9a41-9511-43f6-9f49-ae90df974345.png)


![image](https://user-images.githubusercontent.com/61526722/183006652-999f3e19-9102-499e-aeb1-57df190fb671.png)

 ifconfig를 통해 확인한 inet address 172.20.12.68을 적어준다.

다시 우분투 터미널에서 code-server를 실행한다. 

```
$ code-server --bind-addr 172.20.12.68:8080
```

이제 크롬 브라우저에서 http://[본인 ip]:8080 으로 VSCode에 접속이 가능하다. 본인 IP는 네이버에서 확인하면 된다. 

