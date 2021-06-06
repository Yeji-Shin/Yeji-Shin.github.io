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

### 2. Rectified Linear Unit (ReLU) for vanishing gradient problem

#### Vanishing Gradient and Exploding Problem

분명히 shallow network와 deep network는 이론적으로 차이가 없다고 했다. 그러면 shallow network에서 사용하던 error back propagation method를 DNN에 적용하면 당연히 학습이 될 것이라고 생각했지만 현실은 아니었다. Back propagation은 gradient를 사용하기 때문에 graidient 관점에서 두 가지의 문제가 생긴다. 하나는 gradient vanishing이라고 해서  gradient가 너무 작아서 학습이 안되는 문제, 다른 하나는 gradient가 너무 커져서 학습이 안되는 문제이다. 

![image](https://user-images.githubusercontent.com/61526722/120913656-97ac9080-c6d3-11eb-94c4-dd4a7a2eb0d8.png)

NN는 합성함수로 표현이 되는데 합성함수의 곱하기, 곱하기, 곱하기... 형태로 미분을 가지게 된다. DNN은 곱해지는 식들이 너무 많아지기 때문에 곱해지는 숫자가 뭐든간에 gradient는 0 (Vanishing Gradient) 또는 무한대 (Exploding Gradient)의 값을 가지게 된다. 

Exploding Gradient는 간단하게 특정 값을 넘어가면 1로 해줘라와 같이 threshold를 정해놓고 값을 조작하면 된다. 그리고 activation function을 signmoid를 사용한다면 0~1 값을 가지지 때문에 잘 일어나지 않는다. 따라서 우리의 숙제는 Vanishing Gradient를 해결하는 것이다.

![image](https://user-images.githubusercontent.com/61526722/120913802-d2fb8f00-c6d4-11eb-988b-ad57f9ef7450.png)

Vanishing Gradient를 해결하는 방법은 **activation function**에 있다. 우리는 지금까지 sigmoid를 activation function으로 사용해 왔는데 위 그림에서 볼 수 있듯이 gradient를 구하는데 처음에는 4개 중에 2개(노란색)가 sigmoid를 미분해서 나온것이고, 그 다음 layer에서는 7개의 term 중에 4개가 sigmoid를 미분해서 나온것이다. 곱해지는 term 중에 50% 이상을 activation fucntion이 차지하고 있다. 이렇게 activation function을 미분했더니 너무 많은 term 들이 생겨서 vanishing gradient 문제가 생겼다는 것이다. 그래서 이제 sigmoid 대신 다른 activation function을 사용하기 시작했다.

#### Rectified Linear Unit (ReLU)

![image](https://user-images.githubusercontent.com/61526722/120914025-46ea6700-c6d6-11eb-95a2-a168ef870275.png)

ReLU의 미분값은 1 아니면 0 값이 나온다. 따라서 gradient를 계산할 때 곱하기 term이 천천히 증가하기 때문에 vanishing gradient가 쉽게 생기지 않는다. 

#### ReLU의 장점

- vanishing gradient 문제를 해결한다.
- sparse activation : gradient가 0 또는 1 이기 때문에 확률적으로 절반의 노드만 살아남는다. (이따가 설명할 dropout과 유사한 효과)
- 계산 속도가 exp을 계산해야 하는 sigmoid 보다 6배 빠르다.

#### ReLU의 장점

- Knockout problem : 재수가 없어서 어떤 layer의 gradient가 모두 0이 되면 더이상 학습이 이루어지지 않는다. 


일반적으로 hidden layer에서는 ReLU를 많이 사용하고, classification을 위한 NN의 output layer에서는 sigmoid나 tanh를 사용한다. 

---

### 3. Regularization Methods for Overfitting Problem

Overfitting은 error가 작지만 예측성능이 좋지 않은 상태를 말한다.

![image](https://user-images.githubusercontent.com/61526722/120914306-55d21900-c6d8-11eb-87d0-79013c143f35.png)

Overfitting을 방지하는 방법은 여러가지가 있다. 

- 적당한 학습횟수를 선택한다.
- Feature의 개수를 줄인다.
- 데이터의 개수를 늘린다.
- <mark>Regularization 기법 (L1-Reg, L2-Reg, dropout, dropconnection, early stopping, data augmentaition, weigth decay, stochastic pooling)</mark>을 사용한다.
- Validation set을 만들어 모델을 훈련시킨다.

![image](https://user-images.githubusercontent.com/61526722/120914466-5ae39800-c6d9-11eb-8dbf-f27442ce54ef.png)


여기서는 Neural Network(2)에서 미처 설명하지 못한 regularization 방법들을 살펴보려고 한다. 

#### Early Stopping 

Early Stopping은 error가 0으로 너무 많이 수렴하기 전에 학습을 중단시키는 기법이다. 하지만 우리는 어디서 멈추는 것이 최선인지 모르기 때문에 보통 validation set을 이용하여 몇 번째 epoch에서 멈출지를 경정한다. 

![image](https://user-images.githubusercontent.com/61526722/120914495-849cbf00-c6d9-11eb-9d73-93a9cb39a5e3.png)

#### Data Augmentation

Data augmentation은 데이터를 Rotate, Flip, Crop, Equalize, Solarize, and Posterize 하여 데이터 개수를 늘리는 방법이다. 

![image](https://user-images.githubusercontent.com/61526722/120915531-2541ad80-c6df-11eb-84ad-35d9ace7fadd.png)



#### Weight Decay (L1-Reg, L2-Reg)

NN은 일반적으로 수천개 수만개의 파라미터를 가지고 있으며 dataset의 개수가 파라미터의 개수보다 작은 경우도 존재한다. 파라미터의 개수가 너무 많으면 특정 파라미터의 가중치가 너무 커지는 문제가 있는데 이를 방지하기 위해 사용하는 방법이 weight decay 이다. Weight decay에는 두가지 방법이 있다. 

+ L1 Regularization
![image](https://user-images.githubusercontent.com/61526722/120914628-73a07d80-c6da-11eb-83a6-0a08723d4a4f.png)

  - 대부분의 weight들을 0에 가깝게 만들어준다.
  - input data의 noise에 강하다. 
  - 중요한 input을 고르는 것에 초점을 맞춘다.

+ L2 Regularization
![image](https://user-images.githubusercontent.com/61526722/120914680-a5194900-c6da-11eb-9512-ff1fc0ffb3cf.png)

  - 되도록 모든 training data를 사용하도록 권장하는 방법이다. 

L1 Regularization과 L2 Regularization는 우리가 알고있는 MSE loss나 cross entropy loss에 regularization term을 더한 것을 새로운 error function으로 정의하고 그것을 gradient descent method로 최소화한다. Error function이 최소화된다는 것은 $E(w)$ 뿐만 아니라 regularization term도 최소화되어야 한다는 것인데 과연 이게 무슨 의미일까.

먼저 $E(w)$인 MSE나 CE를 최소화하라는 것은 정확한 NN을 만들라는 뜻이다. 정확한 NN을 만들기 위해서는 복잡한 NN이 필요하다. 그리고 regularization term을 최소화하라는 것은 connection을 최대한 끊어내라는 것이다. 다시말하면 NN을 단순히하라는 뜻이 된다. NN 구조의 complexity를 줄여서 overfitting을 방지하는 것이다. 

정리하면 $E(w)$는 NN을 복잡하게 하려고 하고, regularization term은 NN을 단순화하려고 하기 때문에 서로 상반된 요구사항을 주고 이를 동시에 minimize하는 $w$를 찾으라고 하는 것이다. 즉, 적당한 구조를 가져서 error가 크지도 않고 작지도 않는 그런 NN을 찾는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/120915352-19092080-c6de-11eb-8728-cfde1d008d73.png)

L1과 L2를 비교하자면 L2는 모든 변수를 다 쓰면서 특별히 튀는 connection weight을 가진 변수가 없어야 loss를 최소화 할 수 있고, L1은 error 값만 작게 만들 수 있다면 튀는 애가 있어도 상관없다. 다시말해 L1은 중요한 변수와 중요하지 않은 변수를 찾아낼수 있다. 따라서 input selection 문제를 풀때는 보통 L1-Reg를 사용하고 성능을 높이기 위해서는 L2-Reg를 사용한다. 

![image](https://user-images.githubusercontent.com/61526722/120915470-ca0fbb00-c6de-11eb-860e-26803a5edcc9.png)

람다값이 커지면 단순한 모델을 만들고, 작아지면 복잡한 모델을 만들게 된다. 


#### Dropout

Dropout의 목적은 단순한 NN 구조를 찾는 것이다. 복잡한 NN을 살펴보면 어떤 connection weight은 학습이 잘되고 어떤 connection weight은 학습이 잘 안되고 불균등 학습이 일어난다고 했다. 즉, 많은 노드 중에서 학습을 열심히 하는 노드가 있는가 하면 학습을 게을리 하는 노드가 있는 것이다. 우리는 모든 노드가 균등하게 학습되는 것을 원한다. 왜냐면 학습이 잘 안된 노드가 어떤 input이 들어왔을 때 이상하게 작동할 수도 있기 때문이다. 여기서 고안된 방법이 model complexity를 낮추면서 모든 노드들이 균등하게 학습해보자라는 아이디어를 내게 된다. 

![image](https://user-images.githubusercontent.com/61526722/120915815-d4cb4f80-c6e0-11eb-9290-ca6f2dabc2f8.png)

이런 식으로 돌아가면서 몇 개의 노드를 빼고 학습을 여러번 시키면 모든 노드가 골고루 책임을 지고 학습된다는 것이다. 쉽게 말하면 특정 노드가 빠지면 그 노드가 하던 일을 다른 노드들이 하게 되는 것이다. 노드를 뺄 때는 $p$ 확률로 뺀다. 학습하는 시간은 좀 더 오래 걸리겠지만 complexity가 낮은 모델들이 계속 학습되어 중첩되는 효과를 내어 학습이 잘 된다.


![image](https://user-images.githubusercontent.com/61526722/120915870-1cea7200-c6e1-11eb-9092-cbe60a06d456.png)

<mark>Test할 때는 전체 노드를 다 사용한다.</mark> 하지만 이렇게 하면 문제가 발생하는데 아래 그림을 살펴보면서 이해해보자.

![image](https://user-images.githubusercontent.com/61526722/120915961-b44fc500-c6e1-11eb-8908-47b36f102b0c.png)

Training을 할때는 2개의 노드만 사용했고, test할 때는 모든 노드를 다 사용한다면 평균적으로 test output의 값이 training output 값의 2배가 될 것이다. 원래는 training 할 때나 test할 때나 동일한 output 값이 나와야 하기 때문에 test를 시행할 때는 노드드의 weight 값에 $(1-p)%$를 곱해준다. 여기서 $p$는 dropout probability이다.

그리고 dropout은 일종의 앙상블 모델이라고 할 수 있다. M개의 뉴런이 있다면 그것이 선택될 때, 안 될때를 계산하면 총 $2^M$ 개의 case가 나온다. 이렇게 complexity가 낮은 모델들을 학습시키면 underfitting이 일어날 수 있는데 이 모델들을 평균 내면 underfitting을 해결할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120916079-612a4200-c6e2-11eb-9ef8-7ea532bd918f.png)

![image](https://user-images.githubusercontent.com/61526722/120916381-4527a000-c6e4-11eb-9c34-060d455605ee.png)

아래 그림에서 볼 수 있듯이 dropout이 없을때는 overfitting이 일어난다. 

![image](https://user-images.githubusercontent.com/61526722/120916183-0d6c2880-c6e3-11eb-9e9a-0679b153c9a1.png)

데이터가 클 때는 dropout을 굳이 쓰지 않아도 되는데 데이터가 많음으로써 regularization 효과가 이미 충분하기 때문이다.  

![image](https://user-images.githubusercontent.com/61526722/120916241-689e1b00-c6e3-11eb-8593-f295acbb60bb.png)

---

### 4. Batch Normalization for Internal Covariate Shift Problem

#### Covariate Shift 

Covariate는 input data의 특징이다. Covariate shift는 입력의 분포가 바뀌는 것으로 training data와 test data가 너무 다를 때를 말할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/120916480-d0089a80-c6e4-11eb-861d-252ff5f1fcda.png)

#### Internal Covariate Shift 

학습을 하면 connection weight값이 바뀌고, 출력값도 바뀐다. 이는 그 다음 layer의 input distribution이 바뀐다는 말이다. 즉, forward로 출력값을 계산할 수록 distribution이 더 심하게 바뀐다. Internal Covariate Shift는 NN에서 각 layer의 net값의 분포가 학습할 때마다 바뀌는 것이다. Training 중에 NN 내부에서 생기는 covariate shift라고 생각하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/120916917-6f2e9180-c6e7-11eb-8ffe-07cb16522ab9.png)

예를 들어 i번째에서 [0,1]의 값을 받아서 열심히 학습했는데 갑자기 (i+1)번째 학습에서 [2,3] 범위의 값이 들어오면 input data의 범위가 급격히 변하면서 아까의 학습이 유효하지 않게 되고 학습이 굉장히 느려지게 된다. 이 문제를 해결하는 것이 batch normalization이다. 


#### Batch Normalization

정말 쉽게 생각해서 shift 된 distribution을 다시 제자리로 돌려 놓는 연산을 하나 추가하면 모든 것은 해결된다. 이것이 바로 normalization 연산이다. 이렇게 normalization 된 값을 activation function에 넣어서 학습을 시키면 된다. 

![image](https://user-images.githubusercontent.com/61526722/120917256-2bd52280-c6e9-11eb-85ca-16f1bf9fb248.png)

Normalization은  mini-batch 단위로 net값의 평균 분산을 구하고 z-transformation을 하면 된다. normalization을 하면 어떤 net 값이 들어와도 $\hat{net}$ 값은 표준정규분포를 따르니깐 다음 layer의 입장에서는 항상 똑같은 입력 분포가 들어온다. 

하지만 z-transformation을 진행하면 net에는 bias가 있었지만 $\hat{net}$ 에서는 bias가 사라진다. Bias는 NN의 파워를 결정하는 중요한 변수이기 때문에 bias를 다시 더해주는 과정을 거쳐야 한다. bias $\beta$를 더해서 $\widetilde{net}$을 만들 후에 이를 activation function에 집어넣는다.

![image](https://user-images.githubusercontent.com/61526722/120917230-00523800-c6e9-11eb-93aa-ccccd067182f.png)

따라서 아래와 같이 summation과 activation function 사이에 BN를 삽입하여 훈련을 진행한다.

![image](https://user-images.githubusercontent.com/61526722/120917717-ac951e00-c6eb-11eb-97f2-1a92645240b3.png)

여러 개의 노드에서 작동하는 것으로 바꿔보면 아래와 같다. 여기서 주목해야 할 것은 batch normalization을 하려면 각 노드에서의 net값들을 다 알아야하기 때문에 모든 net값들을 기억하고 있어야 한다. 저장할 공간이 필요하다는 것이므로 사용하는 메모리가 늘어나고 계산량이 많아진다는 단점이 있다. 이런 것을 생각하면 BN이 결코 학습을 빠르게 해주는 것이 아니라고 생각할 수 있다. 하지만 한번 학습하는데 메모리와 계산량이 많아지는 것이지 학습 자체는 더 적게 해도 되기 때문에 전체적 관점에서 학습이 더 빨라진다. 

![image](https://user-images.githubusercontent.com/61526722/120919617-7f4d6d80-c6f5-11eb-82fd-95474e998166.png)

여기서 하나 더, training 할 때는 data가 많아서 mini-batch로 나누어 학습을 진행했지만 test 할때는 배치가 없다. z-transformaion을 할 때 batch의 평균 분산을 사용하는데 test는 하나씩 진행하므로 평균과 분산이 존재하지 않는다. 그래서 training data와 test data의 분포가 같다는 가정하에 training set의 평균과 분산을 기억해두었다가 test 할 때 사용한다. 아래 그림의 수식처럼 training set에서 각 batch들에 대해 평균의 평균과 분산의 평균을 구해 test할 때 BN을 시행한다. 

![image](https://user-images.githubusercontent.com/61526722/120919881-e7508380-c6f6-11eb-9800-c0ae8eaa5144.png)

#### Batch Normalization의 장점

![image](https://user-images.githubusercontent.com/61526722/120920149-61353c80-c6f8-11eb-9883-d9d10ef96a33.png)

- internal covariant shift를 없애서 학습을 더 빠르게 한다.
- 큰 learning rate 값을 사용할 수 있어 학습을 더 빠르게 한다. 
BN을 사용하면 E의 w에 대한 민감도가 감소한다. E(w) = E(2w). w가 바뀌어도 E값이 크게 바뀌지 않으므로 smooth한 loss function을 만든다. 들쑥날쑥한 loss function에서는 learning rate을 작게하여 콩콩콩 내려가야 한다면 smooth 한 loss function에서는 큰 learning rate를 사용하여 크게크게 내려갈 수 있는 것이다. 

#### Batch Normalization의 단점

- 메모리와 시간이 더 많이 걸린다.
- batch size가 작을 때는 net 값의 평균과 분산이 unstable하게 나오게 되고 batch마다 너무 큰 편차가 생겨 문제가 생긴다.
- RNN에 적용하기 곤란하다. RNN의 구조가 가지고 있는 semantic이 BN이 가지고 있는 semantic과 달라서 학습이 잘 되지 않는다.
- (미리 말을 하면 위 문제점들을 해결하기 위해 layer normalization 기법을 사용한다.) 

---

