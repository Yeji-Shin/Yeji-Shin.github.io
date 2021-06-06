---
layout: post
title: Deep Neural Networks
date: 2021-06-08
category: DeepLearning
use_math: true
---

지금까지 NN의 기본과 학습 알고리즘들을 전반적으로 살펴보았다. 이번에는 Deep Neutral Network에 대해 살펴본다.

### 1. Deep Neural Network (DNN)

#### 왜 DNN이 필요한가? 

Shallow Network과 Deep Network의 차이는 없다. 기본적으로 shallow network는 2-layer나 3-layer 구조를 가진다. Neural Network(1)에서 말했듯이 이론적 관점에서 2-layer MLP는 모든 연속 함수를 만들 수 있고, 3-layer MLP는 모든 함수를 만들어낼 수 있다. 그렇다면 우리는 굳이 DNN을 사용하지 않아도 될 것인데 왜 사람들이 계속 DNN을 쓰려고 했고 왜 필요할까.

![image](https://user-images.githubusercontent.com/61526722/120913197-28816d00-c6d0-11eb-8f38-ffc59913c9dc.png)

정답은 노드의 개수에 있다. Shallow network는 이론적으로 모든 문제를 풀 수 있지만 노드의 개수가 exponentially 증가한다는 단점이 있다. 즉, 우리가 풀려고 하는 문제의 난이도가 조금만 높아져도 사용해야 하는 노드의 개수는 $2^{n}$으로 늘어나기 때문에 현실적으로는 문제를 푸는 것이 불가능하다. 이러한 **exponential exploding 문제** 는 많은 layer를 가지는 DNN을 사용하면 해결된다. DNN에서 layer를 쌓게되면 hidden layer에 존재하는 노드들이 곱하기 효과를 내서 노드를 많이 사용하지 않더라도 그 노드들이 표현할 수 있는 표현력은 수도 없이 많아질 수 있다. 다시말해 DNN은 상대적으로 적은 노드를 가지고도 충분한 파워를 낼 수 있는 구조이다. 하지만 DNN도 여러가지 문제가 있다. Layer가 많다 보니 shallow network에서 보이지 않았던 문제들이 드러나기 시작했다. 

#### DNN의 장점 
- deep한 구조에서 나오는 엄청난 파워

#### DNN의 단점
- optimization(학습)이 어렵다.
- 파워가 너무 크기 때문에 overfitting 되는 문제
- internal covariate shift

이제 이 문제들을 한 가지씩 해결해보자.

---

### 2. Vanishing Gradient and Exploding Problem

분명히 shallow network와 deep network는 이론적으로 차이가 없다고 했다. 그러면 shallow network에서 사용하던 error back propagation method를 DNN에 적용하면 당연히 학습이 될 것이라고 생각했지만 현실은 아니었다. Back propagation은 gradient를 사용하기 때문에 graidient 관점에서 두 가지의 문제가 생긴다. 하나는 gradient vanishing이라고 해서  gradient가 너무 작아서 학습이 안되는 문제, 다른 하나는 gradient가 너무 커져서 학습이 안되는 문제이다. 

![image](https://user-images.githubusercontent.com/61526722/120913656-97ac9080-c6d3-11eb-94c4-dd4a7a2eb0d8.png)

NN는 합성함수로 표현이 되는데 합성함수의 곱하기, 곱하기, 곱하기... 형태로 미분을 가지게 된다. DNN은 곱해지는 식들이 너무 많아지기 때문에 곱해지는 숫자가 뭐든간에 gradient는 0 (Vanishing Gradient) 또는 무한대 (Exploding Gradient)의 값을 가지게 된다. 

Exploding Gradient는 간단하게 특정 값을 넘어가면 1로 해줘라와 같이 threshold를 정해놓고 값을 조작하면 된다. 그리고 activation function을 signmoid를 사용한다면 0~1 값을 가지지 때문에 잘 일어나지 않는다. 따라서 우리의 숙제는 Vanishing Gradient를 해결하는 것이다.

![image](https://user-images.githubusercontent.com/61526722/120913802-d2fb8f00-c6d4-11eb-988b-ad57f9ef7450.png)

Vanishing Gradient를 해결하는 방법은 **activation function**에 있다. 우리는 지금까지 sigmoid를 activation function으로 사용해 왔는데 위 그림에서 볼 수 있듯이 gradient를 구하는데 처음에는 4개 중에 2개(노란색)가 sigmoid를 미분해서 나온것이고, 그 다음 layer에서는 7개의 term 중에 4개가 sigmoid를 미분해서 나온것이다. 곱해지는 term 중에 50% 이상을 activation fucntion이 차지하고 있다. 이렇게 activation function을 미분했더니 너무 많은 term 들이 생겨서 vanishing gradient 문제가 생겼다는 것이다. 그래서 이제 sigmoid 대신 다른 activation function을 사용하기 시작했다. 

---

### 3. Various Activation Functions

#### Rectified Linear Unit (ReLU)

![image](https://user-images.githubusercontent.com/61526722/120914025-46ea6700-c6d6-11eb-95a2-a168ef870275.png)

ReLU의 미분값은 1 아니면 0 값이 나온다. 따라서 gradient를 계산할 때 곱하기 term이 천천히 증가하기 때문에 vanishing gradient가 쉽게 생기지 않는다. 

#### ReLU의 장점

- vanishing gradient 문제를 해결한다.
- sparse activation 

gradient가 0 또는 1 이기 때문에 확률적으로 절반의 노드만 살아남는다. (이따가 설명할 dropout과 유사한 효과)
- 계산 속도가 exp을 계산해야 하는 sigmoid 보다 6배 빠르다.

#### ReLU의 장점

- Knockout problem

재수가 없어서 어떤 layer의 gradient가 모두 0이 되면 더이상 학습이 이루어지지 않는다. 


일반적으로 hidden layer에서는 ReLU를 많이 사용하고, classification을 위한 NN의 output layer에서는 sigmoid나 tanh를 사용한다. 

---




