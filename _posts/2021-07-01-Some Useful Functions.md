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

원소의 인덱스를 1부터 시작할 수도 있다. ㄷ

```python
for i, name in enumerate(['body', 'foo', 'bar'], 1):
  print(i, name)

'''
1 body
2 foo
3 bar
'''
```

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

---

### 11. math 라이브러리

math 라이브러리는 자주 사용되는 수학적인 기능을 포함하고 있다. 

#### 팩토리얼
```python
import math

print(math.factorial(5))
# 120
```

#### 제곱근

```python
import math

print(math.sqrt(7))
# 2.6457513110645907
```

### 최대 공약수
gcd(a, b) 는 a와 b의 최대공약수를 반환한다.
```python
import math

print(math.gcd(21,14))
# 7
```

#### 파이와 자연상수

```python
import math

print(math.pi)
# 3.141592653589793

print(math.e)
# 2.718281828459045
```

---

### 11. <mark>Counter()</mark>

Counter()를 사용하면 주어진 단어(리스트)에서 그 알파벳(단어)이 몇 번 등장하는지 알려주는 <mark>딕셔너리 기반의 메서드</mark>이다. 보통 데이터의 개수를 셀 때 dictionary 자료구조를 많이 사용한다. 

#### 딕셔너리를 사용한 카운팅

```python
def count_letters(word):
    counter = {}
    for letter in word:
        if letter not in counter:
            counter[letter] = 0
        counter[letter] += 1
    return counter

count_letters('hello world'))
# {'h': 1, 'e': 1, 'l': 3, 'o': 2, ' ': 1, 'w': 1, 'r': 1, 'd': 1}
```

#### Counter()를 사용한 카운팅

counter() 함수는 그 단어와 등장숫자를 내림차순으로 정렬해 나타낸다. 이것을 dict() 함수로 딕셔너리로 바꾸면 단어의 등장순서에 따라 정렬해준다. 

```python
from collections import Counter

counter = Counter('hello world') 
print(counter)
# Counter({'l': 3, 'o': 2, 'h': 1, 'e': 1, ' ': 1, 'w': 1, 'r': 1, 'd': 1})

# 사전 자료형으로 바꾸기
print(dict(counter))  
# {'h': 1, 'e': 1, 'l': 3, 'o': 2, ' ': 1, 'w': 1, 'r': 1, 'd': 1}

# items() : key, value 쌍을 튜플 형태로 반환
print(counter.items())
# dict_items([('h', 1), ('e', 1), ('l', 3), ('o', 2), (' ', 1), ('w', 1), ('r', 1), ('d', 1)])

# keys() : 카운터 객체의 key들을 반환
print(counter.keys())
# dict_keys(['h', 'e', 'l', 'o', ' ', 'w', 'r', 'd'])

# values() : 카운터 객체의 value, 즉 카운트들을 반환
print(counter.values())
# dict_values([1, 1, 3, 2, 1, 1, 1, 1])

# 루프 돌리기 (counter는 딕셔너리 형태이기 때문에 가능)
for key, value in counter.items():
    print(key, ':', value)
'''
h : 1
e : 1
l : 3
o : 2
  : 1
w : 1
r : 1
d : 1
'''

# elements() : 카운터 숫자만큼 요소 반환
print(list(counter.elements()))
# ['h', 'e', 'l', 'l', 'l', 'o', 'o', ' ', 'w', 'r', 'd']
```

#### <mark>Counter().most_common()</mark>

Counter 클래스는 데이터의 개수가 많은 순으로 정렬된 배열을 리턴하는 most_common 메서드가 있다.

```python
from collections import Counter

Counter('hello world').most_common() 
# [('l', 3), ('o', 2), ('h', 1), ('e', 1), (' ', 1), ('w', 1), ('r', 1), ('d', 1)]
```
이 메서드의 인자로 숫자 K를 넘기면 그 숫자 만큼만 리턴하기 때문에, 가장 개수가 많은 K개의 데이터를 얻을 수도 있습니다.

