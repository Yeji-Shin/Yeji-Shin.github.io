---
layout: post
title: Neural Network(2)
date: 2021-06-05
category: DeepLearning
use_math: true
---

이번에는 neural network를 학습하는 방법, 즉, neural network의 connection weight를 설정하는 방법을 살펴본다. 

---

### 1. Neural Network Learning Algorithm

학습이란? 주어진 데이터에서 어떤 $x$를 NN에 집어넣었을 때 우리가 원하는 값 $t$가 나오도록 connection weight를 찾는 것이 학습이다. 학습방법은 나와야 할 값과 NN을 거쳐서 나온 출력의 차이의 제곱을 모든 학습데이터에 대해서 summation 한 것을 error로 정의하고 그 error가 최소화가 되도록 connection weight을 업데이트 하면 된다. 이는 gradient descent method를 사용하여 풀게 된다.

![image](https://user-images.githubusercontent.com/61526722/120887237-a3914780-c62c-11eb-8e4e-5b9e805ad445.png)

![image](https://user-images.githubusercontent.com/61526722/120887250-adb34600-c62c-11eb-9331-27344f853cbb.png)

NN은 여러 개의 뉴런들로 구성하는데 각 뉴런은 함수이다. 따라서 NN은 하나의 거대한 굉장히 복잡한 합성함수가 되는데 이것을 모든 $w$들에 대해서 미분하기는 힘들다.

---

### 2. Error Back Propagation

Error Back Propagation은 gradient descent method를 사용한 NN learning algorithm 이다. Error를 최소화하기 위해 편미분 값을 사용하는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/120887843-1b14a600-c630-11eb-94c8-1079e29018dc.png)

아래는 간단한 2-layer MLP에 대한 역전파 과정을 나타낸다.

![image](https://user-images.githubusercontent.com/61526722/120888077-611e3980-c631-11eb-87dd-747434770945.png)

다음으로 activation function이 포함된 2-layer MLP에 대한 역전파 과정을 나타낸다. _net_ 은 summation을 나타내고 $sigma$ 는 activation function을 의미한다.

![image](https://user-images.githubusercontent.com/61526722/120887972-e1906a80-c630-11eb-89ec-2b42cb5c23c5.png)

이 때 backward flow에 대해 규칙을 발견할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120888030-1997ad80-c631-11eb-9ae6-cd6ea0e7f585.png)

- Add gate: gardient를 분배해준다.
- Mul gate: gradient는 바꿔준다.
- Max gate: gradient router

지금까지는 NN에 대한 미분까지 구해봤다면 아래 그림은 error값을 미분하는 방법을 나타낸다.  

![image](https://user-images.githubusercontent.com/61526722/120888131-ae9aa680-c631-11eb-9466-05bfb87a53b4.png)





