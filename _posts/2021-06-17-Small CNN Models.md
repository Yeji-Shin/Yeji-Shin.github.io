---
layout: post
title: Small CNN Models
date: 2021-06-17
category: DeepLearning
use_math: true
---

앞에서 학습했던 CNN 모델들은 상당히 학습 파라미터의 양도 많고 계산량도 많다. 지금까지는 사람들은 accuracy를 높이는 방향으로 상당히 큰 CNN 모델들을 사용했는데, 이번에는 약간 다른 방향으로 모바일 환경에서도 사용할 수 있는 상대적으로 작은 경량화된 CNN 모델을 만들어보고자 했다. 이 작고 경량화된 CNN 모델이 Small CNN 모델이다. Accuracy를 약간은 손해보고 계산량을 줄이는 방식이라고 할 수 있다. 물론 최종목표는 accuracy의 손해 없이 CNN을 경량화시키는 것이다. 

---

### 1. Huddles against Small Networks

CNN을 small network로 만들 때 고려해야 하는 것은 <mark>fully connected layer</mark>이다. FC layer는 학습 파라미터의 양이 굉장히 많다. 아래 모델에서 FC layer바로 앞부분에 13x13x256x4096개의 connection이 존재한다. 다음 부분에서는 4096x4096개, 다음은 4096x1000개의 connection이 존재한다. 

![image](https://user-images.githubusercontent.com/61526722/122007938-73e3fb80-cdf3-11eb-957c-7f9bac25b94b.png)

다음으로 small CNN을 만들 때 고려해야 할 것은 <mark>filter의 크기</mark>이다. 빨간색 부분에서 filter에 들어가는 학습 파라미터의 개수는 3x3x384x384 이다. 이때의 operation 개수는 학습 파라미터의 개수에 feature map의 크기를 곱한 3x3x384x384x13x13 개 이다.

![image](https://user-images.githubusercontent.com/61526722/122008667-45b2eb80-cdf4-11eb-9c32-4d9cd049ef44.png)

따라서 경량화된 CNN을 만들기 위해서는 어떻게 convolution 연산을 줄인것인가와 dense layer를 어떻게 줄일것인가가 중요하다. '

---

### 2. MobileNet-v1

Convolution을 경량화 시키기 위해 Depthwise Separable Conv를 제안했다. 

![image](https://user-images.githubusercontent.com/61526722/122011767-6cbeec80-cdf7-11eb-9b7c-43464b145be3.png)






















