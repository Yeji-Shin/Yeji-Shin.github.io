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

#### while문 강제로 빠져나가기 (break)

while문은 조건문이 참인 동안 계속해서 while문 안의 내용을 반복적으로 수행한다. 하지만 강제로 while문을 빠져나가고 싶을 때가 있다. 예를 들어 커피 자판기의 커피가 떨어졌다면 판매를 중단해야 한다. 이렇게 판매를 강제로 멈추게 하는 것이 바로 break문이다.

```python
coffee = 10
money = 300
while money:
    print("돈을 받았으니 커피를 줍니다.")
    coffee = coffee -1
    print("남은 커피의 양은 %d개입니다." % coffee)
    if coffee == 0:
        print("커피가 다 떨어졌습니다. 판매를 중지합니다.")
        break
```

money가 300으로 고정되어 있으므로 while money:에서 조건문인 money는 0이 아니기 때문에 항상 참이다. 따라서 무한히 반복되는 무한 루프를 돌게 된다. 그리고 while문의 내용을 한 번 수행할 때마다 coffee = coffee - 1에 의해서 coffee의 개수가 1개씩 줄어들고, 만약 coffee가 0이 되면 if coffee == 0 이 참이 되므로 break문이 호출되어 while문을 빠져나가게 된다.

#### while문의 맨 처음으로 돌아가기 (continue)

continue는 반복문에서 남은 코드의 실행을 건너뛰고 다음 반복을 진행하고자 할 때 사용한다. 1부터 10까지의 숫자 중에서 홀수만 출력하는 것을 while문을 사용해서 작성한다고 생각해보자.

```python
a = 0
while a < 10:
    a = a + 1
    if a % 2 == 0: 
        continue
    print(a)
```
이 continue문은 while문의 맨 처음(조건문: a<10)으로 돌아가게 하는 명령어이다. 따라서 위 예에서 a가 짝수이면 print(a)는 수행되지 않을 것이다.

#### while문 무한루프

파이썬에서 무한 루프는 while문으로 구현할 수 있다. 다음은 무한 루프의 기본 형태이다. while문의 조건문이 True이므로 항상 참이 된다. 따라서 while문 안에 있는 문장들은 무한하게 수행될 것이다.

```python
while True: 
    수행할 문장1 
    수행할 문장2
    ...
```

#### for 문

리스트나 튜플, 문자열의 첫 번째 요소부터 마지막 요소까지 차례로 변수에 대입되어 "수행할 문장1", "수행할 문장2" 등이 수행된다.

```python
for 변수 in 리스트(또는 튜플, 문자열):
    수행할 문장1
    수행할 문장2
    ...
```
전형적인 for문
```python
test_list = ['one', 'two', 'three'] 
for i in test_list: 
    print(i)
'''
one 
two 
three
'''
```
a 리스트의 요솟값이 튜플이기 때문에 각각의 요소가 자동으로 (first, last) 변수에 대입된다.
```python
a = [(1,2), (3,4), (5,6)]
for (first, last) in a:
    print(first + last)
    
'''
3
7
11
'''
```

#### for문의 맨 처음으로 돌아가기 (continue)

while문에서 살펴본 continue문을 for문에서도 사용할 수 있다. 즉 for문 안의 문장을 수행하는 도중에 continue문을 만나면 for문의 처음으로 돌아가게 된다.

```python
marks = [90, 25, 67, 45, 80]

number = 0 
for mark in marks: 
    number = number +1 
    if mark < 60:
        continue 
    print("%d번 학생 축하합니다. 합격입니다. " % number)
    
'''
1번 학생 축하합니다. 합격입니다.
3번 학생 축하합니다. 합격입니다.
5번 학생 축하합니다. 합격입니다.
'''
```
60점 이상인 사람에게는 축하 메시지를 보내고 나머지 사람에게는 아무 메시지도 전하지 않는 프로그램이다.

















