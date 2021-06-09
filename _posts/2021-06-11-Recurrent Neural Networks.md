---
layout: post
title: Recurrent Neural Networks 
date: 2021-06-10
category: DeepLearning
use_math: true
---

이번에는 Recurrent Neural Networks (RNN)의 기본 개념을 알아볼 것이다.

RNN은 <mark>sequential data 처리</mark>에 적합한 모델이다. speech, text, image 가 모두 sequential data이며 나타났는지 안나타났는지가 중요한것이 아니고
데이터가 나타난 위치가 중요한 데이터이다. 즉, 순서가 있는 데이터가 sequential data이다. 이미지 같은 경우는 어떻게 순서가 있는지 의문을 가질수도 있다.
예를 들어 고양이 이미지를 픽셀단위로 잘라 뒤죽박죽으로 해놓으면 우리는 이게 고양이인지 모를 것이다. 

---

### 1. Recurrent Neural Networks (RNN)

RNN은 fully connected NN 밑에 혹 하나가 붙어있는 구조이다. 

![image](https://user-images.githubusercontent.com/61526722/121352459-da869680-c967-11eb-919f-06c2080a6a28.png)

$c_{1},c_{2}...,c_{k}$는 hidden node의 값을 저장하는 메모리 버퍼이다.  

![image](https://user-images.githubusercontent.com/61526722/121353193-8b8d3100-c968-11eb-98cd-11b2c83e011b.png)

![image](https://user-images.githubusercontent.com/61526722/121352878-410bb480-c968-11eb-8104-10231af80b9c.png)

hidden node에서 계산된 값은 다음 layer로 전달되는 동시에 이 메모리 버퍼에도 복사되어 저장된다. input이 output node까지 전달되어도 이 버퍼에는 값이 남아있다. 
