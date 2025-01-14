---
layout: post
title: 정적 크롤링 - CSS Selector
date: 2022-09-23
category: Web
use_math: true
---

### CSS selector

CSS 형식을 통해서 정적 크롤링을 수행할 수도 있다. CSS selector가 크롤링과 파싱에 유리한 이유는 웹을 만들떄 개발자들은 CSS Selector 를 직접 활용해서 이름 붙혀 만들기 때문이다. (Human readable, 사람이 읽기 좋은, 이해하기 편한 이름) 아래는 네이버에서 미국 환율을 가져오는 예제이다. 

```python
import requests as req
from bs4 import BeautifulSoup as BS


# css selector로 미국 환율 가져오기 (해당 iframe만 가져와야함)
url = "https://finance.naver.com/marketindex/exchangeList.naver"
res = req.get(url)
soup = BS(res.text, "html.parser")

tds = soup.find_all("td")

names = [] # 통화명
for td in soup.select("td.tit"): # <td class='tit'> 가져오기
    names.append(td.get_text(strip=True))

prices = []
for td in soup.select("td.sale"):
    prices.append(td.get_text(strip=True))

print(names)
print(prices)
```

CSS를 가져오는 방식은 아래와 같다.

- Element type 방식: a, div, spane 등의 태그명으로 가져오기
- ID 방식: 특정 태그가 가지고 있는 고유한 ID로 가져오기
- class 방식: class 명으로 가져오기
- 고급 한정자 방식: n번째 <a> 태그 가져오기 처럼 위치를 한정지어서 가져오기


---

### Element type 방식

document.querySelector는 특정 태그를 가지는 첫번째 것만 보여주고, document.querySelectorAll은 특정 태그를 가지는 모든 결과를 다 보여준다. 

![image](https://user-images.githubusercontent.com/61526722/193189035-c53b4e34-fbed-4fbb-a98b-79e37167396c.png)

### ID 방식

ID는 주민등록번호(Social ID) 등 유일한 번호나 값을 의미하며, HTML 상에서도 특정 Element 의 유일성을 보장하기 위해서 쓰인다. <HTML tag명>#<ID> 로 특정 ID를 가지는 것을 가지고 올 수 있다.

![image](https://user-images.githubusercontent.com/61526722/193189368-235f4a5e-a74b-4824-8f4f-eb9067a794ce.png)

### Class 방식

Class 는 HTML element의 그룹으로 여러 HTML element에서 쓰인다. HTML에서 class는 띄어쓰기로 구분하여 여러개를 나열한다. class selector는 document.querySelector("<태그명>.<class name1>.<class name2>") 와 같이 마침표로 여러개를 나열하면 된다. 

![image](https://user-images.githubusercontent.com/61526722/193189880-3d3d2bd3-f86d-4fc6-9982-2e8027a56e79.png)

### Attribute 방식

Attribute는 HTML element의 속성으로 id나 class도 하나의 attribute이다. img의 attribute는 대표적으로 height와 width가 있다. https://www.w3schools.com/tags/ref_attributes.asp 를 참고하여 각 태그에 대한 attribute를 확인할 수 있다.

- *= : 포함
- ^= : ~ 으로 시작
- $= : ~ 으로 끝남

![image](https://user-images.githubusercontent.com/61526722/193190377-60184672-3ae9-414f-83a5-dc21a66728d2.png)

### 한정자 방식

한정자 방식은 노드들의 위치나 관계에 따라서 선택하는 방식이다. 

- *: 모든 노드들
- div, p: div 와 p 노드들
- div p: div 안에 있는 p 노드들
- div > p: div 바로 안에 있는 p 노드들
- div ~ p: p 옆(앞)에 있는 div 노드들
- div + p: div 옆(뒤)에 있는 p 노드들


![image](https://user-images.githubusercontent.com/61526722/193190976-aff884a3-db99-43df-86e1-758a65298dc3.png)

### 고급 한정자 

- :enabled 활성화된 상태
- :checked 체크 된 상태
- :disabled 비활성화 된 상태
- :empty 값이 비어 있는 상태
- :first-child 첫번째 자식
- :last-child 마지막 자식
- :first-of-type 해당 타입의 첫번째 노드
- :last-of-type 해당 타입의 마지막 노드
- :hover 마우스가 올라간 상태
- :not 다음 조건이 거짓일 경우 
- :nth-child n 번째 자식
- :nth-of-type n 번째 타입

![image](https://user-images.githubusercontent.com/61526722/193192458-1e9daf15-b70b-4aff-b68e-bb5fbaac164b.png)

아래는 네이버 쇼핑하기에서 상품명을 가져오는 예제이다. 

```python
from bs4 import BeautifulSoup as BS
import requests as req

url = "https://search.shopping.naver.com/search/all?where=all&frm=NVSCTAB&query=%EC%95%84%EC%9D%B4%ED%8F%B0+14"
res = req.get(url)
soup = BS(res.text, 'html.parser')

# list_basis class를 가지고 있는 ul 태그중 div 바로 아래 a 태그 중 첫번째만 가지고 오기
# title이라는 attribute가 있어야 함
arr = soup.select("ul.list_basis div>a:first-child[title]")
for a in arr:
    print(a.get_text(strip=True))
```

![image](https://user-images.githubusercontent.com/61526722/193195822-4efc3ce0-8fbd-4d7d-8387-ed3f64f11fec.png)

다음예시로 쿠팡에서 품목명을 가지고 와보자.

```python
from bs4 import BeautifulSoup as BS
import requests as req

url = "https://www.coupang.com/np/search?component=&q=%EB%85%B8%ED%8A%B8%EB%B6%81&channel=user"
# 사용자 식별을 해주는 header를 넣어줘야 함
res = req.get(url, headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"})
soup = BS(res.text, 'html.parser')

arr = soup.select('div.name')
for a in arr:
    print(a.get_text(strip=True))

# 광고 제외한 품목명 가져오기
for desc in soup.select("div.desciptions-inner"):
    ads = desc.select("span.ad-badge")
    if len(ads) > 0: # 광고인 경우
        print('광고!')
    print(desc.select("div.name")[0].get_text(strip=True))
```

![image](https://user-images.githubusercontent.com/61526722/193196751-40c41956-8241-434d-b2e2-3ae8beb5cdd2.png)

---

##### (예제) 네이버 인기 상승 종목 주가 가져오기 

```python
from bs4 import BeautifulSoup as BS
import requests as req

url = "https://finance.naver.com/sise/lastsearch2.naver"
res = req.get(url)
soup = BS(res.text, "html.parser")

# 종목명 가져오기
for title in soup.select("a.tltle"):
    print(title.get_text(strip=True))

# 가격 가져오기
for tr in soup.select('table.type_5 tr'): 
    if len(tr.select('a.tltle')) == 0: # tr중 tltle이 없는 것 제외
        continue
    title = tr.select('a.tltle')[0].get_text(strip=True) # 종목명
    price = tr.select('td.number:nth-child(4)')[0].get_text(strip=True) # 현재가: tr에서 number class를 가지면서 4 번째 tr
    change = tr.select('td.number:nth-child(6)')[0].get_text(strip=True) # 등락율
    print(title, price, change)
```

![image](https://user-images.githubusercontent.com/61526722/193202180-0b7bda51-c98d-4b08-954d-10cfd4e8526f.png)

![image](https://user-images.githubusercontent.com/61526722/193200221-c4e419df-da2e-4f11-ab8e-c91dadbbc6c2.png)


---



