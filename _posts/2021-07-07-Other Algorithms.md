---
layout: post
title: Other Algorithms
date: 2021-07-07
category: Algorithm
use_math: true
---

이번에는 소수 판별, 순열, 조합 등의 알고리즘을 살펴본다. 

---

### 1. 에라토스테네스의 체

에라토스테네스의 체는 여러 개의 수가 소수가 아닌지를 판별할 때 사용하는 알고리즘이다. 에라토스테네스의 체는 N보다 작거나 같은 모든 소수를 찾을 때 사용된다. 

> ① 2부터 N까지 모든 자연수를 나열한다. 
> 
> ② 남은 숫자들 중에서 아직 처리하지 않은 가장 작은 수 i를 찾는다. 
> 
> ③ 남은 수 중에서 i의 배수를 모두 제거한다. (i는 제거 하지 않는다.)
> 
> ④ 더 이상 반복할 수 없을 때까지 2,3번을 반복한다.

코드는 다음과 같다. 

```python
import math

n = int(input())
array = [True for _ in range(n+1)]  # 모든 수가 소수라는 의미로 True로 초기화

# 에라토스테네스의 체
for i in range(2, int(math.sqrt(n))+1):  # 2부터 n의 제곱근까지만 확인
    if array[i] == True:  # array[i]가 소수인 경우
        mul = 2  # x2, x3, x4... 로 배수 지우기
        while i*mul <= n:
            array[i*mul] = False
            mul += 1
            
# 모든 소수 출력
for i in range(2, n+1):
    if array[i]:
        print(i, end=' ')
        
'''
21
2 3 5 7 11 13 17 19 
'''
```
에라토스테네스 체의 시간 복잡도는 O(NloglogN)이다. 

---

### 2. 투 포인터

투 포인터 알고리즘은 리스트에 순차적으로 접근할 때 2개의 점 위치를 기록하면서 처리하는 알고리즘이다. 예를 들어 1,2,3,4,5,6,7,8을 말할 때 1번 부터 8번까지의 숫자라고 부르는 것과 같이 시작점과 끝점 2개의 점으로 접근할 데이터의 범위를 말할 수 있다.

#### 부분 연속 수열 찾기

투 포인터 알고리즘은 부분 연속 수열 찾기 문제를 풀때 활용된다. 과정은 다음과 같다. 

> ① 시작점(start)와 끝점(end)가 첫번째 원소(index=0)를 가리키도록 한다. 
> 
> ② 현재 부분합이 M과 같다면 카운트한다.
> 
> ③ 현재 부분합이 M보다 작으면 end를 1 증가시킨다.
> 
> ④ 현재 부분합이 M보다 크거나 같으면 start를 1증가시킨다. 
> 
> ⑤ 모든 경우를 확인할 때까지 2~4번 과정을 반복한다. 

주의할 점은 <mark>리스트 내 원소가 모두 양수일 때만 적용 가능</mark>하다. 그 이유는 start를 1키우면 부분 합이 작아질 수 밖에 없고, end를 1 줄이면 부분 합이 커질 수 밖에 없다.  

```python
data = [1,2,3,2,5]
target = 5  # 찾으려는 부분합

count = 0  # 조건을 만족하는 부분 연속 수열 개수
interval_sum = 0  # 부분 합
end = 0 

# start를 증가시키며 반복
for start in range(len(data)):
    while interval_sum < target and end < len(data):
        interval_sum += data[end]
        end += 1
    if interval_sum == target:
        count += 1
    interval_sum -= data[start]
    
print(count)
# 5
```
#### 정렬되어 있는 두 리스트의 합집합

투 포인터 알고리즘은 정렬되어 있는 두 리스트의 합집합 문제에도 적용할 수 있다. 방법은 다음과 같다.

> ① 정렬된 리스트 A와 B를 입력받는다.
> 
> ② 리스트 A에서 처리되지 않은 원소 중 가장 작은 원소를 i가 가리키도록 한다. 
> 
> ③ 리스트 A에서 처리되지 않은 원소 중 가장 작은 원소를 j가 가리키도록 한다. 
> 
> ④ A[i]과 B[j] 작은 작은 원소를 결과 릿흐트에 담는다.
> 
> ⑤ 두 리스트에 더 이상 처리할 원소가 없을 때까지 2~4번 과정을 반복한다. 

```python
a = [1,3,5]
b = [2,3,6,8]
n ,m = len(a), len(b)

result =[0] * (n+m)  # 합집합 리스트 초기화
i = 0  # 리스트 a의 포인터
j = 0  # 리스트 b의 포인터
k = 0  # 합집합 리스트의 포인터

while i<n or j<m:
    if j >= m or (i<n and a[i] <= b[j]):  # 리스트 b의 모든 원소가 처리되었거나 a[i] <= b[j]일때
        result[k] = a[i] 
        i += 1
    else:  # 리스트 a의 모든 원소가 처리되었거나 a[i] > b[j]일 때
        result[k] = b[j]
        j += 1
    k += 1
    
for i in result:
    print(i, end=' ')
# 1 2 3 3 5 6 8 
```
이 알고리즘은 단순히 각 리스트의 모든 원소를 한번씩 순회하면 되기 때문에 O(N+M)의 시간 복잡도를 가진다. 

---

### 3. 구간 합 바르게 계산하기

구간 합 문제는 연속적으로 나열된 N개의 수가 있을 때 특정 구간의 모든 수를 합한 값을 수하는 문제이다. 구간 합을 계산하기 위해 접두사 합(prefix sum)을 가장 많이 사용한다. <mark>접두사 합은 리스트의 맨 앞부터 특정 위치까지의 합</mark>을 말한다. 접두사 합을 사용한 구간 합 계산 알고리즘은 다음과 같다.

> ① N개의 수에 대해 접두사  합을 계산해 새로운 배열P에 저장한다. 
> 
> ② [left, right]까지의 합을 구할 때는 P[right]-P[left-1]을 하면 된다. 

이렇게 하면 매 쿼리당 계산 시간은 O(1)으로 N개의 데이터와  M개의 쿼리가 있을 때, 전체 구간 합을 모두 계산하는 작업은 <mark>O(N+M)</mark>의 시간이 걸린다. 

```python
n = 5
data = [1,2,3,4,5]

# 접두사 합 배열 만들기
sum_value = 0
prefix_sum =[0]
for i in data:
    sum_value += i
    prefix_sum.append(sum_value)

# 3번째 부터 5번째 수 구하기
left = 3
right = 5
print(prefix_sum[right] - prefix_sum[left-1])
# 12
```

---
### 4. 순열과 조합

#### 순열

순열은 서로 다른 n개에서 r개를 선택하여 일렬로 나열하는 것이다.

```python
from itertools import permutations 

data = [1,2,3]

for x in permutations(data,2):
    print(list(x))
    
'''
[1, 2]
[1, 3]
[2, 1]
[2, 3]
[3, 1]
[3, 2]
'''
```

#### 조합

조합은 서로 다른 n개에서 순서에 상관없이 r개를 선택하여 나열하는 것이다.

```python
from itertools import combinations 

data = [1,2,3]

for x in combinations(data,2):
    print(list(x))
    
'''
[1, 2]
[1, 3]
[2, 3]
'''
```
