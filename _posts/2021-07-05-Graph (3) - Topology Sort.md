---
layout: post
title: Graph (3) - Topology Sort
date: 2021-07-05
category: Algorithm
use_math: true
---

DFS/BFS와 최단경로 알고리즘(다익스트라, 플로이드워셜) 모두 그래프 알고리즘의 한 유형으로 볼 수 있다. 이번에는 이것들 외의 그래프 알고리즘인 서로소 집합 알고리즘, 크루스칼 알고리즘, 위상정렬 알고리즘을 살펴본다.

크루스칼은 그리디 알고리즘으로 분류되고, 위상정렬은 큐나 스택을 활용해서 구현한다.

---

### 1. 위상 정렬

위상 정렬은 <mark>방향 그래프의 모든 노드를 방향성에 거스르지 않도록 순서대로 나열하는 것</mark>이다. 즉, 순서가 정해져 있는 작업을 차례대로 수행해야 할 때 사용하는 알고리즘이다. 위상 정렬은 진입 차수를 사용하는데 진입 차수는 들어오는 간선의 개수를 말한다. 위상 정렬의 알고리즘은 다음과 같다.

> ① 진입 차수가 0인 노드를 큐에 넣는다. 
> ② 큐가 빌 때 까지 큐에서 원소를 꺼내 해당 노드에서 출발하는 간선을 그래프에서 제거하고, 새롭게 진입차수가 0이 된 노드를 큐에 넣는다. 

이때 모든 원소를 방문하기 전에 큐가 비면 사이클이 발생한 것이다. 예시를 살펴보자.

처음에는 진입차수가 0인 1번 노드를 큐에 삽입한다.

![image](https://user-images.githubusercontent.com/61526722/124485911-028edb80-dde8-11eb-8ecd-362f09916d16.png)

먼저 큐에 들어있는 노드 1을 꺼내고, 노드 1과 연결되어 있는 간선들을 제거한다. 그러면 노드 2와 노드 5의 진입차수가 0이 되므로 노드 2와 5를 큐에 삽입한다.

![image](https://user-images.githubusercontent.com/61526722/124486051-2c480280-dde8-11eb-9331-1a2d134cdde0.png)

다음으로 큐에서 노드 2를 꺼내고, 노드 2와 연결되어 있는 간선들을 제거한다. 그러면 노드 3의 진입차수가 0이 되므로 노드 3을 큐에 삽입한다.

![image](https://user-images.githubusercontent.com/61526722/124486156-441f8680-dde8-11eb-805a-b2acbdfd67dc.png)

다음으로 큐에서 노드 5를 꺼내고, 노드 5와 연결되어 있는 간선들을 제거한다. 그러면 노드 6의 진입차수가 0이 되므로 노드 6을 큐에 삽입한다.

![image](https://user-images.githubusercontent.com/61526722/124486235-57caed00-dde8-11eb-8f84-2b213113dc76.png)

다음으로 큐에서 노드 3를 꺼내고, 노드 3와 연결되어 있는 간선들을 제거한다. 이번에는 진입차수가 0이 되는 노드가 없으므로 그냥 넘어간다.

![image](https://user-images.githubusercontent.com/61526722/124486436-91035d00-dde8-11eb-8b12-4a7aeb9327c8.png)


다음으로 큐에서 노드 6를 꺼내고, 노드 6와 연결되어 있는 간선들을 제거한다. 그러면 노드 4의 진입차수가 0이 되므로 노드 4을 큐에 삽입한다.

![image](https://user-images.githubusercontent.com/61526722/124486488-9c568880-dde8-11eb-87fd-4cc6c2857f4b.png)

다음으로 큐에서 노드 4를 꺼내고, 노드 4와 연결되어 있는 간선들을 제거한다. 그러면 노드 7의 진입차수가 0이 되므로 노드 7을 큐에 삽입한다.

![image](https://user-images.githubusercontent.com/61526722/124486557-b09a8580-dde8-11eb-916f-1d141121daaa.png)


다음으로 큐에서 노드 7를 꺼내고, 노드 7와 연결되어 있는 간선들을 제거한다. 이번에는 진입차수가 0이 되는 노드가 없으므로 그냥 넘어간다.

![image](https://user-images.githubusercontent.com/61526722/124486603-bb551a80-dde8-11eb-9d0c-291705c64b6b.png)

이때 큐에서 추출한 순서는 1 ➔ 2 ➔ 5 ➔ 3 ➔ 6 ➔ 4 ➔ 7 이다. 하지만 위상정렬은 <mark>답이 여러가지 존재</mark>한다는 특징이 있다. 1 ➔ 5 ➔ 2 ➔ 3 ➔ 6 ➔ 4 ➔ 7도 답이 될수 있다. 

---

### 2. <mark>Topology Sort with Python - 큐 이용</mark>

위상정렬은 큐 자료구조를 사용한다. 

```python
from collections import deque

v, e = map(int, input().split())  # 노드의 개수 v, 간선의 개수 e
indegree = [0] * (v+1)  # 모든 노드에 대한 진입차수 0으로 초기화
graph = [[] for _ in range(v+1)]  # 그래프 초기화

# 방향 그래프의 모든 간선 정보 입력받기
for _ in range(e):
    a, b = map(int, input().split())
    graph[a].append(b)
    indegree[b] += 1  # b의 진입차수를 1 증가
    
# 위상 정렬 함수
def topology_sort():
    result = []  # 위상 정렬 결과
    q = deque()
    
    # 처음에는 진입차수가 0인 노드를 큐에 삽입
    for i in range(1, v+1):
        if indegree[i] == 0:
            q.append(i)
    
    # 큐가 빌 때까지 반복
    while q:  
        now = q.popleft()  # 큐에서 노드 꺼내기
        result.append(now)
        for nn in graph[now]:
            indegree[nn] -= 1
            if indegree[nn] == 0:  # 새롭게 진입차수가 0이 된 노드를 큐에 삽입
                q.append(nn)
                
    for i in result:
        print(i, end=' ')
    
topology_sort()

'''
7 8
1 2
1 5
2 3
2 6
3 4
4 7
5 6
6 4
1 2 5 3 6 4 7 
'''
```

---

### 3. <mark>위상 정렬 시간 복잡도: O(V+E) </mark>

위상 정렬은 차례대로 V개의 모든 노드를 확인하고, 해당 노드에서 출발하는 간선을 차례대로 제거해야하기 때문에 O(V+E)의 시간 복잡도를 가진다. 즉, 노드와 간선을 한번씩 다 확인한다는 의미이다. 
