---
layout: post
title: WSL2 + Ubuntu 구성 (Windows)
date: 2022-08-05
category: Python
use_math: true
---


# WSL2 + Ubuntu 구성 (Windows)

윈도우에서 WSL2 기능을 활성화하여 Ubuntu 운영체제를 사용하는 방법을 살펴볼 것이다. 

![image](https://user-images.githubusercontent.com/61526722/182985731-5d1bde92-cc4a-4a60-9772-3e85ed355cf4.png)


## WSL이란? 

WSL (Windows Subsystem for Linux)은 윈도우 환경에서 리눅스의 실행 파일 형식인 ELF64 바이너리를 실행할 수 있도록 하는 기술이다. 다시 말해 윈도우에서 리눅스를 사용할 수 있도록 만들어 주는 기술이다. 

![image](https://user-images.githubusercontent.com/61526722/182985251-95814340-dec9-4edd-b458-7e637fa70a9a.png)

윈도우 상에서 여러 리눅스 배포판을 지원 (Ubuntu, Debian, Alphine, Fedora..)하기 때문에 아주 많은 사람들이 사용한다. 


## 1. WSL 설치

WSL 기능을 사용하기 위해 Windows 기능 활성화를 진행해야 한다. Powershell을 실행하고 DISM 명령어를 통해 기능을 활성화를 진행한다. DISM은 Deployment Image Servicing and Management의 약자로 윈도우 이미지와 관련된 조작을 위한 커맨트라인 명령어이다. 

Powershell을 관리자 권한을 실행한 후에 아래 명령어를 실행한다. 

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart  # 윈도우 서브시스템 기능을 활성화
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart  # 가상머신 플랫폼 기능을 활성화
```

![image](https://user-images.githubusercontent.com/61526722/182986453-427f64f0-ea31-4f61-a93b-2da5066fbaf4.png)

완료되면 재부팅을 한다. 재부팅 후에 powershell 에서 wsl 명령어를 실행해보면 정상적으로 작동하는 것을 확인할 수 있다. 

```
wsl 
```


## 2. Ubuntu 설치

WSL에서 사용하는 리눅스 배포판은 Microsoft Store에서 설치할 수 있다. Microsoft Store에서 Ubuntu를 검색한 후 원하는 버전을 선택하여 다운로드 받으면 된다. 

![image](https://user-images.githubusercontent.com/61526722/182987020-613fd796-b5ba-4652-9717-bb427102c93a.png)

여기서는 Ubuntu 20.04 LTS 버전을 다운 받겠다. 

![image](https://user-images.githubusercontent.com/61526722/182987129-9d95a2b0-ffab-45ce-bb55-429db08b634c.png)

다운로드 완료 후 Ubuntu를 실행한다. 처음 실행 할 때는 세팅 때문에 몇 분 정도 걸릴 수 있다.

![image](https://user-images.githubusercontent.com/61526722/182987196-c0dba8ad-cf24-4fe0-99f1-f57b483cfd73.png)

이제 우분투 운영체제에서 사용할 사용자명과 비밀번호를 입력한다.

![image](https://user-images.githubusercontent.com/61526722/182987329-3043f5db-1b53-4940-9b2a-9991166027df.png)

입력하면 다음과 같이 우분투 shell이 정상적으로 작동하는 것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/182987362-dc898ce0-4f49-465e-9cd1-5cea527ae246.png)

다시 powershell로 돌아가서 Ubuntu 가 정상적으로 설치되었는지 확인한다.

![image](https://user-images.githubusercontent.com/61526722/182987886-8ded3e7f-791e-4a09-9837-738bcefc1abb.png)


## 3. WSL2로 업그레이드

WSL2를 사용하기 위해서는 WSL2 리눅스 커널 업데이트를 설치해야 한다. 아래 링크에서 리눅스 커널 업데이트 파일을 다운받는다. 

https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

다운받은 파일을 실행한다. 

![image](https://user-images.githubusercontent.com/61526722/182988355-e38d2dba-91da-4a5f-b774-b92c4f5462fe.png)
![image](https://user-images.githubusercontent.com/61526722/182988408-8a6ecc20-c710-4e00-882c-e98e7d8e15b0.png)


이제 아래 명령어로 WSL2로 업그레이드를 진행한다.

```
wsl --set-version Ubuntu-20.04 2
```

