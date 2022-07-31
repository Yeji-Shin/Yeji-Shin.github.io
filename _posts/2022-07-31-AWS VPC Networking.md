---
layout: post
title: AWS VPC Networking
date: 2022-07-31
category: AWS
use_math: true
---


## Amazon VPC

Amazon Virtual Private Cloud (Amazon VPC) 는 사용자가 정의한 가상 네트워크이다. 이 가상 네트워크는 AWS의 확장 가능한 인프라를 사용한다는 이점과 함께 기존에 우리가 사용하는 네트워크와 매우 유사한 형태로 사용할 수 있다. 

### VPC의 특징
- 계정 생성 시 default 로 VPC 를 만들어 줌
- EC2, RDS, S3 등의 서비스 활용 가능
- 서브넷 구성
- 보안 설정 (IP block, inbound outbound 설정)
- VPC Peering (VPC 간의 연결 가능)
- IP 대역 지정 가능
- VPC 는 하나의 Region 에만 속할 수 있음 다른 Region 으로 확장 불가능

### VPC의 구성
- Availability Zone: AWS region에서 사용 가능한 데이터센터
- Subnet(CIDR): public subnet과 private subnet으로 구성됨 
- Internet Gateway: VPC 안에 있는 객체들과 인터넷 사이의 통신을 도와주는 매개체
- Network Access Control List (NACL)/security group: 보안 담당
- Route Table: VPC 안에 있는 객체끼리 또는 인터넷과 통신을 하기 위해 필요한 table
- NAT(Network Address Translation) instance/NAT gateway
- VPC endpoint

![image](https://user-images.githubusercontent.com/61526722/181880149-bf51140a-425b-4789-9027-d2a14621264f.png)

-------------


### Availability Zone
- 물리적으로 분리되어 있는 인프라가 모여 있는 데이터 센터
- 각 AZ는 일정 거리 이상 떨어져 있음
- 하나의 region은 2개 이상의 AZ로 구성되어 있음
- 각 계정의 AZ는 다른 계정의 AZ와 다른 아이디를 부여받음 (하나의 데이터 센터에 몰림 방지)

ex) ap-northeast-2 region안에 서울, 부산, 제주도 AZ가 존재함 


### Subnet
AWS region 안에 VPC 존재, VPC 안에 AZ 존재, AZ 안에 Subnet이 존재한다. 

- VPC의 하위 단위 (sub + network)
- 하나의 AZ에서만 생성 가능 
- 하나의 AZ에는 여러 개의 subnet 생성 가능 
- Private subnet과 Public sunbet으로 구성 
  - Private subnet: 인터넷에 접근 불가능한 subnet (VPC 내부안에서만 통신 가능) 
  - Public subnet: 인터넷에 접근 가능한 subnet (외부 네트워크와 통신 가능) 
- CDIR 블록을 통해 subnet을 구분 
  - CIDR: 하나의 VPC 내에 있는 여러 IP 주소를 가각의 subnet으로 분리하는 방법

