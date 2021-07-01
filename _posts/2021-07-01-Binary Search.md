---
layout: post
title: Binary Search
date: 2021-07-01
category: Algorithm
use_math: true
---

이전 문서에서 이진 탐색은 데이터가 정렬된 상태에서 적용가능하다고 했으며 선택 정렬, 삽입 정렬, 퀵 정렬, 계수 정렬을 공부했다. 이번에는 리스트 내에서 데이터를 매우 빠르게 탐색하는 이진 탐색 알고리즘에 대해 알아 본다. 

---

### 1. 순차 탐색 (Sequential Search)

이진 탐색 전에 순차 탐색을 이해해야 한다. 순차 탐색은 리스트 안에 있는 특정한 데이터를 찾기 위해 <mark>앞에서부터 데이터를 하나씩 차례대로 확인</mark>하는 방법이다. 보통 정렬되지 않은 리스트에서 데이터를 찾을 때 사용하며, 리스트 내에 데이터가 아무리 많아도 시간만 충분하다면 항상 원하는 데이터를 찾을 수 있다. 순차 탐색은 다음과 같이 구현할 수 있다. 

```python
# 순차 탐색
def sequential_search(n, target, array):
    for i in range(n):   # 각 원소를 하나씩 앞에서부터 확인
        if array[i] == target:  # 찾고자 하는 원소와 같으면 
            return i+1  # 그 데이터의 위치 반환 (인덱스는 0부터 시작하므로 1 더하기)

# 데이터의 원소 개수와 찾을값을 입력받기
input_data = input().split()
n = int(input_data[0])
target = input_data[1]
# 데이터 입력 받기
array = input().split()

# 순차 탐색 진행
print(sequential_search(n, target, array))

'''
5 c
d f e c s
4
'''
```

순차 탐색은 리스트에 특정 값의 원소가 있는지 체크할 때 사용하고, 리스트 자료형의 count() 메서드를 이용할 때도 내부에서는 순차 탐색이 수행된다. 

#### 시간 복잡도: 최악 O(N)

순차 탐색은 데이터 정렬 여부와 상관없이 가장 앞에 있는 원소부터 하나씩 확인한다. 따라서 데이터의 개수가 N개 일때 최대 N번의 비교 연산이 필요하므로 최악의 경우 시간 복잡도는 O(N)이다. 

---

### 2. 이진 탐색 (Binary Search)

이진 탐색은 <mark>배열이 정렬되어 있어야만 사용</mark>할 수 있다. 이진 탐색은 <mark>찾으려는 데이터와 중간에 있는 데이터를 반복적으로 비교하며 탐색 범위를 절반씩 좁혀가며 데이터를 탐색</mark>한다. 

다음은 정렬된 데이터에서 값이 4인 원소를 찾는 예시이다.

