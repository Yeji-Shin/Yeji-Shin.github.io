---
layout: post
title: Gradient Descent Optimizer
date: 2021-06-07
category: DeepLearning
use_math: true
---

지금까지 딥러닝의 학습에는 gradient descent(GD) method를 사용한다고 했다. 하지만 GD는 여러가지 문제점을 가지고 있다.
이 문제점이 무엇인지 그 해결방법은 어떤 것들이 있는지 살펴볼 것이다.

---

![image](https://user-images.githubusercontent.com/61526722/120910295-b3566d80-c6b8-11eb-9957-d4b1eb508022.png)

---

### 1. Batch Gradient Descent (GD) 

Gradient descent를 다시 상기시켜보면 딥러닝 모델의 loss function을 최소화하기 위한 알고리즘으로 loss function의 극소점을 찾기 위해 gradient 반대 방향으로 이동해가는 방법이다. 

![image](https://user-images.githubusercontent.com/61526722/120910373-61faae00-c6b9-11eb-8722-39e903166fb9.png)

GD는 데이터의 모든 자료를 다 사용해서 gradient를 계산하기 때문에 학습 속도가 굉장히 느리다. 
다 사용한다는 말은 첫번째, 두번째, ... n번째 모든 training data에 대한 gradient를 누적해서 총 gradient를 계산하여 weight를 업데이트한다.

![image](https://user-images.githubusercontent.com/61526722/120910930-e0594f00-c6bd-11eb-9713-3e9e98d9546e.png)

GD의 학습 속도를 개선하기 위해 트릭을 써서 학습 속도를 조금 더 높인것이 Stochastic Gradient Descent Method이다.

#### 장점
- local minimum은 무조건 찾을 수 있다.

#### 단점
- 속도가 느리다.
- global minimum을 찾지 못한다.

---

### 2. Stochastic Gradient Descent (SGD)

첫 번째 training data에 대한 error의 graident도 gradient고, 모든 training data에 대한 error의 gradient도 gradient인데 왜 굳이 다 써야하나 라고 생각했다.
따라서 각 training data에 대한 error의 graident를 가지고 NN을 업데이트 하기로 한다. 

첫 번째 training data를 넣어서 gradient가 나오면 바로 업데이트한다.

![image](https://user-images.githubusercontent.com/61526722/120910500-607db580-c6ba-11eb-94d2-cac82744365f.png)

두 번째 training data를 넣어서 gradient가 나오면 바로 업데이트한다. 

![image](https://user-images.githubusercontent.com/61526722/120910544-b3576d00-c6ba-11eb-8ca3-94ef41ce2c5f.png)

n 번째 training data를 넣어서 gradient가 나오면 바로 업데이트한다. 

![image](https://user-images.githubusercontent.com/61526722/120910556-c36f4c80-c6ba-11eb-81b3-5d7e49e1829d.png)

#### 장점
  - Batch mode에서는 training data를 한번 스캔하면 한번 업데이트가 일어났다면 SGD는 training data 수 만큼 n번 업데이트가 일어난다.
  - 수학적으로 맞는 방법은 아니지만 error function의 수렴속도가 GD보다 빠르다.
 
 그리고 어짜피 GD를 사용한다고 해도 global minimum한 점을 찾을 수 없다. Local minimum밖에 못찾는다. 
 따라서 SGD가 수학적으로 맞는 방법이 아닐지라도 나쁜 방법은 아니다.
 
 ![image](https://user-images.githubusercontent.com/61526722/120910896-a425ee80-c6bd-11eb-8fc6-38e2c9b949fb.png)
 
수학적으로 맞는 방법이 아니라서 error function이 단조적으로 감소하는 것이 아니라 오르락 내리락 하면서 엉뚱하게 업데이트가 된다.
하지만 시간이 지나갈 수록 우하향을 그리게 되는 것을 똑같다.  

---

### 3. Mini-batch Gradient Descent

여기서 **Mini-batch Gradient Descent**라는 방법이 또 하나 등장한다. 
SGD가 training data 하나만 보고 NN을 업데이틀 하는 것은 좀 심하지 않냐 몇 개씩 묶어서 보자 라고 해서 나온것이 Mini-batch Gradient Descent이다. 

![image](https://user-images.githubusercontent.com/61526722/120911061-13e8a900-c6bf-11eb-834f-6132b3b2f425.png)

예를 들어 training data 2개를 보고 업데이트 하는 방법은 아래 그림과 같다. 여기서 이해하기 쉽게 두개라고 했지만 보통은 수십개에서 수백개를 batch size로 설정한다. 
첫 번째, 두 번째 데이터에 대한 gradient를 summation해서 업데이트 한다. 

![image](https://user-images.githubusercontent.com/61526722/120911019-a3418c80-c6be-11eb-9054-8a5a2b1d3f9a.png)

그 다음 batch인 세 번째, 네 번째 데이터에 대한 gradient를 summation해서 업데이트 한다. 

![image](https://user-images.githubusercontent.com/61526722/120911024-af2d4e80-c6be-11eb-8b92-e9bf3d958c82.png)

#### 장점
  - gradient에 대한 estimation이 좋다.
  - 업데이트 수가 굉장히 많기 때문에 동일한 시간 내에 좀 더 빠르게 수렴을 한다. 

#### 단점
  - dataset의 분산이 크면 batch를 뽑아서 전체 dataset의 전체적인 분포를 보기 어렵다.

---

알다시피 GD는 local optimum을 찾아가는 방법이다. 이제 사람들은 두 가지 고민을 하게 된다.

- local optimum을 탈출하는 방법은 없을까? **Momentum**
  
  이는 곡선을 따라 공을 굴렸을 때 관성으로 조금 더 앞으로 나아가는 개념을 적용한 Momentum으로 해결한다.
- Learning rate를 어떻게 설정하는 것이 좋을까? **Adagrad, RMSProp, AdatDelta...**
  
  학습초기에는 learning rate이 큰것이 좋지만 학습이 거의 다 이루어진 막판에는 learning rate이 작은것이 좋다.
  또한, NN의 수많은 connection weight에 대해 learning rate를 다 다르게 해보자는 방법이 등장했다.
  
이제 차례대로 하나씩 공부해보기로 한다.

---

먼저 local minimum을 탈출하는 방법이다.

### 4. Momentum

지금까지 배웠던 GD, SGD, Mini-batch SGD는 현재 위치에 의존하고 있다. 여기서 두 가지 문제가 발생한다. 첫 번째는 과거에 경사가 있었는지 없었는지 가고 있었는지 멈춰있었는지 신경 쓰지 않고 현재 지점에서의 gradient가 0이니깐 멈추겠다 하고 학습을 멈춰서 local minimum에 빠진다. 두 번째는 현재 위치에서의 기울기를 구하니깐 기울기가 가파르면 많이 점프하고 기울기가 완만하면 조금 점프하면서 부드럽게 경사를 타고 내려가지 못하는 oscillation 현상이 일어난다.

![image](https://user-images.githubusercontent.com/61526722/120911490-d2f29380-c6c2-11eb-9b47-ebf6bdc01079.png)

따라서 과거에 움직이던 방향으로 계속 움직이려는 힘을 사용해서 local minimum을 탈출해보겠다는 것이 Momentum 방법이다.
아래 그림처럼 GD는 현재 지점에서의 gradient $g_{t}$ 만 구해서 이동했다면 Momentum은 현재 지점에서의 gradient $g_{t}$에 과거에 이동하던 방향을 재활용해서 두 벡터의 summation 위치로 업데이트 한다. 

![image](https://user-images.githubusercontent.com/61526722/120911625-c02c8e80-c6c3-11eb-9b85-be0e7a8fcf99.png)
![image](https://user-images.githubusercontent.com/61526722/120911628-c1f65200-c6c3-11eb-839c-41e9a1d88453.png)

이렇게 하면 현재 지점에서의 gradient가 0이라고 과거의 이동하던 방향으로 이동하면서 local minimum을 탈출할 수 있게 되는 것이다. 최근에 사용되는 대부분의 NN은 momentum을 이용하여 학습한다. 위 방법을 수식으로 정하면 다음과 같다.

![image](https://user-images.githubusercontent.com/61526722/120911663-fcf88580-c6c3-11eb-99f3-b90374ad10ea.png)

![image](https://user-images.githubusercontent.com/61526722/120911832-3ed5fb80-c6c5-11eb-975b-f20f34f3edfe.png)

여기서 momentum 수식은 recursive하게 과거의 정보를 더하게 되므로 이동 히스토리에 의존하는 값(과거 gradient들의 exponential average)이 된다. 그리고 감마의 값은 0~1 사이의 값이기 때문에 아주 먼 과거는 잊어버리고 최근 정보를 더 많이 이용하여 $m$을 업데이트 한다고 할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/120911706-51036a00-c6c4-11eb-8ca3-2883ca78502b.png)

또한, momentum은 exponetial average가 되기 때문에 현재 지점에서의 기울기에 상관없이 점프의 간격이 비슷하게 되며 smooth 하게 이동한다는 장점이 있다.

#### 장점
  - local minimum을 탈출할 수 있다.
  - smooth하게 이동하면서 학습 속도가 좀 더 빨라질 수 있다.

#### 단점
  - 업데이트가 너무 지나치게 많이 일어난다.
  - 멈춰야하는 minimum 지점을 지나칠 수 있다.

momentum과 gradient를 더해서 업데이트가 일어나기 때문에 너무 멀리 점프할 수도 있다는 말이다. 

점프를 너무 멀리해서 minimum을 지나치는 문제를 해결한 것이 **Nesterov Accelerated Gradient (NAG)** 이다.

---

### 5. Nesterov Accelerated Gradient (NAG)

Momentum과 큰 차이는 없지만 NAG는 momentum만 이용해서 먼저 점프를 한 다음에 점프한 자리에서 gradient를 보고 이동한다.

![image](https://user-images.githubusercontent.com/61526722/120912018-c2dcb300-c6c6-11eb-90ae-cdccddd6ba2b.png)

---

다음으로 Adaptive Learning Rates를 적용하는 방법이다. 앞에서 말했듯이 learning rate은 고정된 값을 사용하는 것이 좋지 않다. 그리고 모든 connection weight이 동일한 learning rate를 사용하는 것이 적절하지 않다.

### 6. Adagrad

Adagrad는 각 connection weight마다 learning rate를 다르게 설정해서 업데이트하는 방식이다. 기본적인 아이디어는 지금까지 많이 변화하지 않은 변수들은 step size를 크게 하고, 지금까지 많이 변화했던 변수들은 step size를 작게 설정하는 것이다. 자주 등장하거나 변화를 많이 한 변수들의 경우 optimum에 가까이 있을 확률이 높기 때문에 작은 크기로 이동하면서 세밀한 값을 조정하고, 적게 변화한 변수들은 optimum 값에 도달하기 위해서는 많이 이동해야할 확률이 높기 때문에 빠르게 loss 값을 줄이는 방향으로 이동하려는 방식이라고 생각하면 된다.

![image](https://user-images.githubusercontent.com/61526722/120912132-adb45400-c6c7-11eb-9e9e-ec7ab09f5b91.png)

지금까지의 gradient를 모두 더한 

#### 장점
- word2vec이나 GloVe 같이 word representation을 학습시킬 경우 단어의 등장 확률에 따라 variable의 사용 비율이 확연하게 차이나기 때문에 Adagrad와 같은 학습 방식을 이용하면 훨씬 더 좋은 성능을 거둘 수 있을 것이다.

#### 단점 
- 학습을 계속 진행하면 step size가 너무 줄어든다.

 $G_{i}^{t}$는 누적만 하니깐 시간에 대해 단조증가하는 함수이다. 시간이 지날수록 $G_{i}^{t}$의 값이 커져 $w_{i}^{t}$값이 작아지기 때문에 학습이 덜 됐는데 학습이 멈출 수가 있다. 


이 단점을 보완한 것이 RMSProp이다. 

---

### 7. RMSProp
 
Adagrad의 식에서 $G_{i}^{t}$는 시간에 따른 단조증가 함수였다면, RMSProp에서 $G_{i}^{t}$는 exponential average가 된다. Exponential average는 Momentum을 공부하면서 이야기했듯이 최근 gradient들의 평균이라고 할 수 있다. 따라서 최근에 업데이트가 많이 된 변수는 step size를 작게, 최근에 업데이트가 많이 되지 않은 변수는 step size를 크게 하는 것이다. 이렇게 대체를 할 경우 Adagrad처럼 $G_{i}^{t}$가 무한정 커지지는 않으면서 최근 변화량의 weight간 상대적인 크기 차이는 유지할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120912618-b9097e80-c6cb-11eb-9093-de410f7baff7.png)

---

### 8. Adaptive Moment Estimation (Adam)

Adam은 RMSProp과 Momentum 방식을 합친 것 같은 알고리즘이다. 이 방식에서는 Momentum과 유사하게 지금까지 계산해온 기울기의 지수평균을 사용하며, RMSProp과 유사하게 기울기의 제곱값의 지수평균을 사용한다.

![image](https://user-images.githubusercontent.com/61526722/120912723-aa6f9700-c6cc-11eb-9d31-baf30ba6b036.png)

![image](https://user-images.githubusercontent.com/61526722/120912741-cbd08300-c6cc-11eb-9fc8-e2d24124e6e8.png)

$\hat G_{i}^{t}$ 과 $\hat m_{i}^{t}$ 통계에서 나오는 불편향 추정량이다. 

---

![image](https://user-images.githubusercontent.com/61526722/120912820-6fba2e80-c6cd-11eb-8726-bc8dcf923b61.png)


