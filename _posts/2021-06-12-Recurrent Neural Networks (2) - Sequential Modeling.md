---
layout: post
title: Recurrent Neural Networks (2) - Sequential Modeling
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

![image](https://user-images.githubusercontent.com/61526722/121544207-82719200-ca44-11eb-9be8-fac7ea9b88b9.png)

바로 앞 문서에서 synched many to many 구조를 기반으로 RNN을 설명했지만 다양한 형태가 존재한다. 하지만 문제는 지금까지 설명한 RNN, LSTM, GRU 모델은 다 synched many to many 구조로만 동작할 수 있다는 것이다. 따라서 다른 구조들을 다 synched many to many 구조로 변형해서 처리해야 한다. 

![image](https://user-images.githubusercontent.com/61526722/121529481-67e4ec00-ca37-11eb-980f-a6dba6e19623.png)

따라서 이제부터 one to many, many to one, many to many 구조를 어떻게 LSTM, GRU로 처리 할 것인지 공부하겠다.

---

### 2. Synced Many to Many

Synced Many to Many는 training data가 n개 있는 것이라고 보면 된다. 입력, 출력, 입력, 출력 순서로 학습이 이루진다.

![image](https://user-images.githubusercontent.com/61526722/121530114-0bce9780-ca38-11eb-9d10-f6ecc45533b4.png)

학습방법은 원래 나와야 하는 값인 $y_{i}$과 모델에서 나온 예측된 값인 $o_{i}$ 과의 차이를 계산해서 summation 한것을 total error 라고 정의하여 학습한다. 여기서는 MSE loss를 사용했지만 cross entropy loss를 사용해도 된다. 

![image](https://user-images.githubusercontent.com/61526722/121530532-7bdd1d80-ca38-11eb-965d-9412b2904719.png)

학습을 진행할 때는 미분을 해야 하는데 Synced Many to Many는 hidden layer가 여러개 있는 MLP라고 할 수 있다. 물론 중간에서 입력이 계속 들어가고 중간에서 출력이 계속 나오지면 별로 다를 것이 없다. MLP를 학습할 때는 layer 단위로 학습을 했는데 마찬가지로 아래 그림처럼 $W$는 $h$를 거치는 함수라고 생각하여 역전파를 하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/121531514-6e746300-ca39-11eb-899e-81236aeec762.png)

하지만 여기서 $\frac{\partial h_{i}}{\partial w}$는 바로 연결되는 함수지만  $\frac{\partial E}{\partial h_{i}}$는 바로 연결되지 않기 때문에 구하기가 어렵다. $h_{3}$ 기준으로 생각을 해보자. 

![image](https://user-images.githubusercontent.com/61526722/121532745-9a441880-ca3a-11eb-8bde-3aa50ee64ed4.png)

$h_{3}$가 $E$까지 가는 경로는 $o_{3}$를 거치는 길과 $h_{4}$거치는 길 두가지가 있다. Recursive하게 $h_{4}$는 $o_{4}$를 거치는 길과 $h_{5}$거치는 길 두 가지가 있다. 이렇게 recursive한 형식으로 미분할 수 있다. 

---

### 3. One to Many

One to many는 입력이 1개 출력이 여러개인 구조이다. 

![image](https://user-images.githubusercontent.com/61526722/121532894-bba50480-ca3a-11eb-8383-35ae16b76bda.png)

그럼 어떻게 이것을  Synced Many to Many 구조로 변경할 수 있을까. 입력이 없다는 뜻을 가진 입력을 넣으면 될 것이다. 하지만 이렇게는 잘 안하고 
다음처럼 $y_{i}$라는 가상의 입력을 넣어준다. 

![image](https://user-images.githubusercontent.com/61526722/121533469-44bc3b80-ca3b-11eb-959e-3f0a91e03996.png)

왜 $y_{i}$를 넣어줄까. 

![image](https://user-images.githubusercontent.com/61526722/121533844-a11f5b00-ca3b-11eb-9f3b-661c4138c35c.png)

우리가 그림 하나를 주고 첫 번째 단어를 맞추라고 하면 NN은 이를 못맞출 것이다. 따라서 우리는 다음 입력으로 첫 번째 단어를 힌트를 주면서 두 번째 단어를 맞추라고 한다. NN은 또 못 맞출 것이다. 그러면 다시 다음 입력으로 두 번째 단어를 힌트를 주면서 세 번째 단어를 맞추라고 한다. 즉, training 할 때는 우리가 정답을 알고 있으니깐 정답을 하나씩 친절하게 알려주어 <mark>$x y_{1} y_{2} y_{3}...y_{n-1}\rightarrow y_{1} y_{2} y_{3}...y_{n}$</mark> 처럼 many to many 구조가 되는 것이다. 

학습은 many to many 구조와 같은 방식으로 이루어진다. 

![image](https://user-images.githubusercontent.com/61526722/121534652-623dd500-ca3c-11eb-89e2-1c7b0f8476d9.png)

그럼 이제 문제는 테스트할 때인데 training 할 때는 정답을 알고 있기 때문에 NN에게 가상의 입력으로 정답을 주었다. 하지만 test 할 때는 우리가 실제 y값을 모른다. Test시에는 첫 번째 정답을 맞출 것이다 그렇게 학습을 시켰으니깐. 그러면 간단하게 정답 대신에 출력값 $o_{1}$을 그 다음 단계의 입력으로 주면 된다. 왜냐면 $o_{1}$은 $y_{1}$과 아주 유사한 값을 가질 것이기 때문이다.  

![image](https://user-images.githubusercontent.com/61526722/121535025-bba60400-ca3c-11eb-88e8-35e936408e9b.png)

하지만 점점 뒤로 갈수로 정답률이 떨어지는 문제가 있다. 예를 들어 첫번째 출력은 정답과 99% 일치한다라고 하고 이것이 두번째 입력으로 들어가면 그 때 나온 출력값이 정답일 확률은 98%가 될것이고, 같은 방식으로 그 다음 출력값이 정답일 확률은 97%가 되고 그 다음은 더 떨어지게 된다. 이게 caption generation이 긴 문장을 만들 때는 어려운 이유이다. 

![image](https://user-images.githubusercontent.com/61526722/121539706-daa69500-ca40-11eb-91e7-994df33426d9.png)

One to many의 예시이다.

---

### 4. Many to One

Many to One은 입력은 여러개인데 출력이 하나인 경우이다. 

![image](https://user-images.githubusercontent.com/61526722/121536035-aa112c00-ca3d-11eb-906d-451a13a8f6b6.png)

이 구조는 중간 단계에서 출력이 안나오게 할 수는 없다. 그림에서는 그리지 않았지만 중간단계의 출력이 존재한다는 말이다. 그 중간단계의 출력들을 무시하고 우리는 마지막의 출력값만 가져다가 쓰게다는 것이다. 그래서 training을 위해서 구조를 크게 바꿀 필요가 없다. 무시한다는 말은 그냥 error 함수를 잡을 때 마지막 것만 신경쓰도록 하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/121536600-2e63af00-ca3e-11eb-80ab-d3a9514d7e13.png)

따라서 error는 $o$에 대한 함수가 되고 학습은 synched many to many와 유사하게 진행하면 된다.

---

### 5. Many to Many

Many to Many는 입력과 출력값이 모두 여러개인 구조이다.

![image](https://user-images.githubusercontent.com/61526722/121536962-797dc200-ca3e-11eb-8156-41a0d58a35dd.png)

이 구조를 두개로 나누어 보면 앞 부부은 many to one 그리고 뒷 부분은 one to many 구조가 sequential 하게 연결되어 있다고 할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121537432-e1cca380-ca3e-11eb-9713-0402ca95d57d.png)
![image](https://user-images.githubusercontent.com/61526722/121537436-e2fdd080-ca3e-11eb-9b77-5d3a80664b80.png)

앞 부분에서는 입력들이 들어가서 벡터로 나온다. hidden layer의 출력값이기 때문에. 그 벡터값은 전체의 입력을 대표하는 어떤 값이라고 할 수 있다. 다시 뒷 부분은 이 전체의 입력을 대표하는 벡터값을 입력으로 하여 풀어내고 있다. 따라서 <mask>앞부분은 encoder 뒷 부분을 decoder</mask>라고 할 수 있다. Encoder는 주어진 입력을 하나의 벡터로 압축하는 것이다. Decoder는 이 암호화된 벡터를 풀어주는 역할을 한다. 우리는 이 압축된 벡터를 입력들의 의미를 나타내는 벡터라고 본다. 이 관점에서 다시 보면 encoder는 의미상의 한 점으로 mapping하는 것이고 decoder는 mapping 된 점을 표현 representation하는 것이다. 

지금 말 한것이 <mask>autoencoder 구조</mask>이다. 예를 들어 이미지를 텍스트로 매핑하려면 encoder(CNN)-decoder(RNN)으로 하면 되고, 텍스트를 텍스트로 매핑하려면 encoder(RNN)-decoder(RNN)으로 하면 된다. 이처럼 autoencoder는 특정 입력이 가지고 있는 의미를 다른 형태로 generation하는 task에 많이 사용된다. 

Training은 다음과 같이 진행한다. 

![image](https://user-images.githubusercontent.com/61526722/121538651-ea71a980-ca3f-11eb-9df9-88c5be4f60b9.png)

Test는 다음과 같이 진행한다. 

![image](https://user-images.githubusercontent.com/61526722/121539537-b8ad1280-ca40-11eb-9f9f-2a1afa62fca6.png)

Many to Many의 예시인 word embedding이다. Encoder에서 나온 값인 $h_{8}$를 decoder의 입력으로 사용한다. 

![image](https://user-images.githubusercontent.com/61526722/121540203-40931c80-ca41-11eb-8046-39e164479fd2.png)

---

### 6. Handling words 

Caption generation이나 machine translation에서 입력인 단어로 들어가는 데 단어들을 어떻게 입력으로 집어넣는지 알아본다.

단어를 처리하는 것은 간단하다. 첫 번째는 전처리가 필요하다. 나타나는 단어들의 unique word를 찾고 그 단어배열에 대한 ont-hot encoding을 한다. 

![image](https://user-images.githubusercontent.com/61526722/121542173-e1cea280-ca42-11eb-8f9f-1f3b601e3c42.png)

이렇게 enconding을 하고 나서 입력으로 주는데 embedding layer를 추가하여 one-hot vector와 fully connected를 구성한다. 그 이유는 one-hot encoding의 차원은 단어의 개수만큼 되어 엄청나게 큰 배열일텐데 embedding layer로 작은 차원으로 줄여준다. Embedding layer는 그냥 hidden layer 라고 보면 된다. 

![image](https://user-images.githubusercontent.com/61526722/121542717-5570af80-ca43-11eb-8b01-84dc69121370.png)

그러면 이 embedding layer는 누가 학습시킬까. RNN을 학습시킬때 같이 시키면 된다. 내가 원하는 출력이 나오도록 하는 embedding을 만들어내는 것이다.

출력을 할때는 softmax를 사용하기 때문에 softmax중에서 가장 큰 값을 골라 그에 해당하는 단어를 선택하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/121544051-6241d300-ca44-11eb-9594-d3637e873c8d.png)

정리하면 단어는 nominal value이기 때문에 one-hot encoding을 사용하면 된다. 입력으로 줄 때는 embedding layer를 추가하여 원하는 차원으로 줄인다. 출력은 softmax로 나오는데 이를 one-hot encoding으로 출력하여 결과값을 얻는다. 


---

이번 문서에서는 다양한 sequence modeling 구조를 살펴보았다. 다음에는 RNN의 attention model을 공부해 볼 것이다. 