![image](https://user-images.githubusercontent.com/61526722/124065264-5eb4d100-da71-11eb-8a86-9c5868c8e95f.png)

이처럼 이진 탐색을 이용해 총 3번의 탐색으로 원소를 찾을수 있다. 

이진 탐색은 <mark>재귀함수나 반복적 구현</mark> 두 가지 방법으로 구현할 수 있다.

```python
# 재귀적 방법
def binary_search(array, target, start, end):
    if start > end:
        return None
    mid = (start + end) // 2  # 중간점
    # 중간점 = 타겟값이면 해당 위치(인덱스) 반환
    if array[mid] == target:
        return mid
    # 타겟값 < 중간점이면 왼쪽부분 탐색 (end = mid -1로 갱신)
    if target < array[mid]:
        return binary_search(array, target, start, mid -1)
    # 중간점 < 타겟값이면 오른쪽부분 탐색 (start = mid+1 로 갱신)
    else:
        return binary_search(array, target, mid+1, end)

# n(원소의 개수)와 찾을 값(target) 입력받기
n, target = list(map(int, input().split()))
# 배열 입력 받기
array = list(map(int,input().split()))

# 이진 탐색 결과 출력 
result = binary_search(array, target, 0, n-1)
if result == None:
    print('원소가 존재하지 않습니다')
else:
    print(result+1)
    
'''
10 7
1 3 5 7 7 9 11 13 15
5
'''
```

```python
# 반복적 구현
def binary_search(array, target, start, end):
    while start <= end:
        mid = (start+end) // 2
        if array[mid] == target:
            reuturn mid
        if target < array[mid]:
            end = mid - 1
        else:
            start = mid + 1
     return None
     
n, target = list(map(int, input().split()))
array = list(map(int,input().split()))

result = binary_search(array, target, 0, n-1)
if result == None:
    print('원소가 존재하지 않습니다')
else:
    print(result+1)     

'''
10 7
1 3 5 7 9 11 13 15 17 19
4
'''
```

#### 시간 복잡도: O(logN)

이진 탐색은 한번 확인할 때마다 확인하는 원소의 개수가 절반씩 줄어든다. 예를 들어 데이터의 개수가 32개일 때, 1단계 거치면 16개, 2단계 거치면 8개..개량의 데이터만 확인하면 된다. 절반씩 데이터를 줄어들도록 만든다는 것은 퀵 정렬과 공통점이 있다. 

---

### 3. 이진 탐색 트리 (Binary Serach Tree)

이진 탐색 트리는 이진 탐색이 동작할 수 있도로 고한된 자료구조이다. 이진 탐색트리는 <mark>왼쪽 자식 노드 < 부모 노드 < 오른쪽 자식 노드</mark>를 만족한다. 참고용으로 알아두기만 하면 된다.

[참고](https://yeji-shin.github.io/datastructure/2021/07/02/8.-Tree.html)

---

### 4. 빠르게 입력 받기

이진 탐색 문제는 입력 데이터가 많거나 탐색 범위가 매우 넓은 편이다. 데이터의 개수가 1000만개를 넘어가거나 탐색 범위의 크기가 1000억 이상이면 이진 탐색 알고리즈을 의심하자. 우리는 보통 input()으로 입력을 받는데 input()은 동작 속도가 느려서 시간 초과가 뜰 수도 있다. 따라서 input() 대신 sys 라이브러리의 readline()함수를 사용하면 된다.

```python
import sys

input_data = sys.stdin.readline().rstrip()
print(input_data)

'''
Hi
Hi
'''
```

---

### 5. 이진 탐색 라이브러리

파이썬에서는 이진 탐색을 쉽게 구현할 수 있도록 bisect 라이브러리를 제공한다. bisect 라이브러리에서는 bisect_left()와 bisect_right() 함수가 가장 중요하게 사용된다. 이 두 함수는 O(logN)에 동작한다.

- bisect_left(a,x): 정렬된 순서를 유지하면서 배열 a에 x를 삽입할 가장 왼쪽 인덱스를 반환
- bisect_right(a,x): 정렬된 순서를 유지하면서 배열 a에 x를 삽입할 가장 오른쪽 인덱스를 반환

예를 들어 정렬된 리스트 [1, 2, 4, 4, 8]에 4를 넣으려고 하면 다음과 같이 구현하면 된다.

![image](https://user-images.githubusercontent.com/61526722/124067969-768e5400-da75-11eb-88e8-24b8f0c84b72.png)

```python
from bisect import bisect_left, bisect_right

a = [1, 2, 4, 4, 8]
x = 4

print(bisect_left(a,x))
# 2
print(bisect_right(a,x))
# 4
```

그리고 bisect_left와 bisect_right는 <mark>정렬된 리스트에서 특정 범위에 속하는 원소의 개수를 구할 때 사용</mark>될 수 있다. 

```python
from bisect import bisect_left, bisect_right

# 값이 [left_val, right_val] 안에 속해있는 데이터의 개수를 반환
def count_by_range(a, left_val, right_val):
    left_idx = bisect_left(a, left_val)  # left_val의 위치(인덱스)
    right_idx = bisect_right(a, right_val)  # right_val의 위치(인덱스)
    return right_idx - left_idx
    
a = [1,2,3,3,3,3,4,4,8,9]

# 값이 4인 데이터의 개수 출력
print(count_by_range(a, 4,4))
# 2

# 값이 [-1,3] 범위에 있는 데이터 개수 출력
print(count_by_range(a, -1,3))
# 6
```












