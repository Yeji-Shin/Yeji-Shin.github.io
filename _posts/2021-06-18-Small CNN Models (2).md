---
layout: post
title: Small CNN Models (2)
date: 2021-06-18
category: DeepLearning
use_math: true
---

이번에는 EfficientNet (2019)에 대해서 알아볼 것이다. EfficientNet는 성능이 좋은 CNN 모델을 만든다고 알려져있다. 이제  EfficientNet이 무엇인지 살펴보자. 

---

### 1. Scale Up

요즘의 CNN 구조를 보면 base block들을 정의해 놓고, 그 base block들을 반복하여 사용함으로써 NN을 deep하게 만든다. 기본 블록들의 반복횟수를 조절하는 것도 있지만 이미지의 크기나 채널의 수를 조정하면서 훨씬 더 좋은 CNN을 만들어내는 것이 요즘의 트렌드이다. Conv를 더 많이 사용하는 것은 더 좋은 accuracy를 가지는 모델을 만들기 위함이고 GPipe 모델은 베이스모델을 4번 반복하여 ImageNet에서 1등을 달성하기도 했다. 

CNN의 구조를 변경할 때는 <mark>layer의 개수(depth), 채널의 개수(width), 입력 이미지의 크기(resolution)</mark> 세 가지를 scaling up할 수 있다. EfficientNet의 depth, width, resolution을 각각 몇 배만큼 키워야 성능향상은 최대로 하면서 계산량을 최소로 증가시킬수 있는지 조합을 찾아내는 연구에 대한 논문이다. 즉, 가성비 높은 모델을 어떻게 base 모델로부터 만들어낼것인가에 대한 연구이다. 

![image](https://user-images.githubusercontent.com/61526722/122083323-bc270c00-ce3b-11eb-9553-85291ee94df5.png)

만약 depth를 늘리면 훨씬 더 복잡한 feature들을 뽑아낼 수 있다. 깊어진다는 얘기는 non-linearity가 훨씬 더 높아지고 feature들이 더 섞일 기회를 주는 것이기 때문이다. 한 conv layer에서 채널의 개수를 늘린다면 더 다양한 패턴들을 뽑아낼 수 있다. 채널이 늘어난다는 것은 filter의 개수가 늘어나는 것이고 filter의 개수가 늘어난다는 것은 다양한 패턴을 뽑아낼수 있다는 것이다. 입력 이미지의 크기를 키우는 것은 해상도가 높아지는 것이므로 더 좋은 패턴을 뽑아낼 수 있게 된다. 

---

### 2. Difficuties of Scale Up

따라서 우리가 depth, width, resolution을 잘 증가시키면 base model로 부터 아주 손쉽게 성능좋은 모델을 만들 수 있지만 문제가 있다. depth, width, resolution을 계속 증가시키면 성능은 올라가지만 정비례하지 않고 <mark>saturation</mark> 된다. 왼쪽부터 depth, width, resolution을 변경할 때 성능을 그래프로 그린것이다. 보면 어느 순간 성능의 향상이 멈추는 것을 알 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/122083892-3f486200-ce3c-11eb-8128-79a337c021a4.png)

또한 depth, width, resolution가 크면 무조건 좋아지기는 하겠지만 가성비를 따지면 녹색 선이 가장 좋아보이는 것과 같이 depth, width, resolution의 밸런스가 필요하다. 

![image](https://user-images.githubusercontent.com/61526722/122084398-c09ff480-ce3c-11eb-97d2-167cfa941f7c.png)

그렇다면 depth, width, resolution의 아주 좋은 비율을 찾아내는 방법은 무엇일까. 

---

### 3. Idea for Best Compound Scaling

EfficientNet에서는 이 세개의 비율을 수학적으로 관계를 찾아내는 것은 아니고 trial and error로 비율을 찾아내는 방법을 제안한다. 이론적인 논문보다는 가정과 가설에 기반한 실험에 기반한 결과에 대한 논문이다. 가장 좋은 scaling factor를 고르는 방법은 다음과 같다. 


#### Step 1: Find out a good baseline model

새로운 모델을 구상할 수도 있고 있던걸 가져와도 좋으니 베이스 모델 하나를 고른다. 

#### Step 2: Find out the golden ratio of width, depth and resolution for scaling

scaling을 하기 위한 가장 좋은 width, depth and resolution 비율을 찾아낸다. 

![image](https://user-images.githubusercontent.com/61526722/122086646-df06ef80-ce3e-11eb-952f-95a745a85121.png)

위 수식은 베이스 모델을 scaling 해서 생긴 새로운 NN의 accuracy를 최대화하는 depth, width, resolution 찾아내라는 말이다. 그리고 메모리와 flop에 대한 제약조건을 걸어서 이 문제를 풀면 가성비 높은 모델을 찾아낸다. 이 문제를 풀기 위해서 가설을 하나 세운다. <mark>베이스 모델에 비해서 계산량이 딱 두배인 네트워크를 만든다는 가설</mark>이다. 계산량이 딱 두배인 네트워크 중에서 가장 성능이 좋은 모델을 찾으면 된다. 

여기서 depth, width, resolution를 $\alpha, \beta, \gamma$ 배씩 늘리면 계산량은 $\alpha, \beta^{2}, \gamma^{2}$ 늘어난다고 한다. 따라서 $\alpha * \beta^{2} * \gamma^{2}  \approx 2$ 가 되는 조건하에서 성능이 가장 좋은 비율을 찾아내야 한다.  EfficientNet에서 그리드 서치로 좋은 비율을 찾아냈다고 한다. 

#### Step 3: Scaling up each dimension of the baseline model keeping the golden ratio of width, depth and resolution

그 비율을 유지하면서 베이스 모델의 차원을 증가시킨다. 

$ \phi$ 를 정의해서 $w=\alpha^{\phi}, d=\beta^{\phi}, r=\gamma^{\phi}$ 으로 width, depth and resolution를 조정한다. $\phi$가 1이면 계산량은 2배가 되고, $\phi$가 2이면 계산량은 4배가 된다. 이렇게 $\phi$만 조절해서 여러개의 NN을 만들어낸다. 

![image](https://user-images.githubusercontent.com/61526722/122089768-1034ef00-ce42-11eb-80db-6fc56ce19d2b.png)

MobileNet과 ResNet을 베이스모델로 해서 실험한 결과는 아래와 같다고 한다. 

![image](https://user-images.githubusercontent.com/61526722/122090181-74f04980-ce42-11eb-95f1-54edb6765f08.png)

---

정리하면 EfficientNet은 베이스 모델의 depth, width, resolution을 일정한 비율로 증가시켜 가성비가 좋은 모델을 만드는 방법이다. 











