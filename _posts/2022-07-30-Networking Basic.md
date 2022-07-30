---
layout: post
title: Networking Basic
date: 2022-07-30
category: AWS
use_math: true
---

## 네트워킹 기초 

### IP(Internet Protocol) Address

컴퓨터 사이에 통신을 하려면 컴퓨터의 위치값을 알아야 하는데, 각 컴퓨터나 노트북 스마트폰 등의 위치값(주소)를 IP 주소라고 한다. 이러한 IP 주소는 기본적로 IPv4 형식을 따른다. IPv4는 8bit 짜리 4단위(옥탯)로 32 bit의 주소 길이를 가지며, 존재할수 있는 IPv4의 IP 개수는 2^32 (42억개 정도)가지이다.

![image](https://user-images.githubusercontent.com/61526722/181878301-474df43b-983d-4772-9011-55b19423e309.png)

### IPv4 Class

IPv4의 IP는 일반적으로 A class, B class, C class .. 로 구분된다. 첫 번째 옥텟의 앞지리 숫자들을 바탕으로 class를 구분하게 되는데 예를 들어 첫 번째 옥텟이 0으로 시작하는 IP는 A class에 속한다.

![image](https://user-images.githubusercontent.com/61526722/181879092-34c752e4-c46f-4c65-ab74-a2e564bb9637.png)

위 그림처럼 IPv4의 32bit 주소는 network bit와 host bit로 나누어진다. Network bit는 이 IP 주소가 어떤 network 안에 포함되어 있는지를 나타낸다. 

A class의 경우는 class 식별자인 0을 제외한 나머지 7bit가 network bit이고, 첫번째 옥텟을 제외한 나머지 24bit가 host bit이다. 따라서 A class는 하나의 네트워크 안에 2^24개의 host(ip)가 존재할 수 있고, 이런 네트워크가 2^7개 만큼 존재할 수 있다. 이렇게 A class는 하나의 네트워크 당 규모는 크지만 네트워크의 개수는 상대적으로 적다. 

B class는 network bit가 두 번째 옥텟까지 확장된 형태이다. 1개의 네트워크가 2^16개의 ip를 보유할 수 있고, 이런 네트워크가 2^14개 만큼 있으므로 A class 보다는 네트워크 크기는 작지만 네트워크 개수가 늘어난 것이다. 

C class는 동일한 방식으로 1개의 네트워크가 2^8개의 ip를 보유할 수 있고, 이런 네트워크가 2^21개 만큼 있다. 네트워크 개수가 많이 필요없어 개인이 많이 사용하게 된다. 

![image](https://user-images.githubusercontent.com/61526722/181879258-4e1b8cb9-8016-47c0-9267-acd7b4b1b31e.png)


(Host는 특정 네트워크 안에 종속된 것으로 어떤 네트워크에 host 가 10개라는 것은 해당 네트워크에 IP 주소가 10개 라는 것과 동일한 의미이다.)

### Subnet

하지만 IP개수가 너무 많아지면서 이를 보완하기 위해 subnet이라는 개념이 등장한다. 쉽게 말해 IP가 부족하니깐 IP를 나눠서 쓰자는 것이다. 아래 그림은 C class의 특정 네트워크를 두 개의 subnet으로 나눈 형태이다. 

![image](https://user-images.githubusercontent.com/61526722/181879521-1f8fb405-80b9-411b-91ae-67a8f17ea165.png)

보면 빨간색 네모 친 부분만이 변경되고, 이를 간단하게 CIDR로 표기한 것을 볼 수 있다. CIDR은 / 앞부부에 특정 subnet의 가장 첫 번째 IP 주소 (시작점 IP)를 표기하고, / 뒷부분에는 특정 subnet 안에서 무조건 고정되어 있는 bit의 개수를 적는다. 


특정 네트워크를 4개의 subnet으로 나누면 아래와 같이 된다. 

![image](https://user-images.githubusercontent.com/61526722/181879694-99c7b588-a01a-486a-8b15-816112448c8c.png)

우리가 2개의 subnet으로 나누면 1개의 bit가 추가 되었는데, 4개의 subnet으로 나누면 2개의 bit가 추가되에서 / 뒤에는 26bit가 된다. 