```python
from collections import Counter

Counter('hello world').most_common(1) 
# [('l', 3)]
```

#### counter 연산

더하기, 빼기, 교집합, 합집합 연산도 가능하다.

```python
c3 = Counter({'a': 3, 'b': 5, 'c': 1, 'd': 4})
c4 = Counter({'a': 1, 'b': 2, 'c': 8, 'e': 4})

c3 + c4 # Counter({'a': 4, 'b': 7, 'c': 9, 'd': 4, 'e': 4})
c3 - c4 # Counter({'a': 2, 'b': 3, 'd': 4})
c3 & c4 # Counter({'a': 1, 'b': 2, 'c': 1})
c3 | c4 # Counter({'a': 3, 'b': 5, 'c': 8, 'd': 4, 'e': 4})
```

update() : iterable을 전달하여 같은 값이 있으면 카운트가 추가되게 하고 없으면 새로운 key, value 쌍을 생성한다.

```python
old = ['apple', 'banana', 'strawberry'] # 원래 리스트
new = ['hi', 'apple', 'apple', 'Apple'] # 추가로 나타난 리스트

from collections import Counter
counter = Counter(old)
print(counter)
# Counter({'apple': 1, 'banana': 1, 'strawberry': 1})

counter.update(new)  # 추가된 리스트를 누적하여 센다
print(counter)
# Counter({'apple': 3, 'banana': 1, 'strawberry': 1, 'hi': 1, 'Apple': 1})
```

----

### 12. <mark>itertools()</mark>

itertools는 파이썬에서 반복되는 데이터를 처리하는 기능을 포함하고 있는 라이브러리이다. 그 중 permutation과 combination이 주로 사용된다.

#### permutations()

<mark>permutation(순열)은 리스트와 같은 iterable 객체에서 r개의 데이터를 뽑아 일렬로 나열하는 모든 경우</mark>를 계산해준다. permutations()은 클래스이므로 리스트로 변형하여 사용한다. 

```python
from itertools import permutations

data = ['a', 'b', 'c', 'd']
result = permutations(data,3)
print(result)
# <itertools.permutations object at 0x000002730D8B23B0>

print(list(result))
# [('a', 'b'), ('a', 'c'), ('b', 'a'), ('b', 'c'), ('c', 'a'), ('c', 'b')]
```

#### product()

product는 permutations()와 비슷하게 동작하지만 원소를 중복하여 뽑는다. 즉, 순서를 고려하고 원소를 중복허용하여 뽑는 경우를 모두 반환한다.

```python
from itertools import product

data = ['a', 'b', 'c']
result = list(product(data,repeat=2))  # 중복을 허용하여 2개 뽑는 경우
print(result)
# [('a', 'a'), ('a', 'b'), ('a', 'c'), ('b', 'a'), ('b', 'b'), ('b', 'c'), ('c', 'a'), ('c', 'b'), ('c', 'c')]
```

#### combinations()

<mark>combination(조합)은 리스트와 같은 iterable 객체에서 r개의 데이터를 뽑아 순서를 고려하지 않고 나열하는 모든 경우</mark>를 계산해준다. combinations()은 클래스이므로 리스트로 변형하여 사용한다. 

```python
from itertools import combinations

data = ['a', 'b', 'c']
result = combinations(data,2)
print(result)
# <itertools.combinations object at 0x000002730D9A09F0>

print(list(result))
# [('a', 'b'), ('a', 'c'), ('b', 'c')]
```

#### combinations_with_replacement()

combinations_with_replacement()는 combinations()와 비슷하게 동작하지만 원소를 중복하여 뽑는다. 즉, 순서를 고려하지 않고 원소를 중복허용하여 뽑는 경우를 모두 반환한다.

```python
from itertools import combinations_with_replacement

data = ['a', 'b', 'c']
result = list(combinations_with_replacement(data,2))  # 중복을 허용하여 조합
print(result)
# [('a', 'a'), ('a', 'b'), ('a', 'c'), ('b', 'b'), ('b', 'c'), ('c', 'c')]
```
