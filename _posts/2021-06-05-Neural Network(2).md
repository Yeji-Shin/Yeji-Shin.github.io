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

학습이란? 

주어진 데이터에서 어떤 $x$를 NN에 집어넣었을 때 우리가 원하는 값 $t$가 나오도록 하는 connection weight를 찾는 것이 학습이다. 학습방법은 나와야 할 값과 NN을 거쳐서 나온 출력의 차이의 제곱을 모든 학습데이터에 대해서 summation 한 것을 error로 정의하고 그 error가 최소화가 되도록 connection weight을 업데이트 하면 된다. 이는 gradient descent method를 사용하여 풀게 된다.

![image](https://user-images.githubusercontent.com/61526722/120887237-a3914780-c62c-11eb-8e4e-5b9e805ad445.png)

![image](https://user-images.githubusercontent.com/61526722/120887250-adb34600-c62c-11eb-9331-27344f853cbb.png)

NN은 여러 개의 뉴런들로 구성하는데 각 뉴런은 함수이다. 따라서 NN은 하나의 거대한 굉장히 복잡한 합성함수가 되는데 직접 손으로 계산하며 모든 $w$들에 대한 최적 값을 구하기는 힘들다. 따라서 NN은 connection weight를 설정하는 일반적이 알고리즘이 필요하다. 이 알고리즘이 바로 **Error Back Propagation** 이다. 

---

### 2. Error Back Propagation

Error Back Propagation은 gradient descent method를 사용한 NN learning algorithm 이다. Error를 최소화하기 위해 각 $w$에 대한 편미분 값을 사용해 connection weight를 조정해 나가는 것이다. 하지만 error값에 대한 각 $w$의 편미분 값을 한번에 구하는 것은 너무 복잡하다. 따라서 chain rule을 적용하여 순차적으로 미분값을 앞의 노드로 보내는 것을 error back propagation이라고 한다.

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

이런 식으로 error 값을 앞의 layer로 차례대로 전파하게 된다.

---

### 3. Error Back Propagation Example

다음으로 back propagation을 활용해 XOR 문제를 풀어보도록 한다.

![image](https://user-images.githubusercontent.com/61526722/120890454-b6f8de80-c63d-11eb-930c-27f03b316bb3.png)

iteration : 0 은 random intialization 후의 weight를 나타낸다.

![image](https://user-images.githubusercontent.com/61526722/120890497-02ab8800-c63e-11eb-9f28-011e1d65937e.png)

![image](https://user-images.githubusercontent.com/61526722/120890541-57e79980-c63e-11eb-80e3-eafaff78e454.png)

![image](https://user-images.githubusercontent.com/61526722/120890593-ca587980-c63e-11eb-8c5b-7acd5141cf86.png)

![image](https://user-images.githubusercontent.com/61526722/120890633-10add880-c63f-11eb-8ba6-4e884a207ab1.png)

마지막 그림처럼 iteration에 대한 error 값이 주어졌을 때 과연 어느 지점에서 학습을 중단할 것인지 정해야 한다. NN의 목적은 training data를 정확하게 기억하는 것이 아니라 unkwon data에 대한 예측을 잘 하는 것이기 때문에 error가 0일 때가 아닌 0에 가까운 범위중 적당히 5000~6000 iteration에서 학습은 멈추는 것이 좋다. 

![image](https://user-images.githubusercontent.com/61526722/120890893-92eacc80-c640-11eb-98da-e4c36fe88548.png)

이런 것을 고려했을 때 위 그림에서 오른쪽 세 개중 첫번째 NN모델을 사용할 것이다. 그러면 어떻게 첫 번째 모델처럼 안배운 데이터에 대해 interpolation하도록 학습시킬수 있을까? 슬프지만 이렇게 만들어라 저렇게 만들어라 직접적으로 강제할 수 있는 방벙은 없다. 따라서 training data에 대해 수렴하도록 하는 것은 쉽지만 좋은 interpolation을 만들도록 하는 것이 어렵고 이것이 딥러닝하는 사람들의 큰 숙제이다.

---

### 4. Overfitting and Generalization

방금 전 예제에서 우리가 고른 첫번째 모델은 generalization이 잘 되었다고 하고 아래쪽에 있는 세번째 모델은 overfitting 됐다고 한다. 훈련을 진행할 때 모델을 어떻게 만들어라 직접적으로 강제할 수는 없다고 했지만 하지만 간접적으로 overfitting이 일어나지 않도록 모델을 달래는 방법이 있다.

Overfitting이란?

주어진 데이터에 대해서는 예측을 잘 하고 새로운 데이터에 대해서는 예측 성능이 좋지 않은 상태를 말한다.


+ <mark>Overfitting을 방지하는 방법</mark>
  - feature의 개수를 줄인다.
  - 데이터의 개수를 늘인다.
  - validation set을 만들어 모델을 훈련시킨다.
  - Regularization을 사용한다.

