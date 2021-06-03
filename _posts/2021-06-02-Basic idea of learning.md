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

<mark>가장 잘 설명하는?</mark>

실제값(그림에서 빨간점)과 예측값(함수위의 점) 간의 차이를 최소화

![image](https://user-images.githubusercontent.com/61526722/120601124-8588e300-c484-11eb-92a8-26746059395d.png)

![image](https://user-images.githubusercontent.com/61526722/120601186-9afe0d00-c484-11eb-9a92-2029a73304b7.png)

E를 각 $w_{i}$들에 대한 편미분을 0으로 만드는 $w_{i}$값을 찾으면 오류를 최소화 할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120601246-ab15ec80-c484-11eb-822f-7804d04e3230.png)

하지만 위 식을 만족하는 값을 찾는 것은 어렵다... 이를 **optimization problem**이라고 한다. 따라서 E를 최소화스럽게(?) 만드는 $w_{i}$들을 찾는 문제로 바꾸어 문제를 해결한다. 이것이 바로 **Gradient Descent 방법**이다. 

---

### 2. Gradien Descent Method




* 머신러닝
  - 주어진 소재를 인간이 먼저 처리함
  - 사람이 training data를 알맞게 처리하여 컴퓨터가 인식하도록 함

+ 딥러닝
  - 머신러닝에서 인간이 하던 작업이 불필요
  - 데이터를 그대로 주고 신경망을 이용해 스스로 분석 한 후 답을 도출


> Deep Learning 이란?

This is code
```python
print('hello world')
```
