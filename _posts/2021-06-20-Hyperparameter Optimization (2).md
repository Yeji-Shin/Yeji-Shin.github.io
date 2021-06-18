---
layout: post
title: Hyperparameter Optimization (2)
date: 2021-06-20
category: DeepLearning
use_math: true
---

Bayesian optimization 기법은 hyperparameter optimization 문제를 해결하는 가장 일찍 제안된 기법이다. Bayesian optimization의 기본 아이디어는 알고 있는 데이터를 사용해 함수를 예측하고, 예측한 함수로 부터 다음으로 조사해야할 지점을 선택하고, 조사한 결과를 바탕으로 함수를 다시 예측하는 과정을 반복하면서 점점 더 좋은 지점으로 접근해가는 것이라고 했다. 함수를 예측할 때는 gaussian process를 이용하고, 다음 포인트를 선택할 때는 aquisition function을 이용한다. 저번 문서에서 gaussian process를 공부했으니 이번에는 aquisition function에 대해 공부한다. 

---

### 1. Next Point Selection

다음 포인트를 선택할 때는 exploitation과 exploration 사이의 균형점을 찾아야 한다. Exploration은 uncertain을 고려하지 않고 최솟값이 나올 것 같은 점을 선택하는 것이다. 아래 그림에서는 0.65정도에서 최솟값이 나올것이라고 예상한다. 하지만 실제로 우리가 0.65를 선택하면 회색 경계안의 한 점에 y값이 존재하고 예상했던 것 보다 더 높은 y값을 얻을 수도 있다. 따라서 우리는 y값이 최소일 확률이 가장 높을 것 같은 관점에서도 보아 0.75 근처를 선택할 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122527692-8742d100-d056-11eb-9c10-c9f6a18a7da4.png)

Acquisition Function $\alpha(x)$은 다음에 조사할 점의 적합도라고 이해하면 된다. 즉, 각 점에 대해 조사할만한 가치를 매기는 것이다. 따라서 조사해야 될 추보들 중에 가장 좋은 것을 next point로 잡는다. 

![image](https://user-images.githubusercontent.com/61526722/122527975-cec95d00-d056-11eb-94ac-61ebf0e4d50d.png)

Bayesian optimization의 과정을 그림으로 표현하면 아래와 같다. 초록색 선은 파란색 선은 조사할 영역의 중요도를 나타내고 acquisition function 중에 하나를 이용해서 조사할 가치가 최대가 되는 지점을 선택한다. 그 지점에 대해서 쿼리를 하고 다음으로 알고 있는 두 지점을 가지고 다시 녹색 함수가 존재할 수 있는 범위를 계산한다. 조사한 범위를 가지고 다음 조사할 지점의 가치를 나타내는 acquisition function을 구해보고 이중에서 최대가 되는 지점을 선택한다. 

![image](https://user-images.githubusercontent.com/61526722/122529213-2f0cce80-d058-11eb-9f00-bb2bbf537b2d.png)
![image](https://user-images.githubusercontent.com/61526722/122529219-316f2880-d058-11eb-9f1d-8d073fc393ae.png)

![image](https://user-images.githubusercontent.com/61526722/122529229-33d18280-d058-11eb-98f7-669afffd4dac.png)
![image](https://user-images.githubusercontent.com/61526722/122529247-36cc7300-d058-11eb-9116-082060ece6e7.png)

이 과정을 반복하면 결국 우리가 찾고자 하는 min 값의 영역을 조사하게 된다. 

---

### 2. Acquisition Function

Acquisition Fuction는 다음에 조사할 점의 적합도라고 했다. 여러가지의 함수중 자주 사용하는 몇 가지를 소개한다. 

#### Expected Improvement (EI)

Expected Improvement는 특정 x에서의 y값이 $y_{best}$ 보다 작을 확률의 평균값이다. 이 평균값이 가장 큰 곳을 다음 포인트로 선택한다. 

![image](https://user-images.githubusercontent.com/61526722/122568111-62655280-d084-11eb-8886-98092f6a6bcf.png)

#### Probability of Improvement (PI)

Probability of Improvement에서 분자는 커질수록 좋은 것이다. $y_{best}$ 보다 특정 x에서의 평균값이 작아서 그 점에서 minimum 값이 나올 가능성이 크다. 반대로 분자가 크면 분산이 크다는 말이고, 분산이 크면 uncertainty가 커져 나쁜것이다. 

![image](https://user-images.githubusercontent.com/61526722/122569076-562dc500-d085-11eb-9e45-2fa80591233e.png)

#### Lower (upper) Confidence Bound (LCB, UCB)

검정색 선인 y가 존재할 수 있는 범위의 평균이 클수록 minimum 값이 나올 가능성이 작다. 그래서 평균에 -를 붙인것이다. 여기서 uncertainty를 고려하여 평균값에서 분산을 한번 뺀다. 다시말해서 구간추정의 평균값에서 분산을 한 번 빼주고 그 값이 가장 작은 곳을 다음 포인트로 선택한다. 

![image](https://user-images.githubusercontent.com/61526722/122569708-fab00700-d085-11eb-839e-fc75b478d130.png)


아래 그림은 acquisition function에 따른 성능 평가 결과이다. 우리는 EI나 PI 정도를 사용하면 된다.

![image](https://user-images.githubusercontent.com/61526722/122569946-3945c180-d086-11eb-8571-0428632086c5.png)

Acquisition function도 closed form으로 나오기 때문에 gradient descent method 등의 optimization 기법으로 최적의 acquisition function을 찾으면 된다. 

---

### 3. Disadvantage of Bayesian Optimization 

- Bayesian Optimization은 블랙박스 optimization에 좋지만 사람의 선택에 의존적인 문제가 있다. 다시말해 Bayesian optimization에 들어가는 hyperparameter를 어떻게 정하느냐에 따라서 optimization 성능히 바뀌게 된다. 
- 계속 새로운 점을 찾으며 sequential하게 실험이 진행되니까 계산량도 많고 느리다. 
- 만약 우리가 굉장히 많은 개수의 hyperparameter를 찾아야 한다면 Bayesian Optimization으로 찾은 hyperparameter는 성능이 좋지 않다는 단점이 있다.     
- gaussian process에서 covariance function을 정해야 하는데 함수에 따라 optimization 성능이 많이 차이난다. 

---

이렇게 해서 Bayesian Optimization를 사용한 Hyperparameter Optimization에 대해 살펴보았다. 







