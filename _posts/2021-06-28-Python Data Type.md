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



