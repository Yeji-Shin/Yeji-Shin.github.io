---
layout: post
title: try except
date: 2021-06-30
category: Doit_Python
use_math: true
---

프로그램을 만들다 보면 수없이 많은 오류를 만나게 된다. 파이썬에서는 try, except를 사용해서 예외적으로 오류를 무시할 수 있다.

### 1. try, except

다음은 오류 처리를 위한 try, except문의 기본 구조이다. try 블록 수행 중 오류가 발생하면 except 블록이 수행된다. 하지만 try 블록에서 오류가 발생하지 않는다면 except 블록은 수행되지 않는다.

```python
try:
    ...
except [발생 오류[as 오류 메시지 변수]]:
    ...
```

이때 except 구문은 세가지 방법으로 사용할 수 있다.

#### try, except만 쓰는 방법

이 경우는 <mark>오류 종류에 상관없이</mark> 오류가 발생하면 except 블록을 수행한다.

```python
try:
    ...
except:
    ...
```

#### 발생 오류만 포함한 except문

이 경우는 오류가 발생했을 때 except문에 미리 정해 놓은 오류 이름과 일치할 때만 except 블록을 수행한다.

```python
try:
    ...
except 발생 오류:
    ...
```

#### 발생 오류와 오류 메시지 변수까지 포함한 except문

이 경우는 미리 정해 놓은 오류 이름과 일치할 때 오류 메시지의 내용을 말해준다.

```python
try:
    ...
except 발생 오류 as 오류 메시지 변수:
    ...
```

예를 들어 4를 0으로 나누려고 하면 ZeroDivisionError가 발생하여 except 블록이 실행되고 변수 e에 담기는 오류 메시지를 다음과 같이 출력한다.

```python
try:
    4 / 0
except ZeroDivisionError as e:
    print(e)
    
# division by zero
```

#### 여러개의 오류처리하기

try문 안에서 여러 개의 오류를 처리하기 위해 다음 구문을 사용한다.

```python
try:
    ...
except 발생 오류1:
   ... 
except 발생 오류2:
   ...
```

먼저 사용된 except문이 처리되면 다음 except문은 처리되진 않는다. 예시를 보자.

```python
try:
    a = [1,2]
    print(a[3])
    4/0
except ZeroDivisionError:
    print("0으로 나눌 수 없습니다.")
except IndexError:
    print("인덱싱 할 수 없습니다.")
```

위에서 a는 2개의 요솟값을 가지고 있기 때문에 a[3]는 IndexError를 발생시키므로 "인덱싱할 수 없습니다."라는 문자열이 출력될 것이다. 인덱싱 오류가 먼저 발생했으므로 4/0으로 발생되는 ZeroDivisionError 오류는 발생하지 않는다.

#### try문에 else절 사용하기

try문에는 다음처럼 else절을 사용할 수 있다. try문 수행중 <mark>오류가 발생하면 except절이 수행되고 오류가 없으면 else절이 수행</mark>된다.

```python
try:
    ...
except [발생 오류[as 오류 메시지 변수]]:
    ...
else:  # 오류가 없을 경우에만 수행된다.
    ...
```
다음은 try문에 else절을 활용하는 간단한 예이다.

```python
try:
    age=int(input('나이를 입력하세요: '))
except:
    print('입력이 정확하지 않습니다.')
else:
    if age <= 18:
        print('미성년자는 출입금지입니다.')
    else:
        print('환영합니다.')
```

만약 '나이를 입력하세요:' 라는 질문에 숫자가 아닌 다른 값을 입력하면 오류가 발생하여 '입력이 정확하지 않습니다.'라는 문장을 출력한다. 오류가 없을 경우에만 else절이 수행된다.


---

### 2. 오류 회피하기

특정 오류가 발생할 경우 그냥 통과시킬 수도 있다.

```python
try:
    f = open("나없는파일", 'r')
except FileNotFoundError:
    pass
```

위의 예제처럼 try문 안에서 FileNotFoundError가 발생할 경우에 pass를 사용하여 오류를 그냥 회피한다.

---

### 3. 오류 일부러 발생시키기

파이썬은 raise 명령어를 사용해 오류를 강제로 발생시킬 수 있다. 예외는 다음과 같이 파이썬 내장 클래스인 Exception 클래스를 상속하여 만들 수 있다.

```python
class MyError(Exception):
    pass
```

그리고 임의의 함수를 만들어 호출해보자.
```python
def say_nick(nick):
    if nick == '바보':
        raise MyError()
    print(nick)
    
say_nick("천사")
say_nick("바보")

'''
천사
Traceback (most recent call last):
  File "...", line 11, in <module>
    say_nick("바보")
  File "...", line 7, in say_nick
    raise MyError()
__main__.MyError
'''
```

프로그램을 실행해 보면 "천사"가 한 번 출력된 후 MyError가 발생한다.








