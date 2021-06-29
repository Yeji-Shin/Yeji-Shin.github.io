---
layout: post
title: class, module, package
date: 2021-06-30
category: Doit_Python
use_math: true
---

### 1. 클래스 (class)

클래스는 프로그램 작성을 위해 꼭 필요한 것은 아니지만 적재적소에 사용하면 편리하다. 클래스(class)란 똑같은 무엇인가를 계속해서 만들어 낼 수 있는 설계 도면이고(과자 틀), 객체(object)란 클래스로 만든 피조물(과자 틀을 사용해 만든 과자)을 뜻한다. <mark>각 객체는 고유한 성격을 가지며 동일한 클래스로 만든 객체들은 서로 영향을 주지 않는다.</mark>

![image](https://user-images.githubusercontent.com/61526722/123731793-d6e59000-d8d3-11eb-90b5-798d72b91551.png)

#### 사칙연산 클래스

클래스 안에 구현된 함수는 메서드(Method)라고 부른다. 

```python
class FourCal:
  def setdata(self, first, second):   # ① 메서드의 매개변수
    self.first = first              # ② 메서드의 수행문
    self.second = second            # ② 메서드의 수행문
  def add(self):
    result = self.first + self.second
    return result
  def mul(self):
    result = self.first * self.second
    return result
  def sub(self):
    result = self.first - self.second
    return result
  def div(self):
    result = self.first / self.second
    return result
```

```python
# 객체를 먼저 만들기
a = FourCal()
b = FourCal()

# 객체를 통해 클래스의 메서드를 호출하려면 도트(.) 연산자를 사용
a.setdata(4, 2)
b.setdata(3, 8)
```
setdata 메서드에는 self, first, second 총 3개의 매개변수가 필요한데 실제로는 a.setdata(4, 2)처럼 2개 값만 전달했다. 그 이유는 a.setdata(4, 2)처럼 호출하면 setdata 메서드의 첫 번째 매개변수 <mark>self에는 setdata메서드를 호출한 객체 a가 자동으로 전달</mark>되기 때문이다. 

![image](https://user-images.githubusercontent.com/61526722/123733137-ef56aa00-d8d5-11eb-87b8-ca1f52053fd8.png)

이렇게 a.setdata(4, 2)처럼 호출하면 setdata 메서드의 매개변수 first, second에는 각각 값 4와 2가 전달되어 setdata 메서드의 수행문은 다음과 같이 해석된다. 

```python
self.first = 4
self.second = 2

# self는 전달된 객체 a이므로 다시 아래와 같다.
a.first = 4
a.second = 2
```
따라서 a.setdata(4, 2)를 하면 객체 a에 객체변수 first가 생성되고 값 4가 저장된다. 마찬가지로 객체 a에 객체변수 second가 생성되고 값 2가 저장된다. 객체에 생성되는 객체만의 변수를 객체변수라고 부른다.

```python
a = FourCal()
a.setdata(4,2)
print(a.first)
# 4

b = FourCal()
b.setdata(5,3)
print(b.first)
# 5
```

a 객체의 first 값은 b 객체의 first 값에 영향받지 않고 원래 값을 유지하고 있다. 이 예제를 통해 클래스로 만든 객체의 객체변수는 다른 객체의 객체변수에 상관없이 독립적인 값을 유지한다는 것을 확인할 수 있다.

이제 위 클래스를 사용하여 결과값을 내보자. 

```python
# 객체를 먼저 만들기
a = FourCal()
b = FourCal()

# 객체를 통해 클래스의 메서드를 호출하려면 도트(.) 연산자를 사용
a.setdata(4, 2)
b.setdata(3, 8)

print(a.add())
# 6
print(b.add())
# 11
```

a.add()와 같이 a 객체에 의해 add 메서드가 수행되면 add 메서드의 self에는 객체 a가 자동으로 입력된다. add 메서드의 매개변수는 self이고 반환 값은 result이다. *result = self.first + self.second* a.add() 메서드 호출 전에 a.setdata(4, 2) 가 먼저 호출되어 a.first = 4, a.second = 2 라고 이미 설정되었기 때문에 6이라는 결과를 낸다.


#### 생성자 (Constructor)

FourCal 클래스의 인스턴스 a에 setdata 메서드를 수행하지 않고 add 메서드를 수행하면 "AttributeError: 'FourCal' object has no attribute 'first'" 오류가 발생한다. setdata 메서드를 수행해야 객체 a의 객체변수 first와 second가 생성되기 때문이다.

```python
a = FourCal()
a.add()

'''
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 6, in add
AttributeError: 'FourCal' object has no attribute 'first'
'''
```

이렇게 객체에 초깃값을 설정해야 할 필요가 있을 때는 setdata와 같은 메서드를 호출하여 초깃값을 설정하기보다는 생성자를 구현하는 것이 안전한 방법이다. <mark>생성자(Constructor)란 객체가 생성될 때 자동으로 호출되는 메서드</mark>를 의미한다. 파이썬 메서드 이름으로 __init__ 를 사용하면 이 메서드는 생성자가 된다. 다음과 같이 FourCal 클래스에 생성자를 추가해 보자.


```python
class FourCal:
  def __init__(self, first, second):
    self.first = first
    self.second = second
  def setdata(self, first, second):  
    self.first = first           
    self.second = second            
  def add(self):
    result = self.first + self.second
    return result
  def mul(self):
    result = self.first * self.second
    return result
  def sub(self):
    result = self.first - self.second
    return result
  def div(self):
    result = self.first / self.second
    return result
```

__init__ 메서드는 setdata 메서드와 이름만 다르고 모든 게 동일하다. 단 메서드 이름을 __init__ 으로 했기 때문에 생성자로 인식되어 객체가 생성되는 시점에 자동으로 호출되는 차이가 있다.

```python
a = FourCal(4, 2)
print(a.first)
# 4
print(a.second)
# 2

print(a.add())
# 6
```

이처럼 __init__ 메서드를 사용하면 setdata를 사용하지 않고 한 번에 객체로 입력값을 전달할 수 있다. 

#### 클래스의 상속

상속은 <mark>기존 클래스를 변경하지 않고 기능을 추가하거나 기존 기능을 변경</mark>할 때 사용한다. 클래스에 기능을 추가하고 싶으면 기존 클래스를 수정하면 되는데 왜 굳이 상속을 받아서 처리해야 하지라고 생각할 수 있다. 하지만 기존 클래스가 라이브러리 형태로 제공되거나 수정이 허용되지 않는 상황이라면 상속을 사용해야 한다. 


상속 개념을 사용하여 우리가 만든 FourCal 클래스에 $a^{b}$ (a의 b제곱)을 구할 수 있는 기능을 추가해 보자.

```python
class MoreFourCal(FourCal):
  def pow(self):
    result = self.first ** self.second
    return result
```
클래스를 상속할 때는 *class 클래스 이름(상속할 클래스 이름)* 을 사용하면 된다. MoreFourCal 클래스는 FourCal 클래스를 상속했으므로 FourCal 클래스의 모든 기능을 사용할 수 있어야 한다.

```python
a = MoreFourCal(4, 2)

print(a.add())
# 6

print(a.pow())
# 16
```

#### 메서드 오버라이딩

<mark>부모 클래스(상속한 클래스)에 있는 메서드를 동일한 이름으로 다시 만드는 것</mark>을 메서드 오버라이딩(Overriding, 덮어쓰기)이라고 한다. 이렇게 메서드를 오버라이딩하면 부모클래스의 메서드 대신 오버라이딩한 메서드가 호출된다.

FourCal 클래스의 객체 a에 4와 0 값을 설정하고 div 메서드를 호출하면 4를 0으로 나누려고 하기 때문에 위와 같은 ZeroDivisionError 오류가 발생한다. 이를 해결하기 위해 SafeFourCal 클래스에 오버라이딩한 div 메서드는 나누는 값이 0인 경우에는 0을 돌려주도록 수정해보자.

```python
class SafeFourCal(FourCal):
  def div(self):
    if self.second == 0:  # 나누는 값이 0인 경우 0을 리턴하도록 수정
      return 0
    else:
      return self.first / self.second
      
a = SafeFourCal(4, 0)
a.div()
# 0
```

ZeroDivisionError가 발생하지 않고 0을 돌려주는 것을 확인할 수 있다.

#### 클래스 변수

객체변수는 다른 객체들에 영향받지 않고 독립적으로 그 값을 유지한다고 했다. 반대로 클래스 변수는 <mark>클래스로 만든 모든 객체에 공유된다</mark>는 특징이 있다. 클래스 변수는 클래스 안에 함수를 선언하는 것과 마찬가지로 클래스 안에 변수를 선언하여 생성한다.

```python
class Family:
  lastname = "김"
  
a = Family()
b = Family()
print(a.lastname)
# 김
print(b.lastname)
# 김
```

---

### 2. 모듈 (module)




