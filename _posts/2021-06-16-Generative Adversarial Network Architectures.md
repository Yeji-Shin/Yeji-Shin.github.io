---
layout: post
title: Generative Adversarial Network Architectures
date: 2021-06-16
category: DeepLearning
use_math: true
---

이전 문서에서 GAN이 무엇인지 살펴보았다. 이번에는 대표적인 GAN 모델들을 살펴볼 것이다. 

---

### 1. InfoGAN

InfoGAN은 요즘에 잘 쓰는 GAN은 아니지만 가지고 있는 특징이 살펴볼 만한 내용이라 포함시키게 되었다. 우리가 가짜 이미지를 만들 때 원하는대로 그리려면 generator의 입력인 random noise vector를 우리마음대로 조정해야 하는데 vanilla GAN은 그 control에 대한 개념이 없다. 하지만 InfoGAN은 이 control에 대해서 고민한 모델이다. 

#### Entagled vs Disentangled

![image](https://user-images.githubusercontent.com/61526722/121904618-4f8d0e00-cd64-11eb-82b5-13752a12e5f9.png)

Entangled라는 것은 꼬여있다는 뜻이다. 우리가 $z_{1}$과 $z_{2}$를 조절하여 원하는 가짜 이미지를 만들려고 할 때 $z_{1}$과 $z_{2}$와 가짜 이미지 사이의 관계가 왼쪽 그림과 같다면 원하는 그림을 그리기가 매우 곤란할 것이다. 예를 들어 진돗개를 그리고 싶은데 파란색 영역에 있는 $z_{1}$과 $z_{2}$를 골라내는 것이 쉽지 않기 때문이다. 그에 반해 오른쪽 그림은 $z_{2}$값이 고정되어 있으면 $z_{1}$이 어떤 값이 되던 같은 영역으로 잘 정리되어 있다. 어떻게 하면 $z_{1}$과 $z_{2}$를 오른쪽 그림과 같은 관계를 맺도록 할 수 있을까의 고민에 대한 결과가 InfoGAN이다.  

![image](https://user-images.githubusercontent.com/61526722/121904741-6cc1dc80-cd64-11eb-8f4f-51affcd19cf7.png)

왼쪽은 entangled의 예이고 오른쪽은 disentangled의 예이다. Entagled되어 있으면 각 변수가 어떤 의미를 가지고 있는지 해석하기 어렵다. 하지만 disentangled 되어 있으면 원하는 그림을 그릴 수 있을 것이다. 

#### InfoGAN (2016)

![image](https://user-images.githubusercontent.com/61526722/121905022-ac88c400-cd64-11eb-8c63-5d2d5a079eba.png)

InfoGAN은 왼쪽의 기존 GAN을 오른쪽과 같이 변형했다. 여기서 C와 Z는 모두 랜덤 벡터이다. 다만 우리가 원하는 것은 C가 class로 활용되어 가짜 이미지의 type을 결정해주고, Z는 type 외의 것들을 결정해주는 것이다. 변수의 역할을 나누어주는 것이다. 

이렇게 만들기 위해서는 간단히 GAN loss에 C와 fake image의 <mark>correlation이 커지도록 하는 loss를 더해</mark>주면 된다. Correlation이 크다는 얘기는 C가 변하는 것에 따라서 fake image가 변한다는 것이다. 

InfoGAN에서 사용하는 correlation이라는 것은 <mark>mutual information</mark>이다. 

![image](https://user-images.githubusercontent.com/61526722/121906131-c676d680-cd65-11eb-8500-aefdbbb1fbe1.png)

따라서 C와 fake image의 correlation을 반영하는 식을 추가하여 이것이 커지는 방향으로 학습하도록 설계한다. 하지만 이 correlation을 구하는 것이 어렵기 때문에 variational lower bound를 사용했다고 한다. 이 정도만 알아두면 될 것 같다. 

---

### 2. Condition GAN (CGAN) (2014)

InfoGAN을 더 쉽게 만든 것이 CGAN이다. 대신 CGAN은 <mark>real data에 label이 다 있어야 한다</mark>는 제약조건이 있다. 

![image](https://user-images.githubusercontent.com/61526722/121907138-bf03fd00-cd66-11eb-8c94-ffd349f73a01.png)

CGAN에서의 C는 random noise가 아니다. 학습 데이터의 label중 하나, 예를 들어 1을 C에 주고 random noise를 주면 generator는 이미지를 만들어 낸다. 물론 generator는 C, 1이 무슨 의미인지 모른다. 1이라는 값은 real data에도 들어가는데 label이 1인 학습 데이터중에서 random하게 하나를 고른다. 그러면 discriminator는 가짜 이미지를 1번 class의 real인지 1번 class의 fake인지 구별하도록 학습된다. 정리하면 CGAN은 label이 있어야 된다는 단점이 있지만 우리가 원하는 그림을 그릴 수 있게 한다. 

---

### 3. Image-to-Image Translation (2016)

우리가 입력 출력 쌍을 주어 supervised learning을 진행하면 MSE loss를 사용하게 될 것이고, 생성된 이미지가 선명하지 않고 blur할 것이다. 이렇게 입력 출력 쌍을 주어서 supervised learning을 하면 퀄리티가 좋지 않은 이미지가 생성되므로 이를 GAN을 이용해서 해결하자라는 것이 Image-to-Image Translation이다. 

![image](https://user-images.githubusercontent.com/61526722/121909751-35a1fa00-cd69-11eb-9ed8-d81948279772.png)

Discriminator에는 보통 한장의 그림이 들어가지만 Image-to-Image Translation에서는 <mark>discriminator에 두 장의 그림이 들어간다</mark>. 입력 이미지와 출력이미지 pair가 들어가서 이것이 진짜 pair인지 가짜 pair인지 구별한다. 

![image](https://user-images.githubusercontent.com/61526722/121909250-b3b1d100-cd68-11eb-9e29-c76e19fa0e73.png)

하지만 입력, 출력 쌍의 데이터를 획득하기 어렵다. 이러한 문제점을 극복한 것이 CycleGAN이다. 

---

### 4. CycleGAN (2017)

CycleGAN도 Image-to-Image Translation인데 입력이미지와 출력이미지의 짝을 맞출 필요가 없다. 

![image](https://user-images.githubusercontent.com/61526722/121909760-376bbd80-cd69-11eb-9463-df1d3da87cf8.png)

예를 들어 horse를 zebra로 바꿔주는 generator를 만든다고 하자. 

![image](https://user-images.githubusercontent.com/61526722/121909918-5e29f400-cd69-11eb-82ab-ef30be3bd7b2.png)

G1에게는 아무 그림이나 그리고 G2에게도 아무 그림이나 그리라고 하지만 원래 그림이랑 비슷한 그림을 그리라는 숙제를 준다. 아무거나 그리고 아무거나 그렸을 때 제자리로 돌아와야 하니깐 G1은 최소한의 변형만 시키려고 할 것이다. 변형을 많이 시키면 다시 돌아오는 것이 어렵고 그럴수록 reconstruction loss는 커지기 때문이다. 그리고 실제 그림과 가짜 그림 중에 랜덤으로 골라서 discriminator에게 주고 real/fake를 맞추라고 한다. 그러면 G1은 discriminator를 속일 만한 그림을 그리라는 두 번째 숙제를 받게 되는 것이다.  

정리하면 G1은 discriminator를 속이는 데 도움이 안되는 것은 최대한 그냥 복제를 할 것이다. 다시 복원을 시켜야 하니깐 discriminator를 속이기 위한 최소한의 부분만 변경하게 된다. 뒷 배경은 그대로 두고 말만 얼룩말로 바꾸는 것이다. 

---

### 5. StackGAN (2017)

StackGAN은 텍스트를 이미지로 변경하는 모델이다. 

![image](https://user-images.githubusercontent.com/61526722/121911510-c927fa80-cd6a-11eb-8242-da8ec93f7f37.png)

텍스트에 해당하는 내용을 가지고 representation을 생성하고 random noise에 text representation을 섞어서 generator에게 준다. Discriminator한테는 text에 대한 진짜 그림을 주면 real로 말하도록, text에 대한 가짜 그림을 주면 fake로 말하도록한다. 

![image](https://user-images.githubusercontent.com/61526722/121912102-3f2c6180-cd6b-11eb-9f90-43bb13d8875d.png)

---

### 6. Progressive GAN (PGGAN) (2017)

GAN은 이미지를 잘 만드는 것처럼 이야기 했지만 실제로는 32x32, 64x64, 128x128 정도의 이미지를 생성한다. 1024x1024를 진짜 같이 만들어내는 것은 100만개의 점의 generator가 찍어내는 것이기 때문에 쉬운 일이 아니다. PGGAN은 어떻게 고해상도의 이미지를 생성하냐에 대한 연구이다. 

![image](https://user-images.githubusercontent.com/61526722/121913520-6fc0cb00-cd6c-11eb-82a6-3a446aa27f3c.png)

아이디어는 점차적으로 고해상도의 이미지를 만들어내는 것이다. 처음에는 4x4이미지를 만들고 진짜인지 가짜인지 구분하도록 학습을 시킨다. 물론 드리어오는 이미지들은 모두 4x4로 downsampling 되어야한다. 그 다음에는 4x4이미지를 받아서 8x8이미지를 만들고 이를 다시 4x4로 downsampling하여 진짜인지 가짜인지 구분하도록 한다. 

![image](https://user-images.githubusercontent.com/61526722/121914156-faa1c580-cd6c-11eb-936a-99820372f28d.png)

이때 16x16이미지를 만들고 다음으로 32x32이미지를 만들어야하는데 갑자기 32x32를 만들려고 random하게 초기화된 weight가 끼는거니깐 학습이 잘 안될것이다. 그래서 (b)처럼 16x16이미지를 두배로 늘린것과 초기화된 weight로 만들어진 32x32이미지를 적당한 비율로 섞어서 discriminator로 내려보낸다. 그래서 처음에는 $\alpha$를 굉장히 작은 값으로 두고 32x32에 대한 weight들을 천천히 학습시킨다. 점차적으로 $\alpha$값을 높여가면서 학습시키다가 $\alpha$가 1이 되면 32x32 weight가 학습된다. 이러한 방식으로 PGGAN은 1024x1024의 고해상도 이미지를 성공적으로 생성할 수 있었다. 

---

지금까지 GAN과 대표적인 GAN에 대해서 살펴보았다. 









