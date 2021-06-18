---
layout: post
title: Hyperparameter Optimization (1)
date: 2021-06-19
category: DeepLearning
use_math: true
---

이번 문서에서는 Hyperparameter Optimization에 대해 살펴볼 것이다. Hyperparameter는 learning rate, momentum rate, dropout rate, normalization, layer의 개수, 노드의 개수 등 우리가 정해야 하는 변수들이다. 이것들은 trial and error로 설정하는데 이 과정을 자동화하는 방법을 공부한다. 

---

### 1. Hyperparameter Optimization

우리가 만든 NN의 accuracy는 $\eta ,\gamma ,p, m, n$의 함수로 다음과 같이 표현할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/122404971-9d9b4f00-cfba-11eb-92e6-1d00a60b724b.png)
![image](https://user-images.githubusercontent.com/61526722/122404989-a12ed600-cfba-11eb-99d5-951e145f2a56.png)

따라서 최적의 hyperparameter를 찾는다고 하면 아래 수식을 만족하는 값을 찾으면 되는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122405153-c58ab280-cfba-11eb-972c-be89d73b13ab.png)

하지만 우리는 함수 f가 어떤것인지 모른다는 문제가 있다. 그래도 각 파라미터의 값을 얼마로 할지 세팅이 주어지면 그 세팅에 대한 f를 평가할 수는 있다. f값을 계산하는 것은 계속 NN을 훈련해야 하기 때문에 expensive하다. 

만약 expensive하지 않다면 우리는 각 파라미터의 값을 여러 조합으로 세팅하여(random search) 가장 좋은 결과를 내는 값을 설정하면 된다. 하지만 이렇게 해도 global optimum을 찾지는 못한다. 결론적으로 random search 기법도 계산량이 비싸기 때문에 현실적으로 불가능하다. 

