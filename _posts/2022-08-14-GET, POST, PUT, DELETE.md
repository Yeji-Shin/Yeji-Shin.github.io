---
layout: post
title: GET, POST, PUT, DELETE
date: 2022-08-14
category: FastAPI
use_math: true
---

## GET

REST API는 GET 부터 시작된다. GET 메소드는 서버로부터 정보를 가져올 때사용하는 READ API이다. 

### route 이용

route 메소드를 이용하면 string type의 데이터만 반환할 수 있다. 따라서 route를 이용한 GET 메소드는 서버가 제대로 동작하는지 확인하는 health check 용도로 적합하다.

```python
from fastapi import FastAPI

app = FastAPI()

@app.get('/healthcheck')
async def health_check():
    return 'OK'
```

```
(fastapi) PS D:\workspace> http :8000/healthcheck
HTTP/1.1 200 OK  
content-length: 4
content-type: application/json
date: Sun, 14 Aug 2022 08:32:54 GMT        
server: uvicorn

"OK"
```

### get 이용

GET 메소드는 다양한 자료형을 반환할 수 있다. JSONResponse 객체를 이용해 dict 자료형을 JSON 으로 변환할 수 있다. 

```python
import uuid

from starlette.responses import JSONResponse

from fastapi import FastAPI

app = FastAPI()

@app.get('/{name}')
async def create_id(name: str):
    result = JSONResponse({'id': str(uuid.uuid4()), 'name': name})
    return result
```

```
(fastapi) PS D:\workspace> http :8000/syj  
HTTP/1.1 200 OK
content-length: 58
content-type: application/json
date: Sun, 14 Aug 2022 08:39:02 GMT        
server: uvicorn

{
    "id": "912bf37d-aa6b-4b89-8189-b6265348b6da",
    "name": "syj"
}
```

---

## POST

POST 메소드는 CREATE에 해당된다. 서버에 데이터를 저장하고 싶을 때 사용한다. 













