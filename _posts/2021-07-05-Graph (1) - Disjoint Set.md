---
layout: post
title: Graph (1) - Disjoint Set
date: 2021-07-05
category: Algorithm
use_math: true
---

DFS/BFS와 최단경로 알고리즘(다익스트라, 플로이드워셜) 모두 그래프 알고리즘의 한 유형으로 볼 수 있다. 이번에는 이것들 외의 그래프 알고리즘인 서로소 집합 알고리즘, 크루스칼 알고리즘, 위상정렬 알고리즘을 살펴본다.

크루스칼은 그리디 알고리즘으로 분류되고, 위상정렬은 큐나 스택을 활용해서 구현한다.

---

### 1. 서로소 집합 알고리즘

서로소 집합은 공통 원소가 없는 두 집합을 의미한다. 집합 {1,2}와 {3,4}는 서로소이고, {1,2}와 {2,3}은 서로소가 아니다. 서로소 집합 자료구조는 <mark>서로소 부분 집합들로 나누어진 원소들의 데이터를 처리하기 위한 자료구조</mark>이다. 

서로소 집합 자료구조는 union과 find 2개의 연산으로 조작할 수 있다. union은 2개의 집합을 하나의 집합으로 합치는 연산이고, find 연산은 특정 원소가 속한 집합이 어떤 집합인지 알려주는 연산이다. 

---

### 2. 서로소 집합 계산

서로소 집합 자료구조를 구현할 때는 트리 자료구조를 이용해 집합을 표현한다. Union연산은 그래프에서 간선으로 표현될 수 있기 때문이다. 

> ① 합집합(union)연산을 확인해 서로 연결된 노드 A, B를 확인한다.
> 
> ② A, B의 루트 노드 A', B'를 찾아 A'를 B'의 부모 노드로 설정한다. (B'가 A'를 가리키도록 한다) 보통 A' < B'이다.
> 
> ③ 모든 합집합 연산을 처리할 때까지 반복한다. 

만약 전체 집합 {1,2,3,4,5,6}에서 {1,4}, {2,3}, {2,4}, {5,6}의 네가지 union이 있다고 할 때 아래와 같이 표현된다. 일반적으로 서로소 집합을 그림으로 표현할 때는 번호가 큰 노드가 번호가 작은 노드를 간선으로 가리키도록 트리 구조를 표현한다. 

