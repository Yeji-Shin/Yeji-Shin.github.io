---
layout: post
title: Hyperparameter Optimization (1)
date: 2021-06-19
category: DeepLearning
use_math: true
---

이번 문서에서는 Hyperparameter Optimization에 대해 살펴볼 것이다. Hyperparameter는 learning rate, momentum rate, dropout rate, normalization, 
layer의 개수, 노드의 개수 등 우리가 정해야 하는 변수들이다. 이것들은 trial and error로 설정하는데 이 과정을 자동화하는 방법을 공부한다. 

---

### 1. Function Optimization

우리가 만든 NN의 accuracy는 $\eta ,\gamma ,p, m, n$의 함수로 다음과 같이 표현할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/122404971-9d9b4f00-cfba-11eb-92e6-1d00a60b724b.png)
![image](https://user-images.githubusercontent.com/61526722/122404989-a12ed600-cfba-11eb-99d5-951e145f2a56.png)

따라서 hyperparameter를 찾는다고 하면 아래 수식을 만족하는 값을 찾으면 되는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122405153-c58ab280-cfba-11eb-972c-be89d73b13ab.png)

하지만 우리는 함수 f가 어떤것인지 모른다는 문제가 있다. 그래도 각 파라미터의 값을 얼마로 할지 세팅이 주어지면 그 세팅에 대한 f를 평가할 수는 있다. 
























