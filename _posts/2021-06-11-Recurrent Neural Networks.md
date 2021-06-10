---
layout: post
title: Recurrent Neural Networks 
date: 2021-06-11
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

이를 해결하기 위해 LSTM 모델이 제안되었다. LSTM은 1000 step 전 과거까지도 잘 잡아낸다고 알려져있다. LSTM의 구조는 아래와 같다. 큰 회색 네모 박스는 $h_{t}$를 크게 확대한 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121358543-ac0bba00-c96d-11eb-90b0-bf57111bd700.png)
![image](https://user-images.githubusercontent.com/61526722/121364847-1d01a080-c973-11eb-8220-69a9dae0876b.png)
![image](https://user-images.githubusercontent.com/61526722/121359339-58e63700-c96e-11eb-8008-837cb57acaae.png)

먼저 $h_{t}$로 들어오는 입력부터 살펴보자. LSTM에는 RNN에 없는 $c_{t-1}$ 구조가 한가지 더 있다. $c_{t-1}$와 $h_{t-1}$은 모두 과거로부터 온 정보이다. $c_{t-1}$는 고속도로를 타고 온 정보, $h_{t-1}$은 지방도를 타고 온 정보라고 이해하면 쉽다. $c_{t-1}$는 고속도로를 타고 손실 없이 달려온 느낌이니깐 먼 과거의 정보가 실려 있을 가능성이 크고, $h_{t-1}$은 다양한 정보를 담고 있지만 먼 과거의 정보를 많이 포함하지는 않는다.

![image](https://user-images.githubusercontent.com/61526722/121361249-13c30480-c970-11eb-8cc7-892bb68a78fb.png)

이렇게 두 가지의 과거 정보를 가지고 그 다음으로 일어나는 일은 $h_{t-1}$와 현재의 입력 $x_{t}$를 섞는다. 노란색 선과 빨간색 선은 NN으로 fully connected 되어 있다는 뜻이다. 그 후에 $c_{t-1}$와 vector summaztion을 하여 $c_{t}$를 만든다. 초록색 선은 NN이 아니라 그냥 데이터의 전달이다. $c_{t}$는 그대로 네모칸을 빠져나가서 다음번 입력에 들어가는 $c_{t}$가 된다. $c_{t-1}$에서 $c_{t}$로 가는 경로를 보면 곱셈 연산이 존재하지 않는다. 곱셈이 없기 때문에 나중에 exponential vanishing/exploding 현상이 일어나지 않는다. 이게 바로 고속도로 연산이라고 한 이유이다.  $c_{t}$는 activation function(tanh)를 통과하여 $h_{t}$가 된다. 

![image](https://user-images.githubusercontent.com/61526722/121361362-2dfce280-c970-11eb-8783-9fa03813c49f.png)

여기서 과거정보인 $c_{t-1}$와 현재정보가 혼합된 $g_{t}$는 1:1의 확률로 섞이고 있다. LSTM은 이 확률을 조절할 수 있도록 수도꼭지 $f_{t}$를 만들었다. $f_{t}$는 sigmoid를 활성화 함수로 사용하여 0~1 사이의 값을 출력해주는데 이를 $c_{t-1}$과 벡터 곱셈을 해주어 과거정보를 얼마나 받아들일 것인지 결정한다.

![image](https://user-images.githubusercontent.com/61526722/121361406-38b77780-c970-11eb-96a4-fa4aa831b5df.png)

마찬가지로 현재정보인 $g_{t}$를 얼마나 받아들일 것인지 정해주는 $i_{t}$를 사용한다. 

![image](https://user-images.githubusercontent.com/61526722/121361440-4240df80-c970-11eb-9646-39fbf95ce85e.png)

여기에 $o_{t}$도 추가한다.

다시 앞으로 돌아가서 수식을 살펴보면 이해가 될 것이다. 이 때 수도꼭지 역할을 하는 $i$는 input gate, $f$는 forget gate, $o$는 output gate라고 부른다. 방금 구조를 쭉 연결해서 보면 아래 그림처럼 만들어진다. 

![image](https://user-images.githubusercontent.com/61526722/121365456-a2855080-c973-11eb-8b38-805d5600fd1e.png)

Gradient flow는 곱하기가 없는 path가 존재하여 수월하게 이루어진다.

![image](https://user-images.githubusercontent.com/61526722/121365543-b630b700-c973-11eb-9ea2-6b16a47b3a01.png)

이 때 중간에서 $f_{t}$를 0으로 주면 과거정보는 아예 없어지지 않느냐라는 의문을 가질 수 있다. 하지만 고속도로를 타고 가다가 지방도로로 우회하듯이 빨간색 선을 따라 우회하여 다음 input으로 들어간다. 

![image](https://user-images.githubusercontent.com/61526722/121365764-e5dfbf00-c973-11eb-82ed-df42d1b288f5.png)

그리고 또 하나 기억할 것은 $c_{t-1}$와 $g_{t}$는 굉장히 다양한 조합의 경로로 흘러갈 수 있다는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121366525-8504b680-c974-11eb-97f8-092c177b0033.png)

이는 ResNet과 상당히 유사한 구조를 가지고 있다. LSTM은 ResNet보다 10년 넘게 전에 제안된 구조이다. 다음으로 LSTM을 발전시킨 모델들을 살펴본다.

----

### 3. GRU

GRU는 LSTM보다 조금 더 간단한 구조이다. Gate가 2개만 존재하여 더 빠른시간안에 학습을 진행할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121367237-1b38dc80-c975-11eb-9368-0d01f3b8915c.png)

$h_{t-1}$은 두 가지 방법으로 들어가는데, 한 번은 activation function을 통과하고 한 번은 통과하지 않고 들어가서 더해진다. 이게 ResNet이랑 똑같다고 말할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121367252-1d9b3680-c975-11eb-97bb-5cd18900a25a.png)

여기서도 수도꼭지 $r_{t}$을 추가하여 과거정보 $h_{t-1}$와 현재정보 $x_{t}$를 조절한다.  

![image](https://user-images.githubusercontent.com/61526722/121367260-1ecc6380-c975-11eb-9b72-2c186e9bbd4f.png)

또 $z_{t}$를 사용해 $h_{t-1}$, $h_{t-1}$와 $x_{t}$를 합한 것을 조절한다. 

---

이렇게 이번 시간에는 sequential data를 처리하는 데 특화되어 있는 RNN, LSTM, GRU에 대해 알아보았다. 다음 시간에는 sequential modeling에 대해 학습할 것이다.
