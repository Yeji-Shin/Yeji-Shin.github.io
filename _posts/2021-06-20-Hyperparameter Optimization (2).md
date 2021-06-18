---
layout: post
title: Hyperparameter Optimization (2)
date: 2021-06-20
category: DeepLearning
use_math: true
---

Bayesian optimization 기법은 hyperparameter optimization 문제를 해결하는 가장 일찍 제안된 기법이다. Bayesian optimization의 기본 아이디어는 알고 있는 데이터를 사용해 함수를 예측하고, 예측한 함수로 부터 다음으로 조사해야할 지점을 선택하고, 조사한 결과를 바탕으로 함수를 다시 예측하는 과정을 반복하면서 점점 더 좋은 지점으로 접근해가는 것이라고 했다. 함수를 예측할 때는 gaussian process를 이용하고, 다음 포인트를 선택할 때는 aquisition function을 이용한다. 저번 문서에서 gaussian process를 공부했으니 이번에는 aquisition function에 대해 공부한다. 

---

### 1. Acquisition Function

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

























