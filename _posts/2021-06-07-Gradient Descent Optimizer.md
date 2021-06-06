---
layout: post
title: Gradient Descent Optimizer
date: 2021-06-07
category: DeepLearning
use_math: true
---

지금까지 딥러닝의 학습에는 gradient descent(GD) method를 사용한다고 했다. 하지만 GD는 여러가지 문제점을 가지고 있다.
이 문제점이 무엇인지 그 해결방법을 어떤 것들이 있는지 살펴볼 것이다.

---

![image](https://user-images.githubusercontent.com/61526722/120910295-b3566d80-c6b8-11eb-9957-d4b1eb508022.png)


### 1. Batch Gradient Descent (GD) 

Gradient descent를 다시 상기시켜보면 딥러닝 모델의 loss function을 최소화하기 위한 알고리즘으로 loss function의 극소점을 찾기 위해 gradient 반대 방향으로 이동해가는 방법이다. 

![image](https://user-images.githubusercontent.com/61526722/120910373-61faae00-c6b9-11eb-8722-39e903166fb9.png)

GD는 데이터의 모든 자료를 다 사용해서 gradient를 계산하기 때문에 학습 속도가 굉장히 느리다. 
다 사용한다는 말은 첫번째, 두번째, ... n번째 모든 training data에 대한 gradient를 누적해서 총 gradient를 계산하여 weight를 업데이트한다.

![image](https://user-images.githubusercontent.com/61526722/120910930-e0594f00-c6bd-11eb-9713-3e9e98d9546e.png)

GD의 학습 속도를 개선하기 위해 트릭을 써서 학습 속도를 조금 더 높인것이 Stochastic Gradient Descent Method이다.

+ 장점
  - local minimum은 무조건 찾을 수 있다.
+ 단점
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

+ 장점
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

+ 장점
  - gradient에 대한 estimation이 좋다.
  - 업데이트 수가 굉장히 많기 때문에 동일한 시간 내에 좀 더 빠르게 수렴을 한다. 
+ 단점
  - dataset의 분산이 크면 batch를 뽑아서 전체 dataset의 전체적인 분포를 보기 어렵다.

---

알다시피 GD는 local optimum을 찾아가는 방법이다. 이제 사람들은 두 가지 고민을 하게 된다.

- 더 좋은 local optimum으로 가는 방법은 없을까? Momentum
  
  이는 곡선을 따라 공을 굴렸을 때 관성으로 조금 더 앞으로 나아가는 개념을 적용한 Momentum으로 해결한다.
- Learning rate를 어떻게 설정하는 것이 좋을까? Adagrad, RMSProp, AdatDelta...
  
  학습초기에는 learning rate이 큰것이 좋지만 학습이 거의 다 이루어진 막판에는 learning rate이 작은것이 좋다.
  또한, NN의 수많은 connection weight에 대해 learning rate를 다 다르게 해보자는 방법이 등장했다.

---









