---
layout: post
title: Neural Network (2)
date: 2021-06-05
category: DeepLearning
use_math: true
---

이번에는 neural network를 학습하는 방법, 즉, neural network의 connection weight를 설정하는 방법을 살펴본다. 

---

### 1. Neural Network Learning Algorithm

#### 학습이란? 

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

#### Overfitting이란?

주어진 데이터에 대해서는 예측을 잘 하고 새로운 데이터에 대해서는 예측 성능이 좋지 않은 상태를 말한다.

#### Generalization이란?

새로운 데이터가 들어와도 출력에 대한 성능 차이가 나지 않게 하는 것을 말한다. 

방금 전 예제에서 우리가 고른 첫번째 모델은 generalization이 잘 되었다고 하고 아래쪽에 있는 세번째 모델은 overfitting 됐다고 한다. 훈련을 진행할 때 모델을 어떻게 만들어라 직접적으로 강제할 수는 없다고 했지만 간접적으로 overfitting이 일어나지 않도록 모델을 달래는 방법이 있다.

#### <mark>Overfitting을 방지하는 방법</mark>
 - 적당한 학습횟수를 선택한다. 
 - Feature의 개수를 줄인다.
 - 데이터의 개수를 늘린다.
 - Regularization 기법 (L1-Reg, L2-Reg, Dropout, Eaaly stopping, weigth decay, data augmentation, stochastic pooling)을 사용한다.
 - Validation set을 만들어 모델을 훈련시킨다.


#### Feature의 개수를 줄인다.

아래와 같은 non-linear function에 대해 모델을 학습시킨다고 가정하자. 이 때 $M(차수의 수)$ 를 결정하는 것을 model selection 그리고 $W(connection weight)$를 결정하는 것을 parameter selection 이라고 한다.

![image](https://user-images.githubusercontent.com/61526722/120891412-7dc36d00-c643-11eb-8f8e-10179013d61a.png)

![image](https://user-images.githubusercontent.com/61526722/120891604-72247600-c644-11eb-8fbd-35760cd46ed4.png)

위 그림처럼 $M$ 이 증가할 수록 모델의 복잡도는 증가하고, 모델의 복잡도가 증가하면 주어진 데이터를 정확히 맞추는 모델이 되며 새로운 데이터에 대한 예측 성능이 감소한다. 또한, 특정 가중치의 값이 너무 커질 수 있다. 따라서 feature의 개수를 줄이는 것이 overfitting을 방지하는 방법이 될 수 있다.

#### 데이터의 개수를 늘린다.

또한, 데이터를 많이 사용하면 overfitting을 방지할 수 있다. 하지만 현실적으로 학습에 존재하는 문제를 해결할 정도로 데이터를 많이 모을 수는 없다. 따라서 모을 수 있는대로 많이 모으되 우리가 overfitting을 원천적으로 차단하기는 불가능하다.

![image](https://user-images.githubusercontent.com/61526722/120891628-92543500-c644-11eb-86bc-b587c5fdf725.png)

#### Regularization 기법 (L1-Reg, L2-Reg, dropout, early stopping, weigth decay, data augmentation, stochastic pooling, batch normalization)을 사용한다.

다음으로 regularization을 활용해 overfitting을 방지하는 방법이 있다. 이게 가장 현실적이고 직접적인 방법인데 아래처럼 error function에서 penalty term을 더하면 된다. $w$의 값이 커지는 것을 막기 위해 error function에 parameter들의 제곱의 합을 더해준다. 이를 'weight decay' 또는 'ridge regression (L2-reg)' 방법이라고 한다.

![image](https://user-images.githubusercontent.com/61526722/120891870-ddbb1300-c645-11eb-9eb6-e559ad4a2223.png)

![image](https://user-images.githubusercontent.com/61526722/120892029-0394e780-c647-11eb-8295-a27864258cf9.png)

 Loss function에 parameter들의 절댓값의 합을 더해주는 'Lasso regression (L1-reg)'와 L1-reg와 L2-reg를 혼합한 방법도 있다. 상황에 맞게 골라서 사용하면 된다.
 
![image](https://user-images.githubusercontent.com/61526722/120892147-a8172980-c647-11eb-8530-091124e1cd04.png)

나머지 regluarization 기법들은 추후에 살펴볼 것이다.

#### Validation set을 만들어 모델을 훈련시킨다.

또 하나의 방법은 validation set을 활용하는 것이다. validation set은 가짜 test data라고 생각하면 되는데 이를 활용해 overfitting이 일어나는지 확인하는 것이다. 가장 대표적으로 k-fold cross validation 방법을 설명하겠다.


K-fold validation은 데이터를 k개의 그룹으로 분할하여 (k-1)개를 training set으로 사용하고 나머지 1개를 validation set으로 사용하는 것이다. 분할된 데이터를 한번씩 validation set으로 설정할 수 있는데, 마지막에 모든 결과들을 평균내어 connection weight를 설정한다. 모델을 아래는 4-fold cross validation을 보여준다. 

![image](https://user-images.githubusercontent.com/61526722/120892197-0e9c4780-c648-11eb-8782-03937dfb6191.png)

![image](https://user-images.githubusercontent.com/61526722/120892261-5c18b480-c648-11eb-8977-2f2cfe8a9b1e.png)
![image](https://user-images.githubusercontent.com/61526722/120892276-76eb2900-c648-11eb-80ec-357db5837f3d.png)

데이터가 어떻게 나누어졌는지에 크게 의존하지 않으며 분할된 set은 (k-1)번 학습된다는 장점이 있지만 시간이 오래걸린다는 단점이 있는 방법이다.

---

다음 문서에는 상황에 따라 어떻게 NN을 설계해야 하는지 살펴볼 것이다. 


