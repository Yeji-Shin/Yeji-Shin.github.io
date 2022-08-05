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


### WSL이란? 

WSL (Windows Subsystem for Linux)은 윈도우 환경에서 리눅스의 실행 파일 형식인 ELF64 바이너리를 실행할 수 있도록 하는 기술이다. 다시 말해 윈도우에서 리눅스를 사용할 수 있도록 만들어 주는 기술이다. 

![image](https://user-images.githubusercontent.com/61526722/182985251-95814340-dec9-4edd-b458-7e637fa70a9a.png)

윈도우 상에서 여러 리눅스 배포판을 지원 (Ubuntu, Debian, Alphine, Fedora..)하기 때문에 아주 많은 사람들이 사용한다. 


### 1. WSL 설치

WSL 기능을 사용하기 위해 Windows 기능 활성화를 진행해야 한다. Powershell을 실행하고 DISM 명령어를 통해 기능을 활성화를 진행한다. DISM은 Deployment Image Servicing and Management의 약자로 윈도우 이미지와 관련된 조작을 위한 커맨트라인 명령어이다. 

Powershell을 관리자 권한을 실행한 후에 아래 명령어를 실행한다. 

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart  # 윈도우 서브시스템 기능을 활성화
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart  # 가상머신 플랫폼 기능을 활성화
```

![image](https://user-images.githubusercontent.com/61526722/182986453-427f64f0-ea31-4f61-a93b-2da5066fbaf4.png)

완료되면 재부팅을 한다. 재부팅 후에 powershell 에서 wsl 명령어를 실행해보면 정상적으로 작동하는 것을 확인할 수 있다. 




- WSL 설치를 위해서 '제어판 -> 프로그램 -> 프로그램 및 기능 -> Windows 기능 켜기/끄기'를 선택한 후, Linux용 Windows 하위 시스템의 체크박스를 활성화하고 확인을 눌러준다. 필요한 파일들을 자동으로 다운로드한 후, 재부팅이 될 것이다.

![image](https://user-images.githubusercontent.com/61526722/182984876-f8721f27-8f28-4096-86af-625bacd42a63.png)

- WSLpowershell 관리자 권한으로 실행


![image](https://user-images.githubusercontent.com/61526722/182984509-2e228381-36b1-42ea-b093-2e91acfdfec1.png)

