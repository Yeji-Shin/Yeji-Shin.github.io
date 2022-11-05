---
layout: post
title: Submodule
date: 2022-11-05
category: Git
---

### Git Submodule

깃 서브모듈은 깃 레포지토리 아래에 다른 하위 깃 레포지토리를 관리하기 위한 도구이다. 하나의 프로젝트에서 다른 프로젝트를 함께 사용해야 하는 경우 주로 활용한다.

---

### 서브 모듈 추가하기

일단 git repo에 부모 repo와 자식 repo를 만들어준 후 워킹 디렉토리에 부모 repo를 클론한다.

```python
$ git clone <부모 repository url>
$ cd <부모 repository url>
```

![image](https://user-images.githubusercontent.com/61526722/200105256-f760095b-edab-4b2a-b293-ad281693b8df.png)

다음으로 서브모듈을 추가 해본다. 

```python
$ git submodule add {submodule_repository_url}
$ git submodule add -b {branch_name} {submodule_repository_url}
```

![image](https://user-images.githubusercontent.com/61526722/200105259-1c8d5118-11dd-4e18-80bd-cd5b4e735f1b.png)

서브 모듈을 추가하면 .gitmodules 라는 숨김 파일이 생성된다. .gitmodules 에는 프로젝트에서 관리하고 있는 서브모듈 목록에 대한 정보가 들어있다. 

![image](https://user-images.githubusercontent.com/61526722/200105264-c0972f34-621d-4a4a-9050-1ee4bf2301d3.png)

이 파일에 브랜치 정보를 넣어두면 해당 브랜치를 기준으로 서브모듈을 업데이트 할 수 있다.

```json
[submodule "submodule_c"]
        path = submodule_c
        url = https://github.com/Yeji-Shin/submodule_c.git
				branch = main
```

---

### 서브모듈 커밋하기

서브모듈을 추가하면 바로 새로 커밋해야 할 파일들이 나타난다. 아래 파일들을 add 하고 커밋해야 우리가 원하는 대로 메인 레포지토리에 서브모듈이 반영된다. 

![image](https://user-images.githubusercontent.com/61526722/200105275-c915b43d-5c19-4ead-a53a-e34e7fe7f0e4.png)

submodule_c는 깃 레포지토리를 포함하고 있는 디렉토리이지만, 깃에서는 서브모듈 정보를 포함하고 있는 파일처럼 관리한다. mode 160000 이라는 건, 일반 파일이 아니라는 의미이고, +Subproject commit b177534... 는 현재 부모 레포지토리에서 하위 레포지토리의 b177534 커밋을 바라보고 있단 의미이다.

![image](https://user-images.githubusercontent.com/61526722/200105279-4a317f42-6863-49b4-bf19-ac17b9e7b22a.png)

부모 레포지토리에 push 까지 하면 서브모듈이 잘 적용된것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/200105283-e7bb3ffe-7af4-4aa5-9d05-9c450f8c576e.png)

![image](https://user-images.githubusercontent.com/61526722/200105294-1f304de8-b8bb-4f7b-b0b8-aa94e764d7c4.png)

---

### **서브모듈이 있는 레포지토리 클론하기**

서브모듈이 있는 프로젝트를 클론하기 위해서 워킹 디렉토리로 이동한 후에 다른 이름으로 부모 레포지토리를 클론해본다. 

![image](https://user-images.githubusercontent.com/61526722/200105324-2e1a457b-6771-4fde-bd96-1d83afb09c18.png)

이렇게 부모 레포지토리를 클론하면 자식 레포지토리는 존재하지만 내용은 비어있다. 따라서 서브모듈을 가져오려면 먼저 서브모듈을 초기화하고 업데이트해야 한다. 서브모듈 업데이트는 현재 부모 레포지토리의 커밋에서 참조하고 있는 서브모듈의 커밋을 자식 레포지토리의 원격 저장소에서 체크아웃해온다는 뜻이다. 이 부분은 제일 처음에 한번만 수행하면 된다. 

```bash
# 1. 부모 레포지토리 클론
$ git clone <parent repo url>

# 2. 서브모듈 초기화
$ git submodule init

# 3. 부모 레포지토리가 기억하는 서브모듈의 특정 커밋 시점으로 업데이트
$ git submodule update
```

![image](https://user-images.githubusercontent.com/61526722/200105359-e006232f-785b-49d1-aff2-c405faa08b29.png)

서브모듈 업데이트까지 진행하면 서브모듈 디렉토리에도 .git 파일이 제대로 생성된다. 

![image](https://user-images.githubusercontent.com/61526722/200105388-6c3d6528-1435-483f-b51a-42b8e3dfc4b5.png)

자식 레포지토리의 깃 브랜치를 확인해보면 detached 상태로 되어 있다. 부모 프로젝트에서 서브모듈을 업데이트하면 브랜치나 태그 같은 간접 레퍼런스를 가져오는 것이 아니라, 저장된 특정 커밋을 체크아웃 하는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/200105412-38636b8d-e7ec-404d-ac92-679bd18d3fef.png)

**한 번에 자식 레포지토리까지 처리하기** 

추가로, 메인 프로젝트 clone에서 하위 프로젝트 적용까지 하나의 명령어로 처리할 수도 있다.

```bash
$ git clone --recurse-submodules <부모 레포지토리 url>
```

![image](https://user-images.githubusercontent.com/61526722/200105435-aead184b-fc02-486b-bd02-f7f546391eb9.png)

---

### 변경된 서브모듈 업데이트

메인 프로젝트에 submodule이 이미 있고, 하위 프로젝트의 새로운 커밋을 가져와야 하는 상황에선 update 명령어를 활용한다. 이 명령어로 메인 프로젝트에서 submodule의 커밋을 가져오면, 이전에 봤던 것처럼 새로 커밋해야 하는 파일이 생긴다. 앞서 한 것과 동일하게 해당 파일을 add, commit, push해서 로컬과 원격 프로젝트에 반영한다.

```bash
# .gitmodules 파일에 정의되어 있는 브랜치(default는 main 또는 master)의 최신 버전으로 업데이트
$ git submodule update --remote

# 로컬에서 작업 중인 부분과 원격에 작업된 부분이 다른 경우 머지까지 진행
$ git submodule update --remote --merge
```

먼저 자식 레포지토리에 빈 커밋을 하나 날린다. --allow-empty 옵션은 빈 커밋을 생성하는 옵션이다. 그 후 서브모듈 업데이트를 해주면 된다. 

![image](https://user-images.githubusercontent.com/61526722/200105467-21fbd0ea-e0d6-4a7a-a745-ea9eaf09ed51.png)

![image](https://user-images.githubusercontent.com/61526722/200105495-09bc8957-4de1-4af3-97eb-9a6bd46f7dbc.png)
