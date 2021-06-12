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

---

### 2. Transformer

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

이렇게 LSTM을 안쓰고 sequence generator를 만들 수 있고, LSTM을 안 쓴다는 것은 NN을 구동시킬 때 gpu의 parallelization 최대한 이용해서 만들자는 아이디어가 transformer인 것이다. 

이제 generator 부분을 쪼개서 보자. 

![image](https://user-images.githubusercontent.com/61526722/121780644-407b5400-cbdc-11eb-84d4-22f55a8b085c.png)

 $x_{1}, ..., x_{n}$만 받은 것을 encoding하고 previous output만 모아서 encoding하고 실제로 generation하는 구조로 볼 수 있다. 이를 표현하면 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/121780734-a9fb6280-cbdc-11eb-8cf4-b8dda19b048f.png)

Inputs는 $x_{1}, ..., x_{n}$가 되고 그 위는 encoder, outputs는 $o_{1}, ..., o_{t-1}$이 되고 그 위는 encoder가 된다. Softmax와 linear는 바로 단어를 생성하는 generator에 해당된다. 이 부분들을 하나씩 쪼개서 살펴보자.

---

### 3. Encoder

Encoder는 attention, residual link, layer normalization, feed forward, residual link, normalization으로 구성된다. 

![image](https://user-images.githubusercontent.com/61526722/121780895-5b01fd00-cbdd-11eb-9bae-b97bffcf21f6.png)

먼저 input은 word embedding을 통해 벡터화가 된다. 이 벡터들이 self-attention에 들어가면 변형된 벡터가 나온다. 그것들이 다시 feed forward로 들어가서 다시 변형된다. 궁긍적으로 encoder가 하는 일은 벡터를 받아서 다른 형태의 벡터로 내보낸다. 이 encoder가 xN이라고 되어 있는데 이 말은 encdoer가 여러번 쌓을 수 있다는 것이다. 이렇게 전의 output을 transform하는 것이 반복하기 때문에 transformer라는 이름이 붙은 것이다. 

#### Attention mechanism

![image](https://user-images.githubusercontent.com/61526722/121781092-30fd0a80-cbde-11eb-9daa-7e7e11acb7ad.png)

$x_{i}$는 s값을 구하기 위해서, z값을 구하기 위해서 총 두 번 사용된다. 이 때 s값을 구하기 위해서 사용될 때의 $x_{i}$값을 <mark>key</mark>라고 부르고, z값을 구하기 위해서 사용될 때의 $x_{i}$값을 <mark>value</mark>라고 부를 것이다. 

Attention module의 입력은 크게 세 가지이다. <mark>context(query), key, value</mark>. 그리고 우리는 보통 key, value 자리에 같은 값을 집어 넣는다. $z=Att(q,k,v)$ 이는 수식으로 표현될 수 있는 함수이다. 

$(m_{1}, m_{2}, ..., m_{n}) = (q * x_{1}^{T}, q * x_{2}^{T}, ..., q * x_{n}^{T}) = q * (x_{1}^{T}, x_{2}^{T}, ..., x_{n}^{T}) = q * (x_{1}, x_{2}, ..., x_{n})^{T} = q * X^{T} $

$ (s_{1}, s_{2}, ..., s_{n}) = softmax(m_{1}, m_{2}, ..., m_{n}) = softmax(q * X^{T})$

$ z = s_{1}x_{1} + s_{2}x_{2} + ... +  s_{n}x_{n} = (s_{1}, s_{2}, ..., s_{n}) * X  = softmax(q * X^{T}) * X = softmax(q * K^{T}) * V $

쿼리를 여러개 날리면 결국 수식은 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/121781597-74f10f00-cbe0-11eb-87ca-c33f17738213.png)

![image](https://user-images.githubusercontent.com/61526722/121781726-1710f700-cbe1-11eb-94b5-f54a6d256d45.png)

여기서 $\sqrt{|k|}$로 한번 나누어 주는데 k는 embedding dimension이다. Embedding dimension은 우리가 결정하는 것이다. 나누어주는 이유는 벡터의 내적값은 차원에 비례해서 늘어나기 때문에 softmax에 넣으면 attention 값이 받는 변동이 크기 때문에 이를 완화시키기 위함이다.

#### Self Attention 

![image](https://user-images.githubusercontent.com/61526722/121781907-eed5c800-cbe1-11eb-9fae-85efdb138c06.png)
![image](https://user-images.githubusercontent.com/61526722/121782059-baaed700-cbe2-11eb-989a-d460faea3c08.png)

self attention의 의미가 무엇일까. 위 그림에서 $x_{i}$가 $x_{1}$에 유사한 만큼 $x_{1}$을 더하고, $x_{2}$가 $x_{2}$에 유사한 만큼 $x_{2}$을 더하고 하다보면 결국 z는 $x_{i}$와 비슷해질 것이다. $x_{i}^{'}$은 $x_{i}$의 다른 설명이라고 할 수 있다. 결국 self attention은 <mark>$x_{i}$를 X(입력들)의 관점에서 다시 설명한 것</mark>이다. 

![image](https://user-images.githubusercontent.com/61526722/121782094-e7fb8500-cbe2-11eb-9614-9419cbefffd3.png)

그럼 왜 $x_{i}$를 $x_{i}^{'}$로 re-description을 할까. $x_{i}^{'}$은 $x_{1}, x_{2}, ..., x_{n}$을 가지고 다시 설명한 것이다. 표준화시킨 느낌이다. 이렇게 하면 $x_{i}^{'}$끼리의 비교 및 가공이 용이해진다. 

![image](https://user-images.githubusercontent.com/61526722/121782239-8b4c9a00-cbe3-11eb-9e68-c73d87875696.png)

즉, 자기자신과 다른 것들의 유사도를 구함으로써 long term dependency를 구하는 과정이라고 할 수 있다. 다시 앞으로 돌아가서 생각해보면 thinking, machine, learning을 섞은 관점에서 thinking을 재해석하고, thinking, machine, learning을 섞은 관점에서 machine을 재해석한다. 

![image](https://user-images.githubusercontent.com/61526722/121782352-0ca42c80-cbe4-11eb-85f3-c4c5cefc0b8c.png)

여기서 삼지창 모양으로 되어 있는 것은 같은 X가 들어간다고 해서 self attention이라는 의미이다.

#### Multi-headed Attention

행렬 연산을 하면 벡터의 차원 변환이 쉽게 된다. 우리가 위에서 사용했던 Att(Q,K,V)를 그냥 사용하지 않고 사전에 정의된 행렬을 이용해서 각각을 일차변환한다. 이 과정을 headed라고 하고 Q, K, V를 변환하는 행렬을 head라고 부른다. Multi-headed라는 말은 이 변환이 여러개가 있다는 말이다.

![image](https://user-images.githubusercontent.com/61526722/121782537-cf8c6a00-cbe4-11eb-96e0-cfabc3f60437.png)
![image](https://user-images.githubusercontent.com/61526722/121782538-d0bd9700-cbe4-11eb-8b31-3b350c5fa1d2.png)

이 변환의 이미는 뭘까. 우리가 attention을 할 때 모든 데이터를 다 사용해서 attention을 하지 않고 일부만 이용해보고 싶을 것이다. 이 과정을 head가 해준다. 즉, <mark>attention의 관점을 제시</mark>하는 것이다.

![image](https://user-images.githubusercontent.com/61526722/121782628-75d86f80-cbe5-11eb-8dae-502359359099.png)

위 그림처럼 head를 다르게 하면 attention의 값이 다르게 나온다.  

![image](https://user-images.githubusercontent.com/61526722/121782649-9bfe0f80-cbe5-11eb-8b46-aa3fc74e0145.png)

첫 번째 관점에 대한 attention, 두 번째 관점에 대한 attention, ..., n 번재 관점에 대한 attention을 옆으로 쭉 가져다가 붙여서 1차변환 행렬을 곱하여 하나의 행렬로 만들어낸다. 

![image](https://user-images.githubusercontent.com/61526722/121782733-031bc400-cbe6-11eb-8985-eb889e77b655.png)

이렇게 만든 attention의 결과는 multi-head를 안썼을 때의 결과와 포맷이 동일하다. 이 말은 호환가능하다는 말로, 원래 attention을 쓰던 자리에 multi-head attention을 집어넣어도 동작하게 된다. Multi-head는 다양한 관점에서 Q, K, V를 봤기 때문에 더 좋은 결과를 낼 가능성이 크다. 

그리고 여기서의 head들과 일차변환 행렬 k는 모두 학습 파라미터로 gradient descent method를 사용하여 가장 적절한 관점을 찾아주고 통합하는 행렬 k도 가장 적절한 행렬을 찾게된다. 

---

### 3. Feed Forward 

Multi-head attention 방법으로 훨씬더 좋은 attention 정보를 뽑아내고 feed forward를 통해서 non-linear transform을 시행한다. 

![image](https://user-images.githubusercontent.com/61526722/121782849-935a0900-cbe6-11eb-92b4-0a5dcb228281.png)
![image](https://user-images.githubusercontent.com/61526722/121782894-c43a3e00-cbe6-11eb-82a2-4064b3c88c2b.png)

---

### 4. Positional Encoding








