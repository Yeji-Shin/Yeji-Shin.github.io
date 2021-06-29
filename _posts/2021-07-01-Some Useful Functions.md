---
layout: post
title: Some Useful Functions
date: 2021-07-01
category: Doit_Python
use_math: true
---

파이썬 내장 함수는 외부 모듈과 달리 import 명령어 없이 바로 사용할 수 있는 함수이다. 활용 빈도가 높고 중요한 함수를 몇가지 살펴볼 것이다. 
반복 가능한(iterable) 자료형이라는 말을 자주 사용할 것인데, 반복 가능한 자료형이란 for문으로 그 값을 출력할 수 있는 것을 의미한다. 리스트, 튜플, 문자열, 딕셔너리, 집합 등이 있다.

---

### 1. all

all(x)는 반복 가능한(iterable) 자료형 x를 입력 인수로 받으며 이 x의 요소가 모두 참이면 True, 거짓이 하나라도 있으면 False를 돌려준다.

```python
all([1, 2, 3])
# True
```
리스트 자료형 [1, 2, 3]은 모든 요소가 참이므로 True를 돌려준다.
```python
all([1, 2, 3, 0])
# False
```
리스트 자료형 [1, 2, 3, 0] 중에서 요소 0은 거짓이므로 False를 돌려준다.
```python
all([])
# True
```
만약 all의 입력 인수가 빈 값인 경우에는 True를 리턴한다.

---

### 2. any

any(x)는 반복 가능한(iterable) 자료형 x를 입력 인수로 받으며 이 x의 요소 중 하나라도 참이 있으면 True를 돌려주고, x가 모두 거짓일 때에만 False를 돌려준다. all(x)의 반대이다.

```python
any([1, 2, 3, 0])
# True
```
리스트 자료형 [1, 2, 3, 0] 중에서 1, 2, 3이 참이므로 True를 돌려준다.

```python
any([])
# False
```
any의 입력 인수가 빈 값인 경우에는 False를 리턴한다.

---

### 3. divmod

divmod(a, b)는 a를 b로 나눈 몫과 나머지를 <mark>튜플 형태</mark>로 돌려주는 함수이다.

```python
divmod(7, 3)
# (2, 1)
```
---

### 4. enumerate

순서가 있는 자료형(리스트, 튜플, 문자열)을 입력으로 받아 인덱스 값을 포함하는 enumerate 객체를 돌려준다. 보통 enumerate 함수는 다음 예제처럼 for문과 함께 자주 사용한다.

```python 
for i, name in enumerate(['body', 'foo', 'bar']):
  print(i, name)

'''
0 body
1 foo
2 bar
'''
```
객체가 현재 어느 위치에 있는지 알려 주는 인덱스 값이 필요할때 enumerate 함수를 사용하면 매우 유용하다.

--- 

### 5. eval

eval(expression )은 문자열을 입력으로 받아 실행한 결괏값을 돌려주는 함수이다. 보통 eval은 입력받은 문자열로 파이썬 함수나 클래스를 동적으로 실행하고 싶을 때 사용한다.

```python
eval('1+2')
# 3

eval("'hi' + 'a'")
# hia'

eval('divmod(4, 3)')
# (1, 1)
```


---

### 6. hex , oct

hex(x)는 정수 값을 입력받아 16진수(hexadecimal)로 변환하여 돌려주는 함수이다

```python
hex(234)
# '0xea'

hex(3)
# '0x3'
```

oct(x)는 정수 형태의 숫자를 8진수 문자열로 바꾸어 돌려주는 함수이다.

```python
oct(34)
# '0o42'

oct(12345)
# '0o30071'
```

---

### 7. ord, chr

ord(c)는 문자의 유니코드 값을 돌려주는 함수이다.  ord 함수는 chr 함수와 반대이다.
```python
ord('a')
# 97

ord('가')
# 44032
```

chr(i)는 유니코드(Unicode) 값을 입력받아 그 코드에 해당하는 문자를 출력하는 함수이다.

```python
chr(97)
# 'a'

chr(44032)
# '가'
```
---

### 8. isinstance

isinstance(object, class)는 첫 번째 인수로 인스턴스, 두 번째 인수로 클래스 이름을 받는다. 입력으로 받은 인스턴스가 그 클래스의 인스턴스인지를 판단하여 참이면 True, 거짓이면 False를 돌려준다.

```python
class Person: 
  pass

a = Person()
isinstance(a, Person)
# True

b = 3
isinstance(b, Person)
# False
```

---

### 9. sorted
sorted(iterable) 함수는 입력값을 정렬한 후 그 결과를 리스트로 돌려주는 함수이다.

```python
sorted([3, 1, 2])
# [1, 2, 3]

sorted(['a', 'c', 'b'])
# ['a', 'b', 'c']

sorted("zero")
# ['e', 'o', 'r', 'z']

sorted((3, 2, 1))
# [1, 2, 3]
```
리스트 자료형에도 sort 함수가 있는데, 리스트 자료형의 sort 함수는 리스트 객체 그 자체를 정렬만 할 뿐 정렬된 결과를 돌려주지는 않는다.

---
### 10. zip
zip은 <mark>동일한 개수</mark>로 이루어진 iterable 자료형을 묶어 주는 역할을 하는 함수이다.

```python
list(zip([1, 2, 3], [4, 5, 6]))
# [(1, 4), (2, 5), (3, 6)]

list(zip([1, 2, 3], [4, 5, 6], [7, 8, 9]))
# [(1, 4, 7), (2, 5, 8), (3, 6, 9)]

list(zip("abc", "def"))
# [('a', 'd'), ('b', 'e'), ('c', 'f')]
```