![image](https://user-images.githubusercontent.com/61526722/124467009-3bbc5100-ddd2-11eb-82af-68444b9df758.png)

이 그림을 통해 집합{1,2,3,4}와 집합 {5,6}으로 나누어진다는 것을 볼 수 있다. 이제 union 연산을 하나씩 확인하면서 더 큰 루트 노드가 더 작은 루트 노드를 가리키도록 구현해보자. 


먼저 노드의 개수 크기의 부모 테이블을 초기화한다. 이때 모든 원소가 자기 자신을 부모로 가지도록 설정한다. 그러면 총 6개의 트리가 존재한다고 할 수 있다. 여기서 부모 테이블은 부모 노드에 대한 정보만 담고 있기 때문에 실제로 루트를 확인할 때는 재귀적으로 부모를 거슬러 올라가서 최종적인 루트 노드를 찾아야 한다.

![image](https://user-images.githubusercontent.com/61526722/124467061-4d9df400-ddd2-11eb-820a-bcae3476f217.png)


첫번째 union 연산인 {1,4}가 들어오면 1번 노드의 부모 노드와 4번 노드의 부모 노드중 더 큰 4가 1을 가리키도록 테이블을 수정한다. 

![image](https://user-images.githubusercontent.com/61526722/124467087-57bff280-ddd2-11eb-9b48-8f9a2e4cd482.png)

두 번째 union 연산인 {2,3}가 들어오면 2번 노드의 부모 노드와 3번 노드의 부모 노드중 더 큰 3이 2를 가리키도록 테이블을 수정한다.

![image](https://user-images.githubusercontent.com/61526722/124467114-61495a80-ddd2-11eb-90a4-7822c717041f.png)

다음 union 연산인 {2,4}가 들어오면 2번 노드의 부모 노드(2)와 4번 노드의 부모 노드(1)중 더 큰 2가 1을 가리키도록 테이블을 수정한다.

![image](https://user-images.githubusercontent.com/61526722/124467135-6908ff00-ddd2-11eb-9249-cc8fbdc1140a.png)

마지막 union 연산인 {5,6}가 들어오면 5번 노드의 부모 노드(5)와 6번 노드의 부모 노드(6)중 더 큰 6이 5를 가리키도록 테이블을 수정한다.

![image](https://user-images.githubusercontent.com/61526722/124467167-73c39400-ddd2-11eb-846e-6f66a6beeb81.png)

---

### 3. 서로소 집합 알고리즘 with Python

이렇게 <mark>union 연산을 하기 위해 부모 테이블을 항상 사용해야 하고, 루트 노드를 바로 계산할 수 없어 부모 테이블을 계속 거슬러 올라가 확인해야 한다</mark>. 이를 해결하기 위해 find 함수에서 해당 노드의 루트 노드가 부모 노드가 되도록 <mark>경로 압축 기법</mark>을 사용한다. 

```python
# 특정 원소가 속한 집합 찾기 (루트 찾기) 
def find_parent(parent, x):
    if parent[x] != x:  # x의 루트가 x가 아니면 루트를 찾을 때까지 재귀적 호줄
        parent[x] = find_parent(parent, parent[x])
    return parent[x]  # 경로 압축 방법

# 두 원소가 속한 집합 합치기
def union_parent(parent, a, b):
    a = find_parent(parent, a)
    b = find_parent(parent, b)
    if a < b:
        parent[b] = a
    else:
        parent[a] = b
        
# union 연산 입력 받기 
v, e = map(int, input().split())  # 노드의 개수 v, 간선의 개수 e
parent = [0] * (v+1)  # 부모 테이블 초기화 
for i in range(1, v+1):
    parent[i] = i  # 부모 테이블에서 부모를 자기 자신으로 초기화
    
# union 연산 수행
for i in range(e):
    a, b = map(int, input().split())
    union_parent(parent,a,b)
    
# 각 원소가 속한 집합 출력 
print('각 원소가 속한 집합: ', end='')
for i in range(1, v+1):
    print(find_parent(parent, i), end=' ')
    
print()

# 부모 테이블 출력
print('부모 테이블: ', end ='')
for i in range(1, v+1):
    print(parent[i], end=' ')
    
'''
6 4
1 4
2 3
2 4
5 6
각 원소가 속한 집합: 1 1 1 1 5 5 
부모 테이블: 1 1 1 1 5 5 
'''
```

---

### 4. 서로소 집합 알고리즘의 시간 복잡도: $O(V+M(1+log_{2-M/V}V))$

경로 압축 방법을 사용한 서로소 집합 알고리즘은 노드의 개수가 V개, 최대 V-1 개의 union 연산, M개의 find연산이 가능할 때 $ O(V+M(1+log_{2-M/V}V))$으 시간 복잡도를 가진다.

---

### 5. 서로소 집합을 활용한 사이클 판별

서로소 집합은 <mark>무방향 그래프에서 사이클을 판별</mark>할 때 사용할 수 있다. (방향 그래프의 사이클 여부는 DFS 사용)

> ① 합집합(union)연산을 확인해 서로 연결된 노드 A, B를 확인한다.
> 
> ② A, B의 루트 노드 A', B'를 찾아 A'를 B'의 부모 노드로 설정한다. (B'가 A'를 가리키도록 한다) 보통 A' < B'이다.
> 
> ③ 모든 합집합 연산을 처리할 때까지 반복한다. 

Union 연산은 그래프의 간선으로 표현될 수 있다고 했다. 따라서 간선을 확인하면서 두 노드가 포함되어 있는 집합을 합치는 과정으로 사이클을 판별할 수 있다. 다음 예시를 보자. 

처음에는 마찬가지로 모든 노드의 부로를 자기자신으로 부모 테이블을 초기화한다.

![image](https://user-images.githubusercontent.com/61526722/124473627-84780800-ddda-11eb-81e9-d81b2719be63.png)

다음으로 간선 (1,2)를 확인하고, 노드 1의 루드 노트(1)과 노드 2의 루트 노드(2) 중 더 큰 2의 부모 노드를 1로 변경한다.

![image](https://user-images.githubusercontent.com/61526722/124473631-8641cb80-ddda-11eb-912c-033472a26781.png)

다음으로 간선 (1,3)를 확인하고, 노드 1의 루드 노트(1)과 노드 3의 루트 노드(3) 중 더 큰 3의 부모 노드를 1로 변경한다.

![image](https://user-images.githubusercontent.com/61526722/124473642-893cbc00-ddda-11eb-9adb-334905892d38.png)

다음으로 간선 (2,3)을 확인하는데, 이때 노드 2의 루드 노트(1)과 노드 3의 루트 노드(1)은 같으므로 사이클이 발생한다는 것을 알수있다. 

![image](https://user-images.githubusercontent.com/61526722/124473650-8b067f80-ddda-11eb-9297-4f307cad3db0.png)

사이클을 판별하는 코드는 다음과 같다.

```python
# 특정 원소가 속한 집합 찾기 (루트 찾기) 
def find_parent(parent, x):
    if parent[x] != x:  # x의 루트가 x가 아니면 루트를 찾을 때까지 재귀적 호줄
        parent[x] = find_parent(parent, parent[x])
    return parent[x]

# 두 원소가 속한 집합 합치기
def union_parent(parent, a, b):
    a = find_parent(parent, a)
    b = find_parent(parent, b)
    if a < b:
        parent[b] = a
    else:
        parent[a] = b
        
# union 연산 입력 받기 
v, e = map(int, input().split())  # 노드의 개수 v, 간선의 개수 e
parent = [0] * (v+1)  # 부모 테이블 초기화 
for i in range(1, v+1):
    parent[i] = i  # 부모 테이블에서 부모를 자기 자신으로 초기화

cycle = False  # 사이클 발생 여부 확인 

# union 연산 수행
for i in range(e):
    a, b = map(int, input().split())
    if find_parent(parent,a) == find_parent(parent,b):  # 사이클 발생한 경우 종료
        cycle = True
        break
    else:  # 사이클 발생하지 않으면 합집합 수행 
        union_parent(parent,a,b)

if cycle:
    print('사이클 발생')
else:
    print('사이클 발생 안함')
    
'''
3 3
1 2
1 3
2 3
사이클 발생
'''
```

---






