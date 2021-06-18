---
layout: post
title: Recurrent Neural Networks (3) - Attention Model
date: 2021-06-13
category: DeepLearning
use_math: true
---

이번 시간에는 attention model에 대해 살펴볼 것이다. 

---


### 1. Limiatation of Sequence Generation Model

아래 구조는 sequence generation에 많이 사용되는 구조이다. 

![image](https://user-images.githubusercontent.com/61526722/121545119-3246ff80-ca45-11eb-8ce0-818261811ee9.png)

RNN과 CNN은 encoder로 사용될 수 있고, decoder로는 주로 RNN이 사용된다. 

![image](https://user-images.githubusercontent.com/61526722/121545401-74704100-ca45-11eb-8cd9-b4dd037a9978.png)

하지만 이 구조에는 조금 문제가 있다. 앞에 있는 긴 시퀀스가 하나의 벡터로 압축되고, 그 벡터가 다시 풀리는 구조로 전체적으로 bottleneck이 있는 구조이다. 이 bottleneck 구조가 장점이자 단점이 된다. Encoder에서 나온 단 하나의 벡터가 decoder로 하여금 정확한 정답을 맞추는데 충분한 정보를 가지고 있지 않다는 것이다. 즉, <mark>many to many 모델은 sequence가 길어지면 생성을 잘 하지 못한다.</mark>

이를 해결하기 위해 등장한 것이 attention mechaniam이다. 예를 들어 문장을 번역할 때 그때 그때 다음에는 주어가 나와야되는데 주어에 해당되는 것에 더 집중해서 번역하고, 그 다음에는 동사가 나와야되는데 동사에 집중해서 번역하는 아이디어를 many to many에 집어넣어 준 것이다. 즉, <mark>relavant한 context</mark>를 추가적으로 넣어주자는 말이다. encoder에서 나온 벡터에 추가 정보를 주어 더 seq2seq을 수월하게 해준다.

![image](https://user-images.githubusercontent.com/61526722/121548146-be5a2680-ca47-11eb-9d33-b05d17b41054.png)

---

### 2. Attention Model

Attention module을 자세히 살펴보면 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/121548369-ea75a780-ca47-11eb-9ea1-03a6a5c9748c.png)

#### Step1: Evaluating Matching Degree

먼저 NN을 보면 NN의 출력은 스칼라이다. 이 $m$이라는 값들은 0~1 사이의 값을 가지는데 activation을 sigmoid를 사용했다. NN의 입력은 context와 input을 가지고 스칼라 값을 출력한다. NN이 하는 일은 <mark>현재의 context 하에서 $x_{i}$에 얼만큼 집중하면 될까, 얼마나 유용한 입력일까를 평가</mark>한다. NN은 다 똑같이 반복사용 된다. 

![image](https://user-images.githubusercontent.com/61526722/121548916-5d7f1e00-ca48-11eb-91fc-e98caddb07ec.png)


#### Step2: Normalizing Matching Degree

NN에서 나온 유용도를 softmax로 바꿔준다. softmax로 바꿔준다는 얘기는 모든 $m_{i}$ 값들의 합을 1로 만들어준다는 말이다. 즉, softmax 함수로 normalization을 실행한다. 

![image](https://user-images.githubusercontent.com/61526722/121548925-607a0e80-ca48-11eb-9ccd-79e7c985d0cc.png)


#### Step3: Aggregating Inputs

Normalizatin을 통해서 나온 $s_{i}$ 스칼라 값을 각 input 값인 $x_{i}$에 곱해준다. 그 후 vector summation을 한 것이 $z$이다. 

![image](https://user-images.githubusercontent.com/61526722/121550147-71774f80-ca49-11eb-9777-7f26afdd41ba.png)

이것이 바로 attention model의 기본 아이디어이다. 

![image](https://user-images.githubusercontent.com/61526722/121550445-b4392780-ca49-11eb-8ee4-98c4ac616736.png)

여기서 NN은 training data의 타겟 값을 몰라도 자동으로 학습되는 end-to-end 구조를 가진다. 

#### Dot product attention mechanism

이번에는 NN을 inner product(내적값)으로 바꾼다. 내적값은 두 벡터가 같을때 최대가 되고 수직이 되면 0이 된다. 즉, 내적값은 두 벡터의 similarity 에 비례한다고 할 수 있다. 따라서 유용도를 유사도로 바꾼것이다. 

![image](https://user-images.githubusercontent.com/61526722/121551605-c10a4b00-ca4a-11eb-93b9-ffc54f05f2c9.png)

이것의 장점은 NN이 아니기 때문에 학습할 필요가 없다는 것이다. 이 때문에 요즘에는 dot product attention mechanism을 더 많이 사용한다.

---

### 3. Bidirectional LSTM

지금까지 그림에서는 $x_{i}$를 attention module에 직접 넣는 것 처럼 되어있는데 실제로는 이렇게 하지 않고 $x_{i}$를 LSTM에 집어넣은 후에 attention module의 입력으로 준다. 이렇게 하면 여러가지 장점을 가진다. $x_{i}$는 단어 하나이지만 $h_{i}$는 앞의 context 정보를 포함하게 된다

![image](https://user-images.githubusercontent.com/61526722/121553729-7ee20900-ca4c-11eb-9f9e-e5c389f227b6.png)

재밌는 것은 이러한 LSTM을 역방향으로 똑같이 적용해준다. 순방향 LSTM에서 나온 값을 $\overrightarrow{h_{i}}$라고 하고 역방향 LSTM에서 나온 값을 $\overleftarrow{h_{i}}$라고 한다. 이 두개의 벡터를 concatenate 하여 attention module의 입력으로 사용한다. 이것을 Bidirectional LSTM이라고 한다. 

![image](https://user-images.githubusercontent.com/61526722/121553953-b6e94c00-ca4c-11eb-9431-36cfe361eedb.png)

이렇게 하면 더 많은 정보를 decoder에게 전달 할 수 있다. 간단히 다시 그리면 아래와 같다.

![image](https://user-images.githubusercontent.com/61526722/121554863-7938f300-ca4d-11eb-92a2-552fd4f6e486.png)

---

### 4. Attention Model Examples

![image](https://user-images.githubusercontent.com/61526722/121555184-bf8e5200-ca4d-11eb-8174-55757aea45ff.png)

이미지 캡셔닝에 attention module을 적용한 예제를 보자. CNN에서 나오는 마지막 feature map을 1차원 벡터로 변화하여 사용하는 것 보다 영역으로 나누어 attention model을 적용하는 것이 더 성능히 좋다. 

![image](https://user-images.githubusercontent.com/61526722/121555321-de8ce400-ca4d-11eb-8cd8-d1fc07d0535e.png)

![image](https://user-images.githubusercontent.com/61526722/121555670-290e6080-ca4e-11eb-8890-1550ea6c8972.png)

흰색 부분이 attention이 된 부분이다.

---

결과적으로 attention module을 사용하면 상대적으로 더 긴 시퀀스도 잘 생성할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121556040-7db1db80-ca4e-11eb-8584-3788001c291a.png)

