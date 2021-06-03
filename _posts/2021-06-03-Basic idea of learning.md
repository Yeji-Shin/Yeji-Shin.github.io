---
layout: post
title: Basic idea of learning
date: 2021-06-03
category: DeepLearning
use_math: true
---

### 1. Machine Learning


목표? 주어진 데이터를 <mark>가장 잘 설명하는</mark> 함수 y=f(x)를 `찾는 것`

---

**step 1: Choosing a model**

여러 종류의 모델 중에서 하나를 선택 $f(x_{1},x_{2},...; w_{1},w_{2},...)$

여기서 여러 종류의 모델은 logistic regression, support vector machine, random forest, nearest neighbor 등을 말한다.

**step 2: Optimizing parameter**

함수가 주어진 데이터에 가장 잘 부합하도록 w를 조정 (함수 모양은 $w_{1},w_{2},...$가 결정함)

**step 3: Prediction**

결정된 f를 이용해 새로운 x에 대한 y값을 예측

---

<mark>가장 잘 설명하는?</mark> 실제값(그림에서 빨간점)과 예측값(함수위의 점) 간의 차이를 최소화

![image](https://user-images.githubusercontent.com/61526722/120601124-8588e300-c484-11eb-92a8-26746059395d.png)
![image](https://user-images.githubusercontent.com/61526722/120601186-9afe0d00-c484-11eb-9a92-2029a73304b7.png)

E를 각 $w_{i}$들에 대한 편미분을 0으로 만드는 $w_{i}$값을 찾으면 오류를 최소화 할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120601246-ab15ec80-c484-11eb-822f-7804d04e3230.png)

하지만 위 식을 만족하는 값을 찾는 것은 어렵다. 우리가 실제로 마주하는 함수들은 형태가 복잡해 미분값을 계산하기 어려운 경우가 많고, 실제 미분값을 구하는 과정을 컴퓨터로 구현하는 것은 어렵기 때문이다. 이를 **optimization problem**이라고 한다. 따라서 꿩 대신 닭으로 E를 최소화스럽게(?) 만드는 $w_{i}$들을 찾는 문제로 바꾸어 문제를 해결한다. **즉, global optimum에서 local optimum을 찾는 문제로 바꾸는 것이다**. Local minimum을 찾을 때는 **Gradient Descent 방법**을 사용하면 이다. 

![image](https://user-images.githubusercontent.com/61526722/120658787-b424af00-c4c0-11eb-9041-89d93d8f6d7a.png)

파란색 점이 정답(global optimum)이지만 빨간색 점(local optimum)에 해당하는 $x$ 값을 찾아도 정답으로 인정을 해주겠다는 말로 이해하면 된다. 여기서 local optimum이 진짜 정답이 아닌데 괜찮은가라는 의문을 품을 수 있는데, 다른 방법이 없기 때문에 어쩔 수 없을 뿐더러 퀄리티 관점에서 볼 때 local optimum을 찾아도 크게 문제 없다.


### 2. Gradient Descent Method (경사하강법)


Gradient란? Gradient는 공간에 대한 기울기 벡터이다.

![image](https://user-images.githubusercontent.com/61526722/120653879-17f8a900-c4bc-11eb-8aa5-fc332dee6345.png)

Gradient vector는 각 parameter에 대한 기울기 벡터를 합한 것이라고 생각하면 된다. 즉, 가장 가파른 방향을 가르킨다.

![image](https://user-images.githubusercontent.com/61526722/120654198-67d77000-c4bc-11eb-844c-64cdd0449f83.png)

Gradient descent는 함수의 기울기를 이용해 $x$를 어디로 옮겼을 때 함수가 최솟값을 가지는지 알아보는 방법이다. 실제 사용되는 함수들은 거의 미분가능하기 때문에 GD는 범용적으로 사용될 수 있다.

---

**step 1: Random point selection**

임의의 시작점을 랜덤하게 잡는다.

**step 2: Calculate the gradient**

현재의 위치에서 gradient(기울기)를 구한다.

![image](https://user-images.githubusercontent.com/61526722/120654731-edf3b680-c4bc-11eb-953e-ace8e08174e5.png)

**step 3: Move the reverse direction of the gradient**

<mark>gradient의 반대 방향</mark>으로 매우 조금 이동한다.

![image](https://user-images.githubusercontent.com/61526722/120655034-357a4280-c4bd-11eb-92d0-1a35f19b6173.png)

반대 방향으로 이동하는 이유? 기울기가 양수라면 $x$값이 커질수록 함수 값이 커진다는 것이고, 기울기가 음수라면 $x$값이 커질수록 함수값이 작아진다는 것이므로 최솟값을 찾기 위해서는 기울기의 반대 방향으로 $x$를 이동해야 한다.

* 기울기 음수 -> 오른쪽으로 이동

* 기울기 양수 -> 왼쪽으로 이동

또한, 기울기가 크다는 것은 가파르다는 것이고 $x$값이 최솟값에 해당되는 $x$좌표로부터 멀리 떨어져있다는 것을 의미한다.

**step 4: Move until the gradient of $E(w)$ is zero**

기울기가 0인 곳에 도달할 때까지 이동을 반복한다.

![image](https://user-images.githubusercontent.com/61526722/120656903-f77e1e00-c4be-11eb-90d8-16d9badcba46.png)

여기서 $@eta$는 학습률, learning rate이다. Learning rate를 너무 크게 잡으면 건너편으로 점프하여 local minimum을 찾는 데 시간이 오래 걸리 수 있기 때문에 적절한 값을 잘 설정해야 한다.

---

정리하면, gradient descent는 초기 랜덤값에서 시작하여 기울기가 0인 곳에 도달할 때 까지 $x$값을 이동하는 것이라고 할 수 있다. $t$는 반복횟수이다.

![image](https://user-images.githubusercontent.com/61526722/120657194-41670400-c4bf-11eb-9f13-9d451b08c5e9.png)

위 그림은 변수가 한개인 경우이고, 다차원인 경우에는 각 변수에 대해 gradient descent를 진행하면 된다.

![image](https://user-images.githubusercontent.com/61526722/120657403-6d828500-c4bf-11eb-83eb-c7f0a0af9dc7.png)