![image](https://user-images.githubusercontent.com/61526722/122406449-d1c33f80-cfbb-11eb-9131-d05bac512b6f.png)

이러한 simple search 알고리즘에는 대표적으로 random search와 grid search가 있다. 

![image](https://user-images.githubusercontent.com/61526722/122406740-0c2cdc80-cfbc-11eb-96c3-6b19b102a81a.png)

그리드 서치는 일정 간격으로 정해놓고 각 점들을 다 시도한 다음에 가장 좋은 것을 선택하는 방법이다. 랜덤 서치는 그냥 마음대로 점을 찍어서 평가한다. 이 두가지의 탐색 방법은 별로 좋지 않다. 그 이유는 이전의 시도를 기반으로 다음에 어느 점을 시도할지 정하면 훨씬 더 효율적일 것인데 그리드 서치와 랜덤 서치는 이전의 시도와 계속 독립적으로 새로운 시도를 하기 때문이다. 예를 들어 accuracy가 높은 점이 발견되었으면 그 점 주변으로 좀 더 탐색하는 것이 더 효율적일 것이다. 

결국 우리는 f를 모르기 때문에 trial and error 방법으로 탐색해야 하는데, 이 try가 굉장이 expensive 하니 try의 횟수를 줄일수 밖에 없고, try의 횟수를 줄이려면 지금까지 했던 <mark>과거의 몇번의 시도들을 분석해서 더 좋은 포인트로 이동하는 방식</mark>으로 탐색의 수를 줄일 수 밖에 없다. 또한, <mark>처음에 랜덤하게 세팅한 파라미터들을 가지고 NN을 끝까지 학습할 필요가 없다</mark>. 후반으로 갈수록 좀 더 좋은 세팅을 잡을테니깐 그때가서 NN을 끝까지 학습시키면 된다는 것이다. 이렇게 전반적으로 evaluation하는 시간을 아낄 수 있을 것이다. 

---

### 2. Bayesian Optimization

먼저 과거의 시도들을 분석해 더 좋은 다음 포인트를 찾아내는 기법인  Bayesian Optimization 방법을 살펴본다. 

![image](https://user-images.githubusercontent.com/61526722/122409119-da1c7a00-cfbd-11eb-8405-5d897a462128.png)

처음에는 몇개의 점들을 이용하여 함수 $f$가 어떻게 생겼을지를 추측한다. 그 함수를 기반으로 $f$가 최대가 될 것 같은 다음 포인트를 찾아내고 evaluation을 실행한다. 다시 추출한 결과를 가지고 함수 $f$에 대한 추측을 업데이트한다. 이것을 반복하다 보면 좋은 점을 찾아낼 수 있지 않겠냐는 아이디어다. 함수를 추측할 때는 <mark>gaussian process</mark>를 이용한다. 

---

### 3. Gaussian Process

#### Parametric Models vs Non-parametric Models

기계학습은 크게 parametric model과 non-parametric model로 나눌수 있는데, parametric model은 데이터로부터 몇개의 파라미터들을 추출하여 그 파라미터를 이용하여 추론 즉, $y=ax+b$를 예측하여 test하는 반면 non-parametric model은 모델의 구조를 가정하지 않고 데이터로부터 직접 추론한다. 

- Parametric Models: Linear regression, GMM
- Non-parametric Models: KNN, Kernel regression, Gaussian process

Gaussian Process는 regression 기법 중 하나이다. 

![image](https://user-images.githubusercontent.com/61526722/122411618-dab61000-cfbf-11eb-9f26-b0c13cb6a2b4.png)

Kernel regression은 일종의 점추정을 한다. 점추정은 새로운 x값에 대해 추론의 결과 y가 점(값)으로 나오는 것이다. 하지만 gaussian process는 <mark>구간추정</mark>을 한다. 구간 추청은 새로운 값에 대한 추론의 결과를 구간으로 표현한다. 구간은 확률분포인데 이는 normal distribution으로 나타낸다. 따라서 y를 확률변수로 이해하여 y가 대략 이러한 확률로 분포한다는 것을 말해준다. 

#### Gaussian Distribution

Gaussian Distribution은 1차원이 아닌 변수가 여러개 있는 다차원의 분포이다. 따라서 임의의 x에 대한 확률분포가 어떻게 되냐고 물으면 대략적으로 아래 그램의 f(x)를 따른다고 말한다. 

![image](https://user-images.githubusercontent.com/61526722/122412982-fc63c700-cfc0-11eb-9311-d38277011b0a.png)

이때의 covariance matrix $\Sigma$는 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/122414527-2d90c700-cfc2-11eb-8df2-4b599999a8f2.png)

![image](https://user-images.githubusercontent.com/61526722/122414498-27024f80-cfc2-11eb-8b8c-0665b34d8c52.png)

Covariance matrix는 gaussian distribution의 모양을 결정한다. $\Sigma$의 대각행렬이 일정하며 다른 원소가 다 0일 때는 gaussian distribution은 원 모양의 분포를 가진다. 대각선이 다 다른값을 가짐녀서 다른 원소가 다 0일 때는 축에 평행한 타원모양의 분포를 가진다. 그렇지 않고 값이 다 채워지면 축에 대해 회전변환이 된 타원 모양의 분포를 갖는다. 

![image](https://user-images.githubusercontent.com/61526722/122415145-a001a700-cfc2-11eb-88d1-7e952cfc7081.png)

더 나아가 Posterior Gaussian Distribution는 어떤 변수가 하나가 주어졌을 때 (단면을 자르면) 단면적의 모양도 Gaussian Distribution이 되는 Gaussian Distribution을 의미한다. 

#### Gaussian Process

Gaussian Process 처음에는 몇개의 점들을 이용하여 함수 $f$가 어떻게 생겼을지를 추측하는 방법이라고 했다. Gaussian Process을 하기 위해서는 3가지의 <mark>가정</mark>이 필요하다.

- 모든 y는 가우시안 분포를 따른다. $Y ~ N(0,1)$ 
- 어떤 두 변수를 합한것도 가우시안 분포를 따른다.  ![image](https://user-images.githubusercontent.com/61526722/122420348-97ab6b00-cfc6-11eb-9b96-45e220bfd692.png)
- 위 식을 구하기 위해서 $y_{1}$과 $y_{2}$사이의 공분산을 알고 있어야 한다. 사실 공분산은 알 수가 없다. 따라서 우리는 $x_{1}$과 $x_{2}$가 비슷할 수록 $f(x_{1})$와 $f(x_{1})$의 공분산은 커지고, 멀어질수록 공분산이 작아진다는 가정하여 공분산을 정의한다. ![image](https://user-images.githubusercontent.com/61526722/122422364-0ccb7000-cfc8-11eb-9942-d966f3a4496b.png)

예를 들어 $y_{1}=f(1)=1, covariance=0.7$ 이면 다음과 같이 $y_{2}$에 대한 구간추정을 할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/122421381-4a7bc900-cfc7-11eb-97f9-7879518fd463.png)

정리하면 우리가 Y값 몇개를 알고있으면 그것을 기반으로 새로운 y를 추정할 수 있다. 즉, training data의 확률분포로 test data의 확률분포를 알아낼 수 있다는 말이다. 

![image](https://user-images.githubusercontent.com/61526722/122424591-cf67e200-cfc9-11eb-9aca-cf458a7f7b5c.png)

하지만 x가 1에서 멀어질수록 covariance 값이 커지니깐 분포가 더 커지는 것을 확인할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/122441364-72275d00-cfd8-11eb-84fd-57e5428f81e0.png)

만약 두 점의 값을 알고있다면 다른 지점의 값은 아래와 같이 분포한다고 할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/122441579-a26efb80-cfd8-11eb-998b-82cf4ef92064.png)

이렇게 아는 점의 개수가 늘어날수록 y가 존재하는 범위는 실제함수와 유사하게 그려진다. 

![image](https://user-images.githubusercontent.com/61526722/122441918-ff6ab180-cfd8-11eb-8367-931c98093b91.png)

![image](https://user-images.githubusercontent.com/61526722/122441930-01347500-cfd9-11eb-8836-f124f4fd553b.png)

결론적으로 Gaussian Process는 우리가 어떤 함수를 알고 있는 몇 개의 점을 이용해서 계속 추적해가는 regression 기법이라고 이해하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/122443280-6472d700-cfda-11eb-87af-1dc4f138a86d.png)

다시 살펴보면 가정중에 우리가 선택할 수 있는 가정이 있다. 그것이 바로 covariance 함수이다. Covariance 함수가 바뀌면 추정되는 함수의 모양이 바뀌기 때문에 잘 선택해야 한다. 자주 사용되는 covariance 함수는 나중에 살펴보기로 한다. 

![image](https://user-images.githubusercontent.com/61526722/122442630-bbc47780-cfd9-11eb-9c68-d77906d51496.png)

Gaussian Process의 장점은 구간추정을 통해 <mark>uncertainty를 수치화할 수 있다</mark>는 것이다. 점추정은 결과값을 선택한데에 있어서 신뢰도를 표현할 수 있는 방법이 없다. 

---

이번 문서에서는 Hyperparameter Optimization을 실행하는 Bayesian Optimization에 대해 정리했고, 함수를 추측하는 gaussian process를 정리해보았다. 다음 문서에서는 Bayesian Optimization의 두번째 단계인 다음 포인트를 찾아내는 데 사용하는 Acquisition function에 대해 살펴볼 것이다. 
