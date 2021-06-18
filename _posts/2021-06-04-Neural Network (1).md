---
layout: post
title: Neural Network (1)
date: 2021-06-04
category: DeepLearning
use_math: true
---

이번에는 neural network의 탄생, 어떤 구조를 가지고 있는지, 어떤 기능을 하는지 등 neural network에 대한 전반적이 이야기를 해볼 것이다. 

---

### 0. Neural Network의 탄생

Neural network는 뉴런들의 네트워크로 인간의 두뇌를 모방한 인공두뇌를 만들기 위해 고안되었다.

대충 1950년도까지 인간의 두뇌에 대해서 알게 된 사실은 다음과 같다.

- 머리 속의 수많은 뇌세포(뉴런)들은 서로 연결되어 있다. 

- 각 연결에는 연결의 강도가 존재하는데 이는 가변적이다.

- 연결 강도가 바뀜으로 인해서 머리속에 저장되는 값이 바뀐다. 

이 사실을 토대로 인공두뇌를 만들기 시작했고, 이것이 바로 neural network 연구의 시작이다.

![image](https://user-images.githubusercontent.com/61526722/120663405-f4862c00-c4c4-11eb-8a01-c45e00051be1.png)

현재는 많은 neural network 중에 multilayer perceptron (MLP)이라는 구조를 사용하고 있다.

---

### 1. Perceptron: artificial neuron


퍼셉트론은 인공뉴런 한개를 일컫는다. 

뉴런은 받은 <mark>시그널을 흡수</mark>하다가 특정 threshold를 넘으면 <mark>모아놨던 시그널들을 다음 뉴런으로 전달</mark>한다. 아래 그림은 간단한 binary 뉴런 구조이다.

![image](https://user-images.githubusercontent.com/61526722/120666627-b4747880-c4c7-11eb-9d9c-f36d711ee57a.png)

뉴런이 하는 일은 두 가지이다. 간단하게 신호를 받고, 신호를 출력하는 것이라고 보면 된다.


#### step1: Linear combination of inputs

받은 각 시그널들에 해당되는 연결의 강도(connection weight)를 곱해서 weighted summation을 구한다.

Connection weight는 scale factor로 이해하면 된다. Connection weight이 크다는 것은 시그널이 잘 전달된다는 것이고, 작으면 시그널이 잘 전달되지 않는다고 할 수 있기 때문이다.

#### step2: Nonlinear transformation of s

Weighted summation(s)을 보고 출력을 낼지 말지 결정하는 단계이다. s가 어느 정도를 넘으면 시그널을 방출한다. 위의 예에서는 s>0이면 1을 출력, 아니면 -1을 출력한다. $f$는 <mark>activation function</mark>이라고 한다.


이런 뉴런들이 마구마구 연결되어 있는 것이 neural network이다.

---

### 2. Limitation of Perceptron

#### 퍼셉트론(뉴런 한개)이 할 수 있는 일? 

<mark>linearly seperable한 문제를 푼다</mark>

![image](https://user-images.githubusercontent.com/61526722/120671007-eb4c8d80-c4cb-11eb-907c-8a38c4ba16b0.png)
![image](https://user-images.githubusercontent.com/61526722/120671016-ed165100-c4cb-11eb-8ad4-8e71378c1d57.png)

$w_{1},w_{2},w_{3}$는 어떤 경계를 의미하고, 이 경계보다 위쪽에 있는 점이 들어오면 1을 출력하고 아래쪽에 있는 점이 들어오면 0을 출력한다. 즉, linearly seperable한 AND operation이나 OR operation을 만들 수 있다.

여기서 1은 bias로, bias가 없다면 원점을 지나는 직선만을 만들 수 있다. 따라서 bias은 뉴런이 표현할 수 있는 경계에 큰 자유도를 기여하여 반드시 있어야 한다고 생각하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/120671752-a70dbd00-c4cc-11eb-8b3b-83201f779132.png)

AND operation은 아래 세점과 위의 한점을 나누도록 직선을 그어주는 w를 찾으면 된다.

![image](https://user-images.githubusercontent.com/61526722/120671764-aaa14400-c4cc-11eb-99fe-3343b02c7faa.png)

OR operation은 아래 한점과 위의 세점을 나누도록 직선을 그어주는 w를 찾으면 된다.

이 때 AND와 OR 게이트는 connection weight만 바뀐다. 따라서 뉴런은 하드웨어라고 할 수 있고, 실제로 그 하드웨어의 기능을 정의하는 것은 connection weight이다. Connection weight이 바뀌면 neural network의 기능이 바뀌는 것이다. neural network의 핵심은 connection weight를 어떻게 설정하냐는 것이고 이 connection weight를 자동으로 설정하는 과정을 학습이라고 한다.

#### 퍼셉트론의 한계
 - 퍼셉트론은 하나의 output을 내기 때문에 binary problem에만 적용가능하다.
 - 퍼셉트론은 linear machine(직선 하나로 분류해주는 분류기)이기 때문에 linear problem만 해결 가능하다.
 - 퍼셉트론은 vector만 input으로 사용할 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120883403-eb59a400-c617-11eb-9a1d-23884d9d1a03.png)

사람들은 이를 극복하고 non-linear separable한 문제를 해결하기 위해 퍼셉트론 마구마구 연결한 neural network를 사용하기 시작했다.

_(참고) linear machine의 non-separability 문제를 해결할 수 있는 방법은 여러가지가 있다. Support Vector Machine(SVM)을 사용하는 방법, non-linear feautrue를 input으로 사용하는 방법, non-linear kernel들은 hidden layer에 추가하는 방법._

---

### 3. Perceptron Learning Algorithm (PLA)

Neural network에서 connection weight에 따라 NN의 기능이 달라진다고 했다. 이 connection weight를 설정하는 과정 즉, NN을 학습시키는 과정은 다음과 같다. 주입식 교육으로 학습데이터를 주면서 외우라고 시키는게 퍼셉트론 학습 방식이다.

![image](https://user-images.githubusercontent.com/61526722/120885917-5f9b4400-c626-11eb-838f-ab81ad45638b.png)

#### step1: Initialize connection wwights

Input-ouput 쌍을 가진 학습 데이터와 사용할 neural network 구조를 준비한다. 그리고 neural network의 weight를 랜덤하게 intialization 한다.

#### step2: Update connection weigths

이제 모든 학습 데이터에 대해 input을 차례대로 NN에 통과시켜 예측값을 추출한다. 이 예측값과 훈련 데이터의 실제 output 값과 비교한다. 틀린 샘플이 w값을 업데이트 한다.

![image](https://user-images.githubusercontent.com/61526722/120886093-1d263700-c627-11eb-9240-eec9537434f3.png)
![image](https://user-images.githubusercontent.com/61526722/120886048-e51ef400-c626-11eb-93e8-527509c712ed.png)

#### step3: Execute the algorithm until not encountering mistakes

퍼셉트론은 모든 학습 데이터를 정확히 분류할 때까지 학습이 진행된다.


---

### 4. Neural Network

#### Neural network가 할 수 있는 일? 

<mark>non-linearly seperable한 문제를 푼다.</mark> digital circuit(cpu)를 만든다. 이론적으로 digital computer가 하는 모든 일을 할 수 있다.
 
Non-linear separable 문제에는 대표적으로 exclusive OR (XOR)가 있다.

![image](https://user-images.githubusercontent.com/61526722/120882984-b0567100-c615-11eb-91bf-19d719addb8c.png)

XOR 문제는 곡선으로 경계를 그려야 하기 때문에 퍼셉트론이 해결하지 못한다. 하지만 Neural network는 아래와 같은 방법으로 XOR 문제를 해결할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/120883970-50fb5f80-c61b-11eb-8138-2144d6612add.png)

첫 번째 뉴런은 AND 게이트 처럼 동작하고, 두 번째 뉴런은 OR 게이트 처럼 동작하게 구성한다. 

![image](https://user-images.githubusercontent.com/61526722/120883914-f8c45d80-c61a-11eb-8de4-bab892e277b6.png)

이처럼 XOR문제는 세 개의 연결하여 해결할 수 있다. 하지만 이보다 더 복잡한 문제가 나왔을 때, 더 많은 뉴런들을 연결하여 해결해야 하는 문제를 풀 때는 connection weight를 찾는 과정이 너무 복잡해진다. 예상컨대 case by case로 머리 터져라 고민해도 적절한 connection weight를 못찾는 경우가 허다할 것이다. 그럼 과연 neural network의 connection weight를 설정하는 일반적인 알고리즘이 존재하냐? 1985년 까지는 존재하지 않았다. 내가 특정 neural network를 주면서 이런 일을 하고 싶어요 connection weight를 좀 설정해주세요 했을때 잠깐만 기다려 주세요 하고 바로 설정해줄 수 있는 그런 학습 알고리즘이 존재하지 않았던 것이다. 이 때문에 1969년부터 1985년도까지 neural network가 전혀 사용되지 않았다. 이를 AI winter 시기(NN의 1차 암흑기) 라고 한다. 1985년도에  **Error Back Propagation** 이라는 connection weight 설정방법이 등장하면서 AI는 다시 부흥기를 맞게 되는데 Error Back Propagation을 설명하기 이전에 neural network의 구조를 한번 살펴보기로 한다. 

---

### 5. Multilayer Perceptron (MLP)

Neural network는 퍼셉트론을 여러개 연결한 것이라고 했다. Neural network의 한가지 종류인 **Multilayer Perceptron (MLP)** 는 feed-forward neutral network라고도 불리며 현재 딥러닝에서 사용되는 구조이다. 여기서 feed forward라는 것을 앞에서 뒤로만 신호를 전달한다는 뜻이다. MLP가 feed forward 구조를 가지고 있는 이유는 만약 backward loop가 중간에 존재하면 학습이 불안정해지기 때문이다. 아래는 2-layer MLP의 구조를 도식화한 그림이다. (입력은 layer로 안침)

![image](https://user-images.githubusercontent.com/61526722/120883711-b4848d80-c619-11eb-925c-d2b4c459b62a.png)

MLP는 전체적으로 layer 구조를 가지며 input layer, hidden layer, output layer로 구성된다. 

Input layer의 뉴런(노드) 개수와 output layer의 뉴런(노드) 개수는 우리가 풀어야하는 문제가 결정한다. 예를 들어 256x256 사이즈의 이미지를 보고 개와 고양이를 구분하는 NN을 만든다면 input의 개수는 65536개, 그리고 output의 개수는 1개(0 또는 1)가 된다.

이에 반해 Hidden layer의 노드 개수는 우리가 마음대로 결정하는 것이다. 간단하게 생각하면 문제가 어렵다고 생각되면 노드를 많이 사용하면 되고, 쉬운 문제에는 노드를 적게 사용하면 된다. 그렇다고 너무 많은 노드를 쓰면 문제를 더 못풀게 되니 적당히 잘 설정해야 한다. (MIT 공대 졸업한 사람을 데려다가 산수 풀게 하면 이렇게 해볼까 저렇게 해볼까 하다가 시간만 더 오래 걸리고 망하는 경우라고 보면 됨..) 같은 맥락으로 hidden layer의 개수도 우리가 재량으로 정할 수 있는데 어려운 문제에는 hidden layer를 많이 사용하면 되고, 쉬운 문제에는 hidden layer를 적게 사용하면 된다. 이 때 layer를 많이 까는게 노드를 많이 까는 것 보다 좋다고 한다.

재밌는 것은 이론적 관점에서 2-layer MLP는 어떤 연속 함수 문제를 풀 수 있고, 3-layer MLP는 어떠한 함수 문제를 풀 수 있다고 한다.

---

다음 에는 neural network의 학습 알고리즘인 Error Back Propagation에 대해서 살펴볼 것이다.

