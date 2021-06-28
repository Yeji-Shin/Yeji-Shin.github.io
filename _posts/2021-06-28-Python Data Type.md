---
layout: post
title: Python Data Type
date: 2021-06-28
category: Do-it-Python
use_math: true
---

### 1. 수 자료형

#### 정수형

정수형은 정수를 다루는 자료형으로 양의 정수, 음의 정수, 0 이 있다. 

#### 실수형

소수점 아래의 데이터를 포함하는 수 자료형이다. 실수형 데이터를 표현할 때는 <mark>e</mark>나 <mark>E</mark>를 이용한 지수표현 방식을 사용한다. 

```python
# 10억의 지수 표현 방식
a = 1e9
print(a)
# 1000000000.0

# 752.5
a= 75.25e1
print(a)
# 752.5
```

보통 컴퓨터 시스템은 수 데이터를 처리할 때 2진수를 사용한다. 따라서 컴퓨터는 실수를 정확히 표현하지 못하기 때문에 소수점 값을 비교할 때는 round() 함수를 히용한다. 

```python
a = 0.3 + 0.9
print(a)

if a == 0.9:
  print(True)
else:
  print(False)
# False

# round()
a = 0.3 + 0.9
print(round(a,4))  # 소수점 넷째자리 까지 표현 (다섯번째 자리에서 반올림)

if a == 0.9:
  print(True)
else:
  print(False)
# True
```

---

### 2. 문자열

문자열(string)은 문자, 단어 들으로 구성된 문자들의 집합이다. 문자열 변수를 초기화할 때는 "" 나 ''를 사용한다. 파이썬에서 문자열은 덧셈과 곱셈 연산을 사용할 수 있다. 

문자열 변수에 덧셈을 이용하면 단순히 문자열이 더해져서 연결된다. 

```python
head = "Python"
tail = " is fun!"
head + tail
# 'Python is fun!'
```

문자열 변수를 양의 정수와 곱하면 문자열이 그 만큼 여러번 더해져서 연결된다. 
```python
a = "python"
a * 2
# 'pythonpython'
```

문자열은 인덱싱과 슬라이싱을 이용할수 있다. 

```python
a = "Life is too short, You need Python"
a[3]
# 'e'

a[-1]
# 'n'

a[-0]
# 'L'

a[0:3]
# 'Lif'
```

문자열에서 또 하나 알아야 할 것으로는 문자열 포매팅(Formatting)이 있다. 
```python
# 숫자 바로 대입
"I eat %d apples." % 3
#'I eat 3 apples.'

"I eat {0} apples".format(3)
# 'I eat 3 apples'

# 문자 바로 대입
"I eat %s apples." % "five"
# 'I eat five apples.'

"I eat {0} apples".format("five")
# 'I eat five apples'

# 숫자 값을 나타내는 변수로 대입
number = 3
"I eat %d apples." % number
# 'I eat 3 apples.'

number = 3
"I eat {0} apples".format(number)
# 'I eat 3 apples'

# 2개 이상의 값 넣기
number = 10
day = "three"
"I ate %d apples. so I was sick for %s days." % (number, day)
# 'I ate 10 apples. so I was sick for three days.'

number = 10
day = "three"
"I ate {0} apples. so I was sick for {1} days.".format(number, day)
# 'I ate 10 apples. so I was sick for three days.'

"I ate {number} apples. so I was sick for {day} days.".format(number=10, day=3)
# 'I ate 10 apples. so I was sick for 3 days.'

"I ate {0} apples. so I was sick for {day} days.".format(10, day=3)
# 'I ate 10 apples. so I was sick for 3 days.'
```

%s 포맷 코드는 어떤 형태의 값이든 변환해 넣을 수 있다. 왜냐하면 %s는 자동으로 % 뒤에 있는 값을 문자열로 바꾸기 때문이다.

```python
# %s 코드
"rate is %s" % 3.234
# 'rate is 3.234'
```

파이썬 3.6 버전부터는 f 문자열 포매팅 기능을 사용할 수 있다. 다음과 같이 문자열 앞에 f 접두사를 붙이면 f 문자열 포매팅 기능을 사용할 수 있다.

```python
name = '홍길동'
age = 30
f'나의 이름은 {name}입니다. 나이는 {age}입니다.'
# '나의 이름은 홍길동입니다. 나이는 30입니다.'

f'나는 내년이면 {age+1}살이 된다.'
# '나는 내년이면 31살이 된다.'
```

문자열 자료형은 자체적으로 함수를 가지고 있다. 이들 함수를 다른 말로 문자열 내장 함수라 한다. 
```python
# 문자 개수 세기 (count)
a = "hobby"
a.count('b')
# 2

# 위치 알려주기1(find)
a = "Python is the best choice"
a.find('b')
# 14

a.find('k') # 찾는 문자나 문자열이 존재하지 않는다면 -1을 반환
# -1

# 위치 알려주기2(index)
a = "Life is too short"
a.index('t')
# 8

a.index('k') # 찾는 문자나 문자열이 존재하지 않는다면 오류 발생
# Traceback (most recent call last): File "<stdin>", line 1, in <module> ValueError: substring not found

# 문자열 삽입(join)
",".join('abcd')
# 'a,b,c,d'

",".join(['a', 'b', 'c', 'd'])
# 'a,b,c,d'

# 왼쪽 공백 지우기(lstrip)
a = " hi "
a.lstrip()
# 'hi '

# 오른쪽 공백 지우기(rstrip)
a= " hi "
a.rstrip()
#' hi'

# 양쪽 공백 지우기(strip)
a = " hi "
a.strip()
# 'hi'

# 문자열 바꾸기(replace)
a = "Life is too short"
a.replace("Life", "Your leg")
# 'Your leg is too short'

# 문자열 나누기(split)
a = "Life is too short"
a.split() # 괄호 안에 아무 값도 넣어 주지 않으면 공백(스페이스, 탭, 엔터 등)을 기준으로 문자열을 나
# ['Life', 'is', 'too', 'short']

b = "a:b:c:d"
b.split(':')
# ['a', 'b', 'c', 'd']
```

