---
layout: post
title: Class(5) - NotImplementedError vs @abstractmethod
date: 2022-08-11
category: Python
use_math: true
---

자식 클래스에게 메소드 오버라이딩을 강제하는 방법에는 두 가지가 있다. NotImplementedError와 추상화 클래스인 @abstractmethod이다.
둘의 기능은 동일하다. 하지만 미묘한 차이가 있기에 한번 살펴보자.



## 1. 추상화 클래스 abc는 인스턴스화 불가능

NotImplementedError 에러를 강제로 발생시키는 클래스는 정상적으로 인스턴스를 만들 수 있다. 

### NotImplementedError

```python
class BaseWheel1:
    def roll(self):
        raise NotImplementedError('roll 구현 필요')
```

```
>>> basewheel1 = BaseWheel1()
```

### @abstractmethod

하지만 추상 클래스는 인스턴스화 조차 불가능하다. 
정확하게는 abc 모듈의 abstractmethod 어노테이션이 추가가 되어 있으면 아래와 같은 오류가 발생한다. 
이는 파생 클래스 구현을 위한 추상화 클래스 기능을 제공하는 역할만을 하기 때문이다.

```python
from abc import ABCMeta, abstractmethod

class BaseWheel2(metaclass=ABCMeta):
    @abstractmethod
    def roll(self):
        pass
```

```
>>> basewheel2 = BaseWheel2()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: Can't instantiate abstract class BaseWheel2 with abstract methods roll
```


## 2. 에러 발생 시점

### NotImplementedError

NotImplementedError는 exception이 들어간 함수인 roll()를 직접 호출할 때, 에러가 발생한다. roll()을 호출하지 않고 fastroll()을 호출하면 에러가 발생하지 않는다.
이는 런타임 상황에서 해당 함수가 구현이 되어 있는지 없는지 확인한 후에 에러를 발생한다는 의미이다. 

```python
class BaseWheel1:
    def roll(self):
        raise NotImplementedError('roll 구현 필요')

class MyWheel1(BaseWheel1):
    def fastroll(self):
        print('빠르게 굴러가는 바퀴')
```

```
>>> mywheel1 = MyWheel1()
>>> mywheel1.fastroll()
빠르게 굴러가는 바퀴
>>> mywheel1.roll()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in roll
NotImplementedError: roll 구현 필요
```

### @abstractmethod

추상화 클래스는 해당 모듈이 import 될 때 에러를 발생시킨다. 
또한, 추상화 클래스는 해당 함수를 호출하지 않아도 미구현 에러가 발생한다. 

```python
from abc import ABCMeta, abstractmethod

class BaseWheel2(metaclass=ABCMeta):
    @abstractmethod
    def roll(self):
        pass

class MyWheel2(BaseWheel2):
    def fastroll(self):
        print('빠르게 굴러가는 바퀴')
```

```
>>> mywheel2 = MyWheel2()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: Can't instantiate abstract class MyWheel2 with abstract methods roll
>>> mywheel2 = MyWheel2().fastroll()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: Can't instantiate abstract class MyWheel2 with abstract methods roll
```
