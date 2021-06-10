---
layout: post
title: Sequential Modeling
date: 2021-06-12
category: DeepLearning
use_math: true
---

저번 문서에서는 sequential data를 처리하는데 최적화 되어 있는 RNN, LSTM, GRU 모델을 살펴보았다. 이번에는 다양한 sequential modeling 방법을 알아볼 것이다.

---

### 1. Sequential Modeling

인간이 만들어 내는 대부분의 데이터는 sequential data이며 sequential data를 이용해 정보처리를 하면 다음과 같은 세가지 모델이 기본이 될 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121516703-7e844680-ca29-11eb-9954-927d32f502a7.png)

next step prediction은 주식 값 예측, classfication은 텍스트 데이터로 긍정적인 감정인지 부정적인 감정인지 레이블을 다는 것, sequence를 받아서 sequence를 만들어내는 sequence generation이 있다. 이 중 요즘에 가장 많이 사용되는 것은 sequence generation이다. Sequence generation에는 기계번역, 음성 인식, 이미지 캡셔닝 등이 있다. 

![image](https://user-images.githubusercontent.com/61526722/121517230-141fd600-ca2a-11eb-813d-3e165fa0c951.png)

바로 앞 문서에서 synched many to many 구조를 기반으로 RNN을 설명했지만 다양한 형태가 존재한다. 하지만 문제는 지금까지 설명한 RNN, LSTM, GRU 모델은 다 synched many to many 구조로만 동작할 수 있다는 것이다. 따라서 다른 구조들을 다 synched many to many 구조로 변형해서 처리해야 한다. 

![image](https://user-images.githubusercontent.com/61526722/121529481-67e4ec00-ca37-11eb-980f-a6dba6e19623.png)

따라서 이제부터 one to many, many to one, many to many 구조를 어떻게 LSTM, GRU로 처리 할 것인지 공부하겠다.

---

### 2. Synced Many to Many

Synced Many to Many는 training data가 n개 있는 것이라고 보면 된다. 입력, 출력, 입력, 출력 순서로 학습이 이루진다.

![image](https://user-images.githubusercontent.com/61526722/121530114-0bce9780-ca38-11eb-9d10-f6ecc45533b4.png)

학습방법은 원래 나와야 하는 값인 $y_{i}$과 모델에서 나온 예측된 값인 $o_{i}$ 과의 차이를 계산해서 summation 한것을 total error 라고 정의하여 학습한다. 여기서는 MSE loss를 사용했지만 cross entropy loss를 사용해도 된다. 

![image](https://user-images.githubusercontent.com/61526722/121530532-7bdd1d80-ca38-11eb-965d-9412b2904719.png)

학습을 진행할 때는 미분을 해야 하는데 Synced Many to Many는 hidden layer가 여러개 있는 MLP라고 할 수 있다. 물론 중간에서 입력이 계속 들어가고 중간에서 출력이 계속 나오지면 별 다를 것이 없다. MLP를 학습할 때는 layer 별로 학습을 했는데 마찬가지로 아래 그림처럼 $W$는 $h$를 거치는 함수라고 생각하여 역전파를 하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/121531514-6e746300-ca39-11eb-899e-81236aeec762.png)

하지만 여기서 $\frac{\partial h_{i}}{\partial w}$는 바로 연결되는 함수지만  $\frac{\partial E}{\partial h_{i}}$는 바로 연결되지 않기 때문에 구하기가 어렵다. $h_{3}$ 기준으로 생각을 해보자. 


