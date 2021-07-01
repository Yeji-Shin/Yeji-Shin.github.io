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





























