---
layout: post
title: Adversarial Attacks
date: 2021-06-27
category: DeepLearning
use_math: true
---

이번에는 NN의 취약성이 무엇인지 그것을 어떻게 극복할 것인지에 대해 공부한다.  

---

### 1. Adversarial Attack

Adversarial attack은 특정 노이즈를 인풋에 넣었을 때 NN은 엉뚱한 대답을 하는 현상이다. 
아래 그림과 같이 팬더 이미지에 특정 노이즈를 주었을 때 나오는 그림은 사람이 보기에는 팬더이지만 컴퓨터가 볼 때는 긴팔원숭이로 판단한다는 것이 대표적이 예시이다. 
