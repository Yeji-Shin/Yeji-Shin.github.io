---
layout: post
title: Recurrent Neural Networks 
date: 2021-06-10
category: DeepLearning
use_math: true
---

이번에는 Recurrent Neural Networks (RNN)의 기본 개념을 알아볼 것이다.

RNN은 <mark>sequential data 처리</mark>에 적합한 모델이다. speech, text, image 가 모두 sequential data이며 나타났는지 안나타났는지가 중요한것이 아니고
데이터가 나타난 위치가 중요한 데이터이다. 즉, 순서가 있는 데이터가 sequential data이다. 이미지 같은 경우는 어떻게 순서가 있는지 의문을 가질수도 있다.
예를 들어 고양이 이미지를 픽셀단위로 잘라 뒤죽박죽으로 해놓으면 우리는 이게 고양이인지 모를 것이다. 

---

### 1. Recurrent Neural Networks (RNN)

RNN은 fully connected NN 밑에 혹 하나가 붙어있는 구조이다. 

![image](https://user-images.githubusercontent.com/61526722/121352459-da869680-c967-11eb-919f-06c2080a6a28.png)

$c_{1},c_{2}...,c_{k}$는 hidden node의 값을 저장하는 메모리 버퍼이다. 굵은 선에 집중하여 RNN의 학습과정을 알아본다.

![image](https://user-images.githubusercontent.com/61526722/121353193-8b8d3100-c968-11eb-98cd-11b2c83e011b.png)

Input이 들어오면 hidden layer로 정보가 전달된다.

![image](https://user-images.githubusercontent.com/61526722/121352878-410bb480-c968-11eb-8104-10231af80b9c.png)

그 다음 hidden node에서 계산된 값은 다음 layer로 전달되는 동시에 메모리 버퍼에도 복사되어 저장된다. 첫 번째 입력이 output node까지 전달되어도 이 버퍼에는 값이 남아있다. 

![image](https://user-images.githubusercontent.com/61526722/121353595-fdfe1100-c968-11eb-8f49-fe93e0a7002f.png)

이제 두 번째 입력이 들어오면 어떻게 될까. 버퍼에 저장되어 있던 값들은 hidden layer의 입력값으로 사용된다. 여기서 주목해야 할 점은 hidden layer에서 나온 값 들은 메모리 버퍼로 1:1 대응되어 들어가지만 다음 데이터가 들어왔을 때 copy node에서 hidden layer로 들어갈 때는 fully connected 되어 있다. 

![image](https://user-images.githubusercontent.com/61526722/121354158-94cacd80-c969-11eb-9f7e-871fa4bc346e.png)

이렇게 두번째 입력과 저장되어 있던 값들을 받아 hidden layer를 통과시키고 나온 값을 다시 copy node에 replace한다. 이 과정이 반복이 되는데 copy node의 초기값은 0값으로 주어 없는 것 처럼 사용하면 된다. 

정리하면 copy node는 hidden layer에서 계산된 값을 저장하는 버퍼이다. 이 버퍼에 있는 값은 다음 데이터가 들어왔을 때 마치 입력처럼 사용이 된다. copy node 입장에서 보면 값이 입력되었다가 사용되고 다시 새로운 값으로 입력되었다가 사용되어 loop를 이루게 된다고 해서 recurrent NN이다.

![image](https://user-images.githubusercontent.com/61526722/121354855-42d67780-c96a-11eb-9221-0251119aecf1.png)
![image](https://user-images.githubusercontent.com/61526722/121355082-7dd8ab00-c96a-11eb-9457-48c1e9faf884.png)

RNN을 간단히 나타내면 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/121355561-f3dd1200-c96a-11eb-885f-cdae4ad50c87.png)

지난 과거를 모두 기억하고 있다가 현재의 정보와 혼합하여 미래를 예측하는 구조라고 할 수 있다. 따라서 RNN은 long term depency를 모델링 할 수 있는 구조라고 말한다.  $o_{n}$ 과 $x_{1}$은 굉장히 거리가 멀지만 영향을 줄 수 있는 path가 존재하고 $x_{2}$도 거리가 멀지만 결과값에 영향을 줄 수 있는 path가 존재하여 long term dependency를 잡아낼 수 있는 구조라고 말한다. 이론적으로는 그렇지만 현실에서는 과거의 정보를 잘 보존하지 못한다. 

activation function과 copy node를 제외하고 간단히 적으면 $o_{n} =  x_{1} * U * W^{n-1}$이 된다. 이 때 만약 $W$가 1보다 작은 값이라면 $o_{n}$으로 전달되는 $x_{1}$의 값은 <mark>exponetially decade</mark>되어 굉장히 작은 값이 된다. 반대로 $W$가 너무 큰 값이라면 <mark>exponentially grow</mark>가 일어나 뒤쪽의 input이 무용지물이 된다. 이를 거꾸로 말하면 역전파할 때 gradient vanishing/exploding이 일어나는 것이다. 이 문제를 LSTM 모델이 해결한다. 

---

### 2. Long Short-Term Memory (LSTM)

RNN은 long term dependency를 잘 반영하는 구조가 아니었다. 

![image](https://user-images.githubusercontent.com/61526722/121359614-a1055980-c96e-11eb-806b-489634d19927.png)

이를 해결하기 위해 LSTM 모델이 제안되었다. LSTM은 1000 step 전 과거까지도 잘 잡아낸다고 알려져있다. LSTM의 구조는 아래와 같다. 

![image](https://user-images.githubusercontent.com/61526722/121358543-ac0bba00-c96d-11eb-90b0-bf57111bd700.png)
![image](https://user-images.githubusercontent.com/61526722/121359339-58e63700-c96e-11eb-8008-837cb57acaae.png)

큰 회색 네모 박스는 $h_{t}$를 크게 확대한 것이다. 

먼저 $h_{t}$로 들어오는 입력부터 살펴보자. LSTM에는 RNN에 없는 $c_{t-1}$ 구조가 한가지 더 있다. $c_{t-1}$와 $h_{t-1}$은 모두 과거로부터 온 정보이다. $c_{t-1}$는 고속도로를 타고 온 정보, $h_{t-1}$은 지방도를 타고 온 정보라고 이해하면 쉽다. $c_{t-1}$는 고속도로를 타고 손실 없이 달려온 느낌이니깐 먼 과거의 정보가 실려 있을 가능성이 크고, $h_{t-1}$은 다양한 정보를 담고 있지만 과거의 정보를 많이 포함하지는 않는다.




