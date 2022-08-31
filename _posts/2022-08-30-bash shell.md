---
layout: post
title: bash shell
date: 2022-08-30
category: Linux
use_math: true
---


## shell

shell은 운영체제와 통신할 수 있는 사용자의 유저 프롬프트이다. 사용자의 명령을 받아서 운영체제의 시스템 콜 인터페이스를 통해서 커널에 전달하고 그 기능을 수행하는 역할을 한다. 

현재 사용할 수 있는 쉘은 아래와 같이 확인할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/187454322-3127f56c-aec8-4539-b2b1-6b4bcbe3f5f5.png)

현재 나의 쉘 확인 

![image](https://user-images.githubusercontent.com/61526722/187667799-41bd42aa-9bc4-4064-899d-a97d16e742bb.png)


## prompt

프롬프트는 사용자와 인터렉티브(interactive) 한 입력을 주고 받을 수 있는 명령 대기중임을 표시하는 표시자이다. 

환경변수 PS1 에 기록됨 (PS1 = Prompt Statement One)

![image](https://user-images.githubusercontent.com/61526722/187455300-9a626af1-d93b-4576-b786-8a7abe898180.png)

아래처럼 프롬프트를 이름만 나오게 할 수도 있고 자유자재로 변경이 가능하다. 

![image](https://user-images.githubusercontent.com/61526722/187668481-0a0ea2cf-5e26-40d6-b668-f1ac64365c70.png)



##  출력 (echo)

화면에 글자를 출력한다. 

```bash
echo [OPTION]… [STRING]…
```

- -n : 뉴라인 제외
- -e : Escape 코드 지원 (글자 해석해서 반환)
- -E : Escape 모드 미지원 (기본값)


## 재지향(리다이렉션) (>, >>, 2>, 2>&)

결과물을 다른 장치로 보냄 (output, append, error, merge)

- echo “Hello” > hello.txt : 파일로 출력
- echo “Hello another” > hello.txt : 기존 파일을 덮어씀
- echo “Hello again” >> hello.txt : 기존 파일에 누적
- ls > file.txt : 출력 결과물을 파일로 출력 (단, stdout만)
- aaa > file.txt : 아무런 내용도 기록되지 않음
- aaa 2> file.txt : 실패한 결과물을 파일로 출력

![image](https://user-images.githubusercontent.com/61526722/187669188-ef200dbb-9666-4d67-a9f0-9fd7363e3072.png)


없는 명령어를 치고 결과물을 보내려고 하면 아무런 내용도 기록되지 않는다. 그 이유는 파일에는 출력 장치의 유형이 있기 때문이다. 따라서 실패한 결과물을 파일로 보내고 싶으면 2> 를 사용하면 된다. 2>는 2번 장치에 결과물을 쓰라는 의미이다. 

출력 장치의 유형
- stdout : 표준출력 : 장치번호 1
- stderr : 에러출력 : 장치번호 2
- stdin : 입력장치 : 장치번호 0

![image](https://user-images.githubusercontent.com/61526722/187669517-b659b8b1-58ff-41fb-90ae-290d8d1189cf.png)

아래 예시는 출력 결과물의 성공값(표준출력) 을 hello.txt 로 보내고 에러값(에러출력) 을 1번(표준출력)과 같은 곳으로 보내라는 뜻이다. 쉽게 말하면 성공한 결과와 실패한 결과를 모두 hello.txt로 쓰라는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/187669680-0d639aa1-7d78-40ee-b882-2ebded601185.png)


## 재지향(리다이렉션) (<, <<)

표준 입력(stdin)으로부터 사용자의 입력을 받는다. 


<< 는 이 뒤에 있는 글자가 들어오기 전까지라는 의미로 delimeter 기능을 수행한다. 
• cat << end
표준입력으로부터 end 값이 들어올때까지 입력
• cat << end > hello.txt
표준입력으로부터 end 값이 들어올때까지의 입력
결과를 파일로 출력

## 출력을 가공하기 위한 파이프 (|)


## 명령어 히스토리 (history)

쉘에서 입력한 명령어들의 기록 (최대 1000개 기록)

- history [OPTION]
  - 10 : 최근 10개의 히스토리 보기
  - -c : 히스토리 버퍼 삭제(clear)

- 쉘명령어
  - !15 : 15번째 라인 다시 실행
  - !! : 바로 이전 명령어 다시 실행



## 환경변수 - PATH

어떤 명령어를 실행하면 binary가 실행이 되고, 그 결과를 보여준다. 이때 하드디스크를 전부 뒤져서 해당 명령어 binary가 어디에 있는지를 찾아보면 너무 오랜 시간이 걸린다. 그래서 이 PATH를 중심으로 해당 바이너리를 실행하기 위한 위치들을 검색해준다. 바이너리가 실행되는 순서는 다음과 같다. 

1. PATH 디렉토리 확인
2. 실행권한 확인
3. 명령어를 해당 사용자ID 로 실행


바이너리 실행파일은 PATH의 순서대로 검색이 된다. 바이너리를 실행하는데 바이너리가 실행되는 위치를 확인하기 위해서는 which 명령어를 사용하면 된다. 예를 들어 파이썬이 여러 버전이 있고 여러 경로가 존재할 때 어떤 파이썬이 실행되는지 궁금할 경우 사용하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/187670192-185ed521-0383-4433-adf1-8624f03a5a12.png)

바이너리가 실해되는 위치를 추가할 수 있다. 아래는 현재 디렉토리를 실행되는 위치에 추가한다. 

```
$ export PATH=$PATH:<추가할디렉토리>
```

![image](https://user-images.githubusercontent.com/61526722/187671064-4cafd30d-8f48-4182-a953-fd9eaa0eaa1e.png)

그러면 기존에 실행할 수 없었던 mycat에 있는 파일을 아래와 같이 실행할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/187671162-cec096f5-ae8d-4da8-a186-a0006688e136.png)

다시 되돌리기 위해서는 PATH를 모두 써줘야한다. 특정 경로만 골라서 뺄수 없다. 

![image](https://user-images.githubusercontent.com/61526722/187671432-8f5bad4c-3712-47a7-a33a-517dc4edf7b1.png)

이제 다시 mycat 파일을 실행해도 실행할 수 없다.

![image](https://user-images.githubusercontent.com/61526722/187671538-840a12f5-d925-4070-be9a-38c0cdea40ec.png)

실행할 수 있는 경로로 가서 실행해야 한다. 

![image](https://user-images.githubusercontent.com/61526722/187671592-1ed8a3f9-9489-4edd-9b0e-7c11ce23fbea.png)


printenv 로 현재 시스템의 다양한 환경변수를 확인할 수 있다. 

- PATH: 실행 파일의 경로 모음
- HOME: 사용자의 홈 디렉토리
- PWD: 현재 워킹 디렉토리
- USER: 사용자 아이디
- PS1: 쉘 프롬프트

하나씩 확인하려면 아래 명령어를 사용하면 된다. 

```
echo $환경변수
```

환경변수를 변경하려면 아래와 같이 하면 된다. 

- 환경변수 = 값 (해당 터미널에서만) 
- export 환경변수 = 값 (전체 터미널에서) 


- 언어 (한시적으로) 변경: `LANGUAGE=en COMMAND [ARGS]…`
- 언어셋 (한시적으로) 변경: `LANG=c COMMAND [ARGS]…`
- 영구적으로 변경 시에는 `export LANGUAGE=en`


![image](https://user-images.githubusercontent.com/61526722/187672110-c9e54795-7d53-4105-91b5-0756b6dc4aba.png)


## 단축명령어 (alias)

bash 쉘의 장점은 축약어 기능 (alias)이 있어서 자주 쓰는 긴 명령어를 짧게 요약할 수 있다. ls 명령어는 이미 “ls --color=auto” 의 축약어이고, ll 명령어는 이미 “ls -alF“ 의 축약어이다. 

![image](https://user-images.githubusercontent.com/61526722/187672171-42925afc-43b9-4c39-a47f-34c186e6499a.png)


내가 원하는 대로 축약어를 아래와 같이 설정할 수 있다. 예를 들어 상위 디렉토리로 가는 alias를 만들어보자.

![image](https://user-images.githubusercontent.com/61526722/187672446-b2a12c33-1c27-4559-ae9b-4bac2a2bf9ea.png)


하지만 alias는 저장되지 않는 기능이다. 매번 부팅 될 때마다 alias 기능을 수동으로 입력할 수는 없다. 그래서 쉘 부팅 시퀀스를 사용한다. 

![image](https://user-images.githubusercontent.com/61526722/187672668-81fda860-efc9-44ed-be2a-1c319552107f.png)


## 쉘 부팅(시작) 시퀀스 (.profile, .bashrc 등)

쉘 부팅 시퀀스는 사용자의 쉘이 만들어질때 셋업되는 기본 환경이다. 

아래와 같이 /etc/profile이 제일 먼저 수행되고 profile 디렉토리 안에 있는 공통적인내용들이 수행된다. 공통적인 부분의 실행이 끝나면 개인 설정들이 수행된다. 로컬 환경에 있는 .bashrc 라던지 .profile이 실행되는것이다. alias는 .bashrc안에 저장이 되어 있다. 따라서 내가 설정한 alias가 쉘이 부팅 될때 수행되게 하고 싶으면 .bashrc 파일에 넣어놓으면 된다. 하지만 .bashrc 안에 너무 많은 것들이 있기 때문에 .bash_aliases를 추가해서 alias만 따로 관리해도 된다. 

![image](https://user-images.githubusercontent.com/61526722/187708172-005c8452-4fca-42f1-aa22-67ef2cb34ed4.png)


BASH 의 interactive shell 시작 시퀀스
- /etc/profile 수행 (공통 수행 - 환경 설정들)
- /etc/profile.d/*.sh (공통 수행)
- /etc/bash.bashrc (공통 수행 - 시스템 alias 등)
- ~/.profile 수행 (사용자별 디렉토리 - 시작 프로그램 등)
- ~/.bashrc 수행 (사용자별 디렉토리 - alias 등) 
- ~/.bash_aliases (이 파일이 추가적으로 있다면 수행 - 기본은 없음)

BASH 의 종료 시퀀스
- ~/.bash_logout


참고로 새로운 사용자 계정이 만들어질 때 원본파일 /etc/skel/* 내용이 사용자 home에 복사되어 수행된다. 


## 실행방법 및 shebang

쉘 스크립트를 작성하고 /bin/sh 또는 /bin/bash 를 통해 실행한다. `/bin/sh test1.sh`

이때, 해당 쉘 스크립트의 속성을 첫 줄에 정의해야 한다. (she(#)bang(!) 또는 shabang, hashbang) 이 스크립트가 어떤 속성으로 정의되어 있는지를 표현한다.

- #!/bin/bash
- #!/usr/bin/perl
- #!/usr/bin/python

test.sh 파일을 만들고 쉘을 실행시킨다. 

![image](https://user-images.githubusercontent.com/61526722/187709354-1e9ac737-cdf2-486f-ac1f-770b67445b28.png)

실행 권한을 유저에게 준후에 실행해보자. 

![image](https://user-images.githubusercontent.com/61526722/187709745-724628dd-b76c-4e13-8637-026b72ba06a3.png)


이렇게 해도 되지만 가장 좋은 방법은 쉘 스크립트가 실행될 때 어떤 쉘로 실행할 건지 shebang으로 정의하는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/187710435-b6352a3b-c641-4d7e-aed2-ffa0af5036fe.png)

만약에 파이썬 파일을 실행한다고 하면 다음과 같이 진행하면 된다. 

```
$ python file.py  # 쌩으로 스크립트 파일 실행
$ which python   # which 명령어로 python 경로를 알아내기
```

경로를 알아냈으면 python 스크립트 파일 첫줄에

```python
#! /usr/bin/python 
```

를 추가한 후에 

```
$ chmod u+x file.py
```

로 실행권한을 부여하고

```
$ ./file 
```

`./파일명' 으로  실행이 가능하다. 
