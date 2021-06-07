---
layout: post
title: Convolutional Neural Networks Basics
date: 2021-06-09
category: DeepLearning
use_math: true
---

지금까지 DNN에 대해 알아보았다. 이번에는 Convolutional Neural Networks (CNN)에 대해 살펴본다.

---

### 1. Convolutional Neural Networks (CNN)

![image](https://user-images.githubusercontent.com/61526722/121026268-ee53c080-c7e0-11eb-85bf-ed6c55d3714a.png)

CNN은 FC와 달리 layer간 모든 노드가 연결되어 있지 않은 partially connected 구조이다. 같은 색상은 같은 connection weight를 가져야 한다. 
CNN은 보통 이미지, 음성, 텍스트 등의 sequential data를 처리하는데 사용된다. Sequential data는 값 뿐만 아니라 값이 나타난 위치까지 중요하게 생각한다.
이미지도 pixel이 어느 위치에 있는지가 중요하기 때문에 sequential data다.

#### convolution이란?

Convolution은 NN과 상관없이 이미지 처리에서 많이 사용하던 행렬 연산이다. 이 convolution과 NN이 만나서 만들어진 것이 CNN이다. 

![image](https://user-images.githubusercontent.com/61526722/121027112-abdeb380-c7e1-11eb-9c92-c4d076023fbb.png)

예를 들어 위와 같이 X와 O를 구분하는 classifier를 만든다고 하자. 하지만 이를 코드로 구현하기가 힘들다. 
따라서 쉽게 local feature들을 찾아내고 그 local feature들 끼리 매칭하여 같은 그림인지 아닌지 구분하는 방법을 사용하기로 한다. 
다시말해서 pixel by pixel로 비교하면 두 그림은 같지 않지만 local feature들의 상대적 위치를 기준으로 비슷하다고 판단한다. 

![image](https://user-images.githubusercontent.com/61526722/121027700-23acde00-c7e2-11eb-8281-55506f5606f1.png)

그러면 이제 어떻게 local feature 들을 찾아낼 것인가? convolution을 사용하여 찾아내면 된다. 

---

### 2. Feature Extraction with Convolution

방금 전에 convolution은 local feature들을 찾기 위한 연산이라고 했다. 그러면 convolution은 어떻게 동작할까. 

![image](https://user-images.githubusercontent.com/61526722/121030460-75566800-c7e4-11eb-9fe0-15c0b3f0e801.png)

![image](https://user-images.githubusercontent.com/61526722/121030929-e269fd80-c7e4-11eb-8e3f-8dc7a2fe0655.png)

convolution은 두 행렬을 element-wise하게 곱해주어 summation을 하면 된다. 이는 NN에서 net값을 구해서 summation하는 것과 비슷하다.

#### Two-Dimensional Convolution

![image](https://user-images.githubusercontent.com/61526722/121029211-61f6cd00-c7e3-11eb-9f03-dac964143f5d.png)

![image](https://user-images.githubusercontent.com/61526722/121029597-af733a00-c7e3-11eb-8d00-61fac6885b81.png)

![image](https://user-images.githubusercontent.com/61526722/121029646-bc902900-c7e3-11eb-9c2b-33f3da91ea57.png)

convolution은 이미지라고 불리는 큰 행렬과 filter라고 불리는 작은 행렬을 입력으로 받아서 행렬을 output으로 출력한다. 
이때 마지막 결과에서 행렬의 테두리가 빈칸이 되는데 filter size가 3이면 한칸씩 빠져나가고, 5면 2줄씩 비게 된다.
이렇게 행렬 사이즈가 바뀌는 것을 방지하지 위해 이미지 행렬의 테두리에 0을 추가해준다. 이를 zero-padding이라고 부른다.

![image](https://user-images.githubusercontent.com/61526722/121030245-45a76000-c7e4-11eb-9c76-ac5914bd65b1.png)

그러면 초기의 입력값의 사이즈를 유지한 상태로 결과가 나오게 된다. 이제 output으로 나온 결과의 의미를 한번 살펴보자.
output 값은 filter라고 불리는 작은 행렬의 값에 따라 달라지며 <mark>filter는 우리가 찾고자 하는 local feature의 definition</mark>이라고 할 수 있다.
따라서 정의된 local feature가 강하게 나타나는 부분에서는 큰 양수값을 output으로 낸다. 
반대로 큰 음수값을 내는 부분은 local feature가 전혀 나타나고 있는 지점이 아니다라고 해석 가능하다.
즉, <mark>convolution output</mark>은 local feature가 원래 이미지의 어느 부분에서 나타나고 있는지 알려주는 <mark>feature map</mark>이라고 할 수 있다. 


이 때 local feature가 강하게 나타나는 부분이 중요하므로 feature map의 음수값은 모두 0으로 바꿔준다. 음수도 어짜피 없는 거니깐 바꿔도 상관없다. 

![image](https://user-images.githubusercontent.com/61526722/121032753-87390a80-c7e6-11eb-92cd-5c8d4c2f9b8e.png)

이렇게 변하는 음수는 0으로 양수는 그대로 양수로 두는 연산은 ReLU에서 보던 연산이다. 
즉, 두 행렬의 element-wise하게 곱해주어 summation 하는 것과 음수값을 0으로 바꿔주는 과정을 NN에서 보던 net을 구하고 ReLU를 적용하는 것과 많이 비슷하여 
convolution 과 NN이 혼합될 수 있는 것이다.

#### Three-Dimensional Convolution

우리는 RGB 컬러 이미지를 사용한다. 이에 맞는 convoltion은 다음과 같이 진행된다. 
R채널에 있는 local feature를 찾아내고, G채널에 있는 local feature를 찾아내고, B채널에 있는 local feature를 찾아내고

![image](https://user-images.githubusercontent.com/61526722/121033509-3970d200-c7e7-11eb-9d38-4b9ebd0102e2.png)

![image](https://user-images.githubusercontent.com/61526722/121034090-b603b080-c7e7-11eb-8f67-20b55e1990d4.png)


<mark>입력 이미지의 channel 수는 filter의 channel수는 동일</mark>해야 하기 때문에 RGB이미지가 들어가면 filter의 channel 수도 3이 되어야 한다.
이 때 착각하지 말아야 하는 것이 filter의 개수는 1개이다. RGB 3 channel이 있어도 하나의 이미지라고 하는 것과 같다. 



