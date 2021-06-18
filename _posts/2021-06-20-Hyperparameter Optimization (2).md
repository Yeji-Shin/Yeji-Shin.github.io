---
layout: post
title: Hyperparameter Optimization (1)
date: 2021-06-20
category: DeepLearning
use_math: true
---

Bayesian optimization 기법은 hyperparameter optimization 문제를 해결하는 가장 일찍 제안된 기법이다. Bayesian optimization의 기본 아이디어는 알고 있는 데이터를 사용해 함수를 예측하고, 예측한 함수로 부터 다음으로 조사해야할 지점을 선택하고, 조사한 결과를 바탕으로 함수를 다시 예측하는 과정을 반복하면서 점점 더 좋은 지점으로 접근해가는 것이라고 했다. 함수를 예측할 때는 gaussian process를 이용하고, 다음 포인트를 선택할 때는 aquisition function을 이용한다. 저번 문서에서 gaussian process를 공부했으니 이번에는 aquisition function에 대해 공부한다. 