---

### 3. 리스트

리스트는 여러 개의 데이터를 연속적으로 담아 처리하기 위해 사용하는 자료형이다. 리스트 대신에 배열 혹은 테이블로도 부른다. 

![image](https://user-images.githubusercontent.com/61526722/123643653-93513e80-d85f-11eb-938d-b5a3bd721361.png)

#### 리스트 만들기

리스트는 [] 안에 원소를 넣어 초기화한다. 

```python
a = []
print(a)
# []

a =[0] * 10
print(a)
# [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

#### 리스트 컴프리헨션 

리스트 컴프리헨션은 리스트를 초기화하는 방법 중 하나로 2차원의 리스트를 초기화 할 때 효과적으로 사용된다. 

```python
A = [i for i in range(10) if i % 2 == 1]
# [1, 3, 5, 7, 9]

A = [i*i for i in range(10)]
# [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# n*m 크기의 2차원 리스트 초기화
n = 3
m = 4 
A = [[0]*m for _ in range(n)]
# [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
```

#### 리스트 인덱싱과 슬라이싱 

리스트도 문자열처럼 인덱싱과 슬라이싱이 가능하다.

```python
a = [1, 2, 3]
a[0]
# 1

a = [1, 2, 3, 4, 5]
a[0:2]
# [1, 2]
```

#### 리스트의 수정과 삭제

리스트는 값을 수정하거나 삭제할 수 있다.

```python 
a = [1, 2, 3]
a[2] = 4
a
# [1, 2, 4]

# del 객체
a = [1, 2, 3]
del a[1]
a
# [1, 3]
```

#### 리스트에 요소 추가(append)

append(x)는 리스트의 맨 마지막에 x를 추가하는 함수이다. 리스트 안에는 어떤 자료형도 추가할 수 있다.

```python
a = [1, 2, 3]
a.append(4)
a
# [1, 2, 3, 4]

# 리스트에 다시 리스트를 추가
a.append([5,6])
a
# [1, 2, 3, 4, [5, 6]]
```

#### 리스트 정렬(sort)

sort 함수는 리스트의 요소를 순서대로 정렬해 준다.

```python
a = [1, 4, 3, 2]
a.sort()
a
# [1, 2, 3, 4]

a = [1, 4, 3, 2]
a.sort(reverse=True)
a
# [4, 3, 2, 1]
```

#### 리스트 뒤집기(reverse)

reverse 함수는 리스트를 역순으로 뒤집어 준다. 

```python
a = ['a', 'c', 'b']
a.reverse()
a
# ['b', 'c', 'a']
```

#### 위치 반환(index)

index(x) 함수는 리스트에 x 값이 있으면 x의 위치 값을 돌려준다.

```python
a = [1,2,3]
a.index(3)
# 2
```

#### 리스트에 요소 삽입(insert)

insert(a, b)는 리스트의 a번째 위치에 b를 삽입하는 함수이다. 

```python
a = [1, 2, 3]
a.insert(0, 4)
a
# [4, 1, 2, 3]
```

insert() 함수는 원소의 개수가 N개이면 시간 복잡도는 O(N)이다. insert()는 중간에 원소를 삽입한 뒤에 리스트의 원소 위치를 조정해줘야 하기 때문에 동작이 느리다. 반면에 append()함수는 O(1)에 수행된다. 

##### 리스트 요소 제거(remove)

remove(x)는 리스트에서 첫 번째로 나오는 x를 삭제하는 함수이다.

```python
a = [1, 2, 3, 1, 2, 3]
a.remove(3)
a
# [1, 2, 1, 2, 3]
```
remove()의 시간 복잡도는 insert()와 마찬가지로 O(N)이다. 리스트 중간에 있는 원소를 삭제한 뒤에 리스트의 원소 위치를 조정해야 하기 때문이다. 그러면 특정한 값의 원소를 모두 제거하려면 어떻게 해야 할까. 아래와 같이 a에 포함된 원소를 하나씩 확인하며 그 원소가 remove_set에 포함되어 있지 않았을 때만 리스트 변수인 result에 넣으면 된다.

```python
a = [1, 2, 3, 4, 5, 5, 5]
remove_set = {3, 5}

result = [i for i in a if i not in remove_set]
print(result)
# [1, 2, 4]
```

#### 리스트 요소 끄집어내기(pop)

pop()은 리스트의 맨 마지막 요소를 돌려주고 그 요소는 삭제한다.

```python
a = [1,2,3]
a.pop()
# 3
a
# [1, 2]
```

pop(idx)는 리스트의 idx번째 요소를 돌려주고 그 요소는 삭제한다.

```python
a = [1,2,3]
a.pop(1)
# 2
a
# [1, 3]
```

#### 리스트에 포함된 요소 x의 개수 세기(count)

count(x)는 리스트 안에 x가 몇 개 있는지 조사하여 그 개수를 돌려주는 함수이다.

```python
a = [1,2,3,1]
a.count(1)
# 2
```

