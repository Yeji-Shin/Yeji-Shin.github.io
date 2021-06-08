---
layout: post
title: Convolutional Neural Networks Architectures
date: 2021-06-10
category: DeepLearning
use_math: true
---

이번에는 Convolutional Neural Networks (CNN)의 여러가지 아키텍처를 알아볼 것이다.

![image](https://user-images.githubusercontent.com/61526722/121185059-a3997d80-c8a0-11eb-96de-9bc2da956068.png)

---

### 1. LeNet-5

![image](https://user-images.githubusercontent.com/61526722/121184594-35ed5180-c8a0-11eb-9d94-f9f981587431.png)

LeNet-5는 최초의 CNN으로 간단하게 conv-pooling-conv-pooling 구조를 가지고 있다. 

---

### 2. AlexNet (2012)

AlexNet은 ImageNet에서 최초로 우승한 모델이다. 

![image](https://user-images.githubusercontent.com/61526722/121185177-c461d300-c8a0-11eb-8c4f-c9f73f5755a3.png)

![image](https://user-images.githubusercontent.com/61526722/121185480-14d93080-c8a1-11eb-8c93-91d5f1ec37b6.png)
![image](https://user-images.githubusercontent.com/61526722/121186007-9cbf3a80-c8a1-11eb-87a9-f5a82dc4abb2.png)

![image](https://user-images.githubusercontent.com/61526722/121194710-f4fa3a80-c8a9-11eb-991d-7ac7bca849bf.png)

![image](https://user-images.githubusercontent.com/61526722/121194723-f6c3fe00-c8a9-11eb-9151-6a68a9fa2ce2.png)

![image](https://user-images.githubusercontent.com/61526722/121194738-f9265800-c8a9-11eb-8da2-26c1480d7ebc.png)

![image](https://user-images.githubusercontent.com/61526722/121194742-faf01b80-c8a9-11eb-87c8-48a54610ffac.png)

![image](https://user-images.githubusercontent.com/61526722/121194750-fd527580-c8a9-11eb-938d-cedb33bf52ce.png)

![image](https://user-images.githubusercontent.com/61526722/121194756-ff1c3900-c8a9-11eb-9115-bda67dc6b20f.png)

![image](https://user-images.githubusercontent.com/61526722/121194761-004d6600-c8aa-11eb-9a0a-611c2a119b55.png)

![image](https://user-images.githubusercontent.com/61526722/121194797-093e3780-c8aa-11eb-9a5c-00d239a11994.png)

![image](https://user-images.githubusercontent.com/61526722/121194764-02172980-c8aa-11eb-9b59-676fe4640d82.png)


- ReLU를 처음 사용한 모델
- 이제는 쓰지 않는 normalization layer를 사용
- 서로 다른 7개의 CNN을 만들어서 그것들을 majority voting해서 error 줄임

이후에는 AlexNet의 파라미터만 조정한 모델인 ZFNet이 등장한다.

---

### 3. ZFNet (2013)

AlexNet에서 filter size와 개수, stride 를 바꿨더니 성능이 5% 정도 향상됐다.  

![image](https://user-images.githubusercontent.com/61526722/121187350-efe5bd00-c8a2-11eb-94a6-103c6ae999ae.png)


---

### 4. VGG (2014)

ReLU를 사용하면 gradient vanishing 문제를 해결할 수 있다고 했다. 하지만 네트워크 구조가 깊어지면 곱하기 term이 늘어나게 되고, 곱하기 term이 늘어나게 되면 gradient vanishing 문제가 다시 생길 수 있다. 이 구조가 20layer 까지 쌓긴 했지만 vanishing gradient를 완전히 해결할 수 있는 구조는 아니었다.

![image](https://user-images.githubusercontent.com/61526722/121191014-8bc4f800-c8a6-11eb-92c0-f10c01743db9.png)

AlexNet은 그림에서 pooling layer을 제외하고 16개의 layer로 이루어져 있다. 사실 AlexNet과 VGG16은 큰 차이가 없다. AlexNet에서는 11x11, 5x5, 3x3 다양한 layer를 사용했지만 VGG에서는 <mark>3x3 layer만 사용</mark>했다. 왜 3x3만을 사용했을까.

![image](https://user-images.githubusercontent.com/61526722/121189686-494eeb80-c8a5-11eb-97d2-483ca039b633.png)
![image](https://user-images.githubusercontent.com/61526722/121189109-bc0b9700-c8a4-11eb-9ce3-51ba15af604a.png)

5x5를 한번 하는 것과 3x3을 두번하는 것은 유사한 결과를 얻는다. 하지만 파라미터 측면에서 본다면 3x3을 두번하는 것이 훨씬 유리하다. 또한, conv를 실행할 때마다 non-linear transform을 해주는 ReLU가 들어가기 때문에 non-linearity도 증가하게 된다. 이런식으로 7x7 하나를 사용하는 것과 3x3을 세번 사용하는 것과 비슷한 결과를 얻는다. 즉, 3x3 filter를 여러개 연속으로 사용하여 <mark>파라미터의 개수도 줄이고 non-linearity도 증가</mark>시킨다.

![image](https://user-images.githubusercontent.com/61526722/121189928-861ae280-c8a5-11eb-86ea-e5e68cb0835e.png)

하지만 FC layer에서 어마어마한 파라미터를 사용하여 무거운 모델이 된다. 그래서 나중에는 FC layer를 한개만 사용한다.  

---

### 5. GoogleNet (2014)

GoogleNet에서는 inception module을 사용하는데 inception module은 extended convolution model이라고 생각하면 된다.

![image](https://user-images.githubusercontent.com/61526722/121191226-be6ef080-c8a6-11eb-95aa-9e7ad20ee8fa.png)

![image](https://user-images.githubusercontent.com/61526722/121191570-0db52100-c8a7-11eb-83ad-8f575341535e.png)

하나의 conv layer에서 다양한 filter size를 쓸 수 없을까. 다음 그림처럼 32x32를 input으로 넣고 3x3과 5x5를 적용해보자. 3x3를 거치면 30x30의 이미지가 나올것이고, 5x5를 거치면 28x28 사이즈의 이미지가 나올 것이다. 그럼 zero-padding을 적절하게 해서 결과값 이미지의 사이즈를 같게 한 후 concat하면 된다. 그러면 우리가 filter size를 고민할 필요가 없게 된다. 짬짜면을 먹자는 얘기다. 

![image](https://user-images.githubusercontent.com/61526722/121192311-c9765080-c8a7-11eb-990b-1598fc2638d1.png)
![image](https://user-images.githubusercontent.com/61526722/121192320-cb401400-c8a7-11eb-874e-840438a4c4dc.png)

그럼 이제 inception modul에는 1x1 filter를 살펴보자. convolution은 local feature들을 찾아내는 것이었는데 1x1 filter가 뭘까. 1x1은 local feature extraction으로 사용하는 것이 아니라 <mark>주어진 이미지를 1개의 channel로 요약</mark>하는 역할을 한다. RGB 채널의 이미지를 흑백 이미지로 바꾸는 것을 예로 들수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121193190-984a5000-c8a8-11eb-9d7e-a3978c1a9481.png)

1x1 filter를 하나 써보자. 1x1 filter는 요약의 기준이라고 할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121193457-d5aedd80-c8a8-11eb-9446-5bc141f10942.png)

이번에는 1x1을 32개 써보자. 이것은 요약의 관점을 32개로 해보라는 뜻이 된다. 

![image](https://user-images.githubusercontent.com/61526722/121193477-d8a9ce00-c8a8-11eb-9ac8-9acf106304f3.png)

이렇게 다양한 방법으로 요약을 하면 큰 손실 없이 채널 수가 줄어드는 효과를 얻을 수 있다. 정리해서 <mark>1x1 conv는 정보의 손실을 최소화시키면서 채널 수를 줄이는 연산</mark>이다. 그러면 채널 수는 왜 변화시킬까.

![image](https://user-images.githubusercontent.com/61526722/121208792-4b20ab00-c8b5-11eb-8da8-33e021ed9ed7.png)

채널 수를 먼저 줄어놓고 3x3을 적용하면 학습 파라미터를 절약할 수 있다. 학습 파라미터를 줄이면 연산량도 줄일 수 있음을 아래 그림에서 볼 수 있다.

![image](https://user-images.githubusercontent.com/61526722/121210193-6e982580-c8b6-11eb-9826-bbcc742ed9ca.png)
![image](https://user-images.githubusercontent.com/61526722/121210245-7b1c7e00-c8b6-11eb-891e-38833550a1b4.png)

다음으로 3x3 max pooling (stride=1)은 뭘까. input과 output의 크기는 같지만 feature map에 존재하는 강한 시그널의 영역을 확장시키는 역할을 한다. pooling은 채널수를 그대로 유지하니깐 1x1을 사용해 채널수를 조정한다. 

![image](https://user-images.githubusercontent.com/61526722/121209567-e44fc180-c8b5-11eb-96b0-d8ef81c4fcb1.png)

최종적으로 inception module이 완성되었다. 그리고 GoogleNet에서는 FC layer가 softmax 하나만 존재하여 학습 파라미터를 더 줄인다. 

![image](https://user-images.githubusercontent.com/61526722/121210759-e5352300-c8b6-11eb-8c54-3a48f8a8a6dd.png)

한 가지 더 주목해야 할 점은 중간 중간 classifier를 넣었다는 것이다. Total error는 중간 classifier의 error를 다 더해주며 중간 것들을 학습때만 사용된다. 이는 <mark>gradient vanishing을 해결</mark>하기 위해 사용했다. 하지만 요즘에는 이런 방법을 잘 사용하지 않는데 ResNet을 사용하기 때문이다. 

---

### 6. ResNet (2015)

사람들은 단순히 ReLU를 추가함으로써 더 깊은 네트워크를 쌓을 수 없다는 것을 알게 되었다. 즉, gradient vanishing 문제를 ReLU로 극복하는 것의 한계가 왔다는 것이다. 이론적으로 layer를 더 많이 쌓을수록 파워가 더 세지지만 현실은 그렇지 않았다. 그러면 이 ResNet은 ReLU의 한계를 어떻게 극복하여 152개의 layer를 쌓을 수 있었을까. 


해답은 skip connection에 있다. 아래의 두가지 모델은 같은 역할을 하는 서로 다른 구조를 가진다. 오른쪽은 skip connection이라고 하는 부분이 추가된 것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121213793-86bd7400-c8b9-11eb-8640-1a9a395021e0.png)

![image](https://user-images.githubusercontent.com/61526722/121212771-9d170000-c8b8-11eb-95ab-f8c5370f1ccd.png)

역전파를 할때 skip connection을 타고 gradient를 역전파하면 곱하기가 없어진다. 다시말하면 X 에서 Y로 가는 경로가 굉장히 많은데 그 중 상당히 많은 개수의 경로가 곱하기 개수가 적다. 마찬가지로 역전파 할 때 다양한 경로로 gradient가 흘러가기 때문에 grdient가 전달이 잘 된다. 따라서 깊은 깊은 layer도 학습이 잘 되는 구조이다. 다양한 경로는 앙상블 모델로 생각할 수도 있다. 

처음에는 아래와 같이 두 layer를 건너뛰는 skip connection을 추가한 구조가 제안된다. 하지만 skip connection은 어디에 있어도 상관없다. 

![image](https://user-images.githubusercontent.com/61526722/121214298-eddb2880-c8b9-11eb-8778-56df1c506be5.png)

따라서 전체적인 구조는 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/121214585-3561b480-c8ba-11eb-8984-121876250be9.png)

---

### 7. DenseNet (2017)

DenseNet은 ResNet을 조금 변경시킨 것으로 skip connection을 여러번 쓰는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121215401-ec5e3000-c8ba-11eb-82a2-6796518843d9.png)

---

### 8. Depthwise Separable Convolution

지금까지 CNN의 여러가지 구조들을 살펴보았는데 다음으로 변형된 convolution 연산 중 하나인 Depthwise Separable Convolution을 살펴본다. 

![image](https://user-images.githubusercontent.com/61526722/121215809-4b23a980-c8bb-11eb-8698-6ba5328e6ab2.png)

Depthwise Separable Convolution은 input을 먼저 channel 별로 분리하고 분리된 채널별로 convolution  연산을 수행한다. 연산의 결과를 다시 채널별로 합친 후에 1x1 convolution으로 1 channel로 바꿔준다. 다시말해서 원래의 conv 연산에서는 채널별 local feature들을 한꺼번에 찾았다면 Depthwise Separable Convolution 채널별 local feature를 찾고 찾아진 채널별 local feature를 통합하는 2단계 구조이다.  

![image](https://user-images.githubusercontent.com/61526722/121216964-588d6380-c8bc-11eb-874d-ef1eac82b159.png)
![image](https://user-images.githubusercontent.com/61526722/121216790-30056980-c8bc-11eb-8d90-a059bdf9a2a0.png)

이렇게 regular conv를 사용하면 3개 채널의 output을 만들고 싶을 때 27x3개의 파라미터가 필요하다. 하지만 Depthwise Separable Convolution에서는 36개의 파라미터만 필요하다. 따라서 전체적으로 학습 파라미터의 개수를 줄일 수 있다. 성능은 보장할 수 없음...


![image](https://user-images.githubusercontent.com/61526722/121217495-dcdfe680-c8bc-11eb-9988-e2594f86ce01.png)

depthwise와 pointwise conv의 순서를 바꾼 연구도 진행됐다. 그냥 보고 넘어가자.

---
