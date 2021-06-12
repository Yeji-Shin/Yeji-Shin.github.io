---
layout: post
title: Transformer Model
date: 2021-06-14
category: DeepLearning
use_math: true
---

이번에는 sequence genertion에 사용되는 또 다른 모델인 transformer에 대해 설명한다. Transformer는 sequence generator로 사용된다. 

---
### 1. Limitation of LSTM

지금까지는 LSTM(many to many) + attention model을 sequence generation에 사용했다. 하지만 이 모델은 sequential한 계산만 이용가능하니깐 속도가 느려지는 문제가 있었다. 따라서 LSTM모델 말고 다른 모델을 이용해서 sequence to sequence generation을 할 수 없을까 고민하기 시작했다.

![image](https://user-images.githubusercontent.com/61526722/121780101-cd70de00-cbd9-11eb-892f-b821ce5b5b54.png)

Attention module의 입력은 $h_{i}$로 sequential 하다. 이를 parallel하게 만들기 위해서 어떻게 해야할까. 먼저 context는 앞에 있는 출력들이 뭉쳐진거니깐 accumulated previous output이라고 한다. 

![image](https://user-images.githubusercontent.com/61526722/121780253-7e777880-cbda-11eb-81e5-0ba7fa47eece.png)

그 다음에는 NN들을 하나의 NN으로 본다. 

![image](https://user-images.githubusercontent.com/61526722/121780281-92bb7580-cbda-11eb-94b0-593076647ba7.png)

따라서 generator는 previous output과 x들을 입력으로하여 output을 낸다라고 할 수 있다. 그리고 previous output도 generator module의 입력이므로 위치를 바꿔서 다음과 같이 표현할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121780363-e201a600-cbda-11eb-81c5-74b1b02f08b8.png)

즉, generator는 원래 주어진 입력과 처음부터 지금까지 출력된 출력들을 입력으로 받아서 t번째 단어를 출력하는 것이다. 그러면 NN 부분을 LSTM이 아닌 fully connected layer 로 구현하면 되는 것 아니냐는 것이다. 다시말해서  fully connected network에 $x_{1}, ..., x_{n}$와 지금까지 생성된 $o_{1}, ..., o_{t-1}$을 입력으로 받아서 t번째 출력을 내는 모델을 만들어서 이것을 계속 반복적으로 사용하면 sequence generation이 된다는 것이 transformer의 기본 아이디어이다. 

![image](https://user-images.githubusercontent.com/61526722/121780547-d1056480-cbdb-11eb-877d-80c9c05c5f29.png)
![image](https://user-images.githubusercontent.com/61526722/121780550-d367be80-cbdb-11eb-8a75-01d661c567e6.png)
![image](https://user-images.githubusercontent.com/61526722/121780552-d5ca1880-cbdb-11eb-8b0a-547c197d3383.png)




