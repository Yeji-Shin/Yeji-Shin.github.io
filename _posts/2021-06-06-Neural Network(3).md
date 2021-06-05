---
layout: post
title: Neural Network(3)
date: 2021-06-06
category: DeepLearning
use_math: true
---

이번에는 문제 상황에 따라 어떻게 neural network 구조를 설계해야 하는지 살펴본다. 

---

### 1. Regression

Regression은 회귀모델로 input 값을 가지고 real number를 output으로 낸다. Regression은 가질 수 있는 값의 범위가 엄청 넓기 때문에 output layer는 activation 함수를 사용하지 않고 summation 값을 그냥 출력한다. 이는 activation function으로 $y=net$(linear function)을 사용한다고 봐도 된다. 여기서 주의할 점은 output layer의 activation function만 $y=net$을 사용하는 것이지 hidden layer의 activation function을 $y=net$로 하면 안된다. NN의 non-linear transformation이 무너지기 때문이다. 이는 굳이 NN을 multilayer로 가져갈 필요가 없다는 의미이기도 하다.

![image](https://user-images.githubusercontent.com/61526722/120893628-40fd7300-c64f-11eb-9b9a-d6ac2068cd18.png)

Regression의 경우는 output layer를 non-linear transformation의 목적으로 사용하는 것이 아니라 non-linear transform된 값들을 가지고 최종 결과를 얻어내는, 다시 말해 임의의 범위 안의 값들을 얻어내기 위해서만 사용한다. 

정리하면 regression을 하려면 output layer에 linear activation을 사용하거나 activation function을 사용하지 않아도 된다. 

---

### 2. Binary-class Classification

![image](https://user-images.githubusercontent.com/61526722/120893958-d0efec80-c650-11eb-8795-7fd2b3c0bc94.png)


classification에서 우리가 얻고 싶은 정보는 숫자가 아닌 class 값(nominal values:이름값)이다. 여기서 첫 번째 문제는 NN은 real number만 다룰수 있다는 것, 두 번째 문제는 error function으로 MSE를 사용해서 학습시켜도 되는지 이다.

+ Handling nominal value

Binary class이므로 calss값을 0과 1로 바꾸고 학습시키면 된다. 그리고 output layer의 activation function은 sigmoid를 사용하면 된다. Sigmoid 함수는 한 쪽 극단이 1이고 한쪽 극단이 0의 값을 가지기 때문이다. 

![image](https://user-images.githubusercontent.com/61526722/120893947-c2a1d080-c650-11eb-9370-f37e1103c485.png)


+ Error function for traning

Sigmoid 활성화 함수와 MSE error function을 함께 사용하는 것은 사용하지 않는게 좋다. 이론상으로는 학습이 잘 될것 같지만 그렇지 않은 경우가 생기기 때문이다.  

### 3. Multi-class Classification

### 4. Multi-label Classification

### 5. Nominal Input

