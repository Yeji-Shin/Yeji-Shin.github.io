---
layout: post
title: Neural Network(1)
date: 2021-06-04
category: DeepLearning
use_math: true
---

### 1. Neural Network

Neural network 뉴런들의 네트워크로 인간의 두뇌를 모방한 인공두뇌를 만들기 위해 고안되었다.

대충 1950년도까지 인간의 두뇌에 대해서 알게 된 사실은 다음과 같다.

- 머리 속의 수많은 뇌세포(뉴런)들은 서로 연결되어 있다. 

- 각 연결에는 연결의 강도가 존재하는데 이는 가변적이다.

- 연결 강도가 바뀜으로 인해서 머리속에 저장되는 값이 바뀐다. 

이 사실을 토대로 인공두뇌를 만들기 시작했고, 이것이 바로 neural network 연구의 시작이다.

![image](https://user-images.githubusercontent.com/61526722/120663405-f4862c00-c4c4-11eb-8a01-c45e00051be1.png)

현재는 많은 neural network 중에 multilayer perceptron이라는 구조를 사용하고 있다.

---

### 2. Perceptron: artificial neuron

퍼셉트론은 인공뉴런 한개를 일컫는다. 

뉴런은 받은 <mark>시그널을 흡수</mark>하다가 특정 threshold를 넘으면 <mark>모아놨던 시그널들을 다음 뉴런으로 전달</mark>한다. 아래 그림은 간단한 binary 뉴런 구조이다.

![image](https://user-images.githubusercontent.com/61526722/120666627-b4747880-c4c7-11eb-9d9c-f36d711ee57a.png)

뉴런이 하는 일은 두 가지이다. 간단하게 신호를 받고, 신호를 출력하는 것이라고 보면 된다.

**step1: Linear combination of inputs**

받은 각 시그널들에 해당되는 연결의 강도(connection weight)를 곱해서 weighted summation을 구한다.

Connection weight는 scale factor로 이해하면 된다. Connection weight이 크다는 것은 시그널이 잘 전달된다는 것이고, 작으면 시그널이 잘 전달되지 않는다고 할 수 있기 때문이다.

**step2: Nonlinear transformation of s**

Weighted summation(s)을 보고 출력을 낼지 말지 결정하는 단계이다. s가 어느 정도를 넘으면 시그널을 방출한다. 위의 예에서는 s>0이면 1을 출력, 아니면 -1을 출력한다. $f$는 activation function이라고 한다.

이런 뉴런들이 마구마구 연결되어 있는 것이 neural network이다.

---

### 3. Perceptron vs Neural Network

퍼셉트론(뉴런 한개)이 할 수 있는 일? <mark>linearly seperable한 문제를 푼다</mark>

![image](https://user-images.githubusercontent.com/61526722/120671007-eb4c8d80-c4cb-11eb-907c-8a38c4ba16b0.png)
![image](https://user-images.githubusercontent.com/61526722/120671016-ed165100-c4cb-11eb-8ad4-8e71378c1d57.png)

$w_{1},w_{2},w_{3}$는 어떤 경계를 의미하고, 이 경계보다 위쪽에 있는 점이 들어오면 1을 출력하고 아래쪽에 있는 점이 들어오면 0을 출력한다. 즉, linearly seperable한 AND operation이나 OR operation을 만들 수 있다.

![image](https://user-images.githubusercontent.com/61526722/120671752-a70dbd00-c4cc-11eb-8b3b-83201f779132.png)

AND operation은 아래 세점과 위의 한점을 나누도록 직선을 그어주는 w를 찾으면 된다.

![image](https://user-images.githubusercontent.com/61526722/120671764-aaa14400-c4cc-11eb-99fe-3343b02c7faa.png)

OR operation은 아래 한점과 위의 세점을 나누도록 직선을 그어주는 w를 찾으면 된다.

이 때 AND와 OR 게이트는 connection weight만 바뀐다. 따라서 뉴런은 하드웨어라고 할 수 있고, 실제로 그 하드웨어의 기능을 정의하는 것은 connection weight이다. Connection weight이 바뀌면 neural network의 기능이 바뀌는 것이다. neural network의 핵심은 connection weight를 어떻게 설정하냐는 것이고 이 connection weight를 자동으로 설정하는 과정을 학습이라고 한다.

neural network가 할 수 있는 일? digital circuit(cpu)를 만든다. 이론적으로 digital computer가 하는 모든 일을 할 수 있다.

---

### 4. Multilayer Perceptron (MLP)

