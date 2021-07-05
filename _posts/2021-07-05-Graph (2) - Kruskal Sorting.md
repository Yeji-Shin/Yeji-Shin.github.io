---
layout: post
title: Graph (2) - Kruskal Sorting
date: 2021-07-05
category: Algorithm
use_math: true
---

DFS/BFS와 최단경로 알고리즘(다익스트라, 플로이드워셜) 모두 그래프 알고리즘의 한 유형으로 볼 수 있다. 이번에는 이것들 외의 그래프 알고리즘인 서로소 집합 알고리즘, 크루스칼 알고리즘, 위상정렬 알고리즘을 살펴본다.

크루스칼은 그리디 알고리즘으로 분류되고, 위상정렬은 큐나 스택을 활용해서 구현한다.

---

### 1. 신장 트리

<mark>신장 트리는 모든 노드를 포함하면서 사이클이 존재하지 않는 부분 그래프</mark>이다. 여기서 모든 노드를 포함하면서 사이클이 존재하지 않는다는 조건은 트리의 조건이다. 

![image](https://user-images.githubusercontent.com/61526722/123957132-6713fa00-d9e6-11eb-8fa2-b1dc01dae9b4.png)

아래 그림에서 왼쪽은 그래프가 노드1을 포함하고 있지 않기 때문에 신장 트리에 해당하지 않는다. 오른쪽은 사이클이 존재하므로 신장 트리가 아니다. 

![image](https://user-images.githubusercontent.com/61526722/123957277-8ca10380-d9e6-11eb-82a3-0f8e3caabf66.png)

---

### 2. 크루스칼 알고리즘 (Kruskal)

최소 신장 트리 알고리즘은 <mark>최소 비용으로 만들 수 있는 신장 트리를 찾는 알고리즘</mark>이다. 크루스칼 알고리즘은 최소 신장 트리 알고리즘 중 하나로 <mark>그리디 알고리즘</mark>으로 분류된다. 모든 간선에 대해 정렬을 수행한 후에 거리가 짧은 간선부터 집합에 포함시키면 된다. 사이클을 발생시키는 간선은 집합에 포함시키지 않는다. 

> ① 간선은 비용에 따라 오름차순으로 정렬한다. 
> 
> ② 간선을 하나씩 확인하며 현재의 간선이 사이클을 발생시키지 않는 경우 최소 신장 트리에 포함한다. 
> 
> ③ 모든 간선에 대해 2번을 반복한다. 

최소 신장 트리의 <mark>간선의 개수 = 노드의 개수 - 1</mark> 이라는 특징이 있다. 다음과 같은 예를 보며 이해해보자. 

![image](https://user-images.githubusercontent.com/61526722/124479561-5ea23180-dde1-11eb-959f-b59ba58ef84b.png)

먼저 간선 비용에 따라 오름차순 정렬을 한다. 

![image](https://user-images.githubusercontent.com/61526722/124479587-6366e580-dde1-11eb-8e6d-6c783f0e85bc.png)

가장 짧은 간선을 (3,4)를 선택하고 집합에 포함한다. 즉, 3번 노드와 4번 노드에 대해 union함수를 수행한다. 

![image](https://user-images.githubusercontent.com/61526722/124479747-87c2c200-dde1-11eb-9f6e-f97f16286acc.png)

그 다음 비용이 작은 (4,7)을 선택하고, 4번과 7번 노드는 같은 집합에 속해있지 않기 때문에 union함수를 수행한다. 

![image](https://user-images.githubusercontent.com/61526722/124479737-84c7d180-dde1-11eb-9c6c-9840ce5cfffd.png)

그 다음 비용이 작은 (4,6)을 선택하고, 4번과 7번 노드는 같은 집합에 속해있지 않기 때문에 union함수를 수행한다. 

![image](https://user-images.githubusercontent.com/61526722/124479779-914c2a00-dde1-11eb-97e1-303a59822def.png)

그 다음 비용이 작은 (6,7)을 선택하고, 6번과 7번 노드의 루트가 같은 집합에 속해있기 때문에 건너뛴다.

![image](https://user-images.githubusercontent.com/61526722/124479781-9315ed80-dde1-11eb-9d59-cbfd45e3711b.png)

그 다음 비용이 작은 (1,2)을 선택하고, 1번과 2번 노드는 같은 집합에 속해있지 않기 때문에 union함수를 수행한다. 

![image](https://user-images.githubusercontent.com/61526722/124479829-9d37ec00-dde1-11eb-83cd-b62975a31ce7.png)

그 다음 비용이 작은 (2,6)을 선택하고, 2번과 6번 노드는 같은 집합에 속해있지 않기 때문에 union함수를 수행한다. 

![image](https://user-images.githubusercontent.com/61526722/124479835-9e691900-dde1-11eb-90d8-349c86fcb38a.png)

그 다음 비용이 작은 (2,3)을 선택하고, 2번과 3번 노드의 루트가 같은 집합에 속해있기 때문에 건너뛴다.

![image](https://user-images.githubusercontent.com/61526722/124479856-a3c66380-dde1-11eb-9dd5-e0d4cb5f0e79.png)

그 다음 비용이 작은 (5,6)을 선택하고, 5번과 6번 노드는 같은 집합에 속해있지 않기 때문에 union함수를 수행한다. 

![image](https://user-images.githubusercontent.com/61526722/124479864-a628bd80-dde1-11eb-8da9-ae56dbd0a9a0.png)

그 다음 비용이 작은 (1,5)을 선택하고, 1번과 5번 노드의 루트가 같은 집합에 속해있기 때문에 건너뛴다.

![image](https://user-images.githubusercontent.com/61526722/124479895-ab860800-dde1-11eb-88ae-0e98305fea09.png)

결과적으로 다음 그림과 같이 최소 신장 트리가 만들어진다.

![image](https://user-images.githubusercontent.com/61526722/124479897-acb73500-dde1-11eb-81b9-a7df8509c864.png)

여기서 간선의 비용만 모두 더하면 그 값이 최종 비용이 된다. 

---
### 3. Kruskal with Python

```python

```











