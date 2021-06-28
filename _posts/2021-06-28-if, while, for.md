---
layout: post
title: if, while, for
date: 2021-06-28
category: Doit-Python
use_math: true
---

이번 문서에서는 if, while, for 등의 제어문에 대해서 배우고자 한다. 

---

### 1. 조건문(if)

if 조건문에서 "조건문"이란 참과 거짓을 판단하는 문장을 말한다.

![image](https://user-images.githubusercontent.com/61526722/123659818-08c40b80-d86e-11eb-9157-da5a3df8097a.png)


#### 비교연산자

조건문에는 비교연산자를 자주 사용한다. 

#### 논리연산자

![image](https://user-images.githubusercontent.com/61526722/123659767-fea20d00-d86d-11eb-9975-9324f816cdb9.png)

#### x in s, x not in s

파이썬에서는 추가적으로 'in 연산자'와 'not in 연산자'를 제공한다. 여러 개의 데이터를 담는 자료형인 리스트, 튜플, 문자열, 사전과 같은 자료형에서 이 자료형 안에 어떠한 값이 존재하는지 확인하는 연산이다. 

![image](https://user-images.githubusercontent.com/61526722/123660109-550f4b80-d86e-11eb-9f33-6fd55bdc8df4.png)

```python
1 in [1, 2, 3]
# True

1 not in [1, 2, 3]
# False
```

#### 조건부 표현식

'조건문이 참인 경우 if 조건문 else 조건문이 거짓인 경우' 조건부 표현식은 if ~ else문을 한 줄에 작성하여 가독성에 유리하고 한 줄로 작성할 수 있어 활용성이 좋다.

```python
if score >= 60:
    message = "success"
else:
    message = "failure"

# 조건부 표현식
message = "success" if score >= 60 else "failure"
```

#### pass
paas는 아무것도 처리하고 싶지 않을 때, 디버깅 과정에서 일단 조건문의 형태만 만들어 놓고 조건문을 처리하는 부분은 비워 놓고 싶은 경우에 사용한다.

```python
pocket = ['paper', 'money', 'cellphone']
if 'money' in pocket:
  pass 
else:
  print("카드를 꺼내라")
```
pocket 리스트 안에 money 문자열이 있기 때문에 if문 다음 문장인 pass가 수행되고 아무 결괏값도 보여 주지 않는다.

---

### 2. 반복문 - while, for

반복문은 특정한 코드를 반복적으로 실행하고자 할 때 사용한다. while과 for문이 있는데 대부분의 경우에 for문이 더 코드가 짧다. 

#### while 문

while문은 조건문이 참인 동안에 while문 아래의 문장이 반복해서 수행된다.

```python
while <조건문>:
    <수행할 문장1>
    <수행할 문장2>
    <수행할 문장3>
    ...
```
다음은 1부터 9까지 각 정수의 합을 계산하는 코드이다.

```python
i = 1
result = 0

while i <= 9:
  result += 1
  i += 1

print(result)

# 45
```

#### while문 강제로 빠져나가기

while문은 조건문이 참인 동안 계속해서 while문 안의 내용을 반복적으로 수행한다. 하지만 강제로 while문을 빠져나가고 싶을 때가 있다. 예를 들어 커피 자판기를 생각해 보자. 자판기 안에 커피가 충분히 있을 때에는 동전을 넣으면 커피가 나온다. 그런데 자판기가 제대로 작동하려면 커피가 얼마나 남았는지 항상 검사해야 한다. 만약 커피가 떨어졌다면 판매를 중단하고 "판매 중지" 문구를 사용자에게 보여주어야 한다. 이렇게 판매를 강제로 멈추게 하는 것이 바로 break문이다.

#### for 문


