![image](https://user-images.githubusercontent.com/61526722/181880450-6269cb89-5238-4295-894b-8c4f63870b5c.png)

### Internet Gateway (IGW)

- 인터넷으로 나가는 통로
- Private subnet 은 IGW 로 연결되어 있지 않음
- VPC 내부 연결은 관여하지 않고 VPC 내부와 VPC 외부 간의 연결만 관여

![image](https://user-images.githubusercontent.com/61526722/181881665-8a8d327d-7f37-4eb4-9773-98dcb95378e3.png)


### Route table

- 트래픽이 어디로(local로 가냐 내부로 가냐) 가야 할지 알려주는 테이블
- VPC 생성 시 자동으로 만들어짐
  - 10.0.0.0/16 (10.0.0.0 ~ 10.0.255.255 까지 Local VPC 내부)
  - 나머지는 IGW (인터넷 연결)
  
![image](https://user-images.githubusercontent.com/61526722/181884181-b1719334-1fa3-48df-b8ad-b0b3bd41678e.png)

![image](https://user-images.githubusercontent.com/61526722/181885358-e9bfb3e1-a44d-4732-be13-6eab1b6c7893.png)

### NACL(Network Access Control List) / Security Group
- NACL: 보안 검문소
  - 인바운드, 아웃바운드 규칙을 처리함 
  - NACL은 Stateless 특성을 가짐
  - SG은 Stateful 특성을 가짐
- Access Block 은 NACL 에서만 가능
  - 특정 IP 대역이 우리 네트워크로 들어오는 것(인바운드)를 다 막는 Access block은 SG이 아니기 때문에 NACL에서만 가능
- Security group: VPC subnet 보안의 설정값

![image](https://user-images.githubusercontent.com/61526722/181887333-469db809-70c0-4652-83b3-7b6dc912fde0.png)

### NAT(Network Address Translation) instance/gateway

- Private subnet 안에 있는 private instance 가 외부의 인터넷과 통신하기 위한 방법
  - NAT Instance 는 단일 Instance (EC2)
  - NAT Gateway 는 aws 에서 제공하는 서비스 서비스
- NAT Instance 는 Public Subnet 에 있어야 함

![image](https://user-images.githubusercontent.com/61526722/181892367-1d05d184-1294-4a71-ae7f-3fb3e1720c55.png)

보통 외부 인터넷과 연결이 차단된 Private subnet에는 데이터베이스 같이 보안적으로 중요한 것들을 넣는다. 하지만 데이터베이스 관리 서비스를 업데이트하거나 다운받아야 하는 상황과 같이 외부와 연결이 필요한 경우가 있다. 따라서 private subnet은 필요에 따라 외부와의 연결을 활성화시킬 수 있다. public subnet으로 traffic을 보내고(하나의 VPC 안에 있기 떄문에 통신 가능), public subnet은 IGW로 traffic을 보내 우회적인 방법을 통해 외부와 연결하는 것이다. 이 때 활용하는 것이 NAT gateway이다. NAT gateway 대신 NAT instance를 사용해도 된다. 

![image](https://user-images.githubusercontent.com/61526722/181896107-fefed326-b4b9-4327-80d3-88cca3c0730c.png)

### Bastion host
- Private Instance 에 접근하기 위한 수단
- Public subnet 내에 위치하는 EC2
- Bastion host 에서 ssh 를 private subnet으로 보내서 우회적으로 접근

외부에 있는 관리자가 private subnet 안에서 작업을 해야 할 때 access 해야 한다. 이 때 사용하는 것이 bastion host이며 bastion host는 NAT gateway와 반대되는 개념이다. Bastion host는 외부에서 private subnet에 접근하는 용도, NAT gateway는 private subnet 안에서 외부 인터넷에 접근할 때 사용된다. 

![image](https://user-images.githubusercontent.com/61526722/181899909-f79ffef5-6fae-4bbf-aa64-08ba1a47886e.png)


### VPC Endpoint

VPC 엔드포인트를 통해 인터넷 게이트웨이 , NAT 디바이스 , VPN 연결 또는 AWS Direct Connect 연결을 필요로 하지 않고 AWS Private Link 구동 지원 AWS 서비스 및 VPC 엔드포인트 서비스에 비공개로 연결 할 수 있다. VPC 의 인스턴스는 서비스의 리소스와 통신하는데 퍼블릭 IP 주소를 필요로 하지 않는다. 

- Aws 의 여러 서비스들과 VPC 를 연결시켜주는 중간 매개체
  - Aws 에서 VPC 바깥으로 트래픽이 나가지 않고 aws 서비스를 사용할 수 있게 만들어주는 서비스
  - Private subnet 에서도 aws 의 다양한 서비스들 (S3, dynamodb, athena 등) 연결할 수 있도록 지원하는 서비스


- Interface Endpoint : Private ip 를 할당받아 서비스로 연결해줌 (SQS, SNS, Kinesis, Sagemaker 등 지원

![image](https://user-images.githubusercontent.com/61526722/181903034-61d7c4ee-e3df-43a6-8a13-b35b0e77c544.png)

- Gateway Endpoint : 라우팅 테이블에서 신호를 서비스에 연결 (S3, Dynamodb 지원)

![image](https://user-images.githubusercontent.com/61526722/181903040-3046fb98-07bb-49d1-bd79-e1aaf0043c94.png)



