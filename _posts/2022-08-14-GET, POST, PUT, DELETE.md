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

```powershell
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

```powershell
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

POST 메소드는 CREATE에 해당된다. 서버에 데이터를 저장하고 싶을 때 사용한다. FastAPI에서 POST 메소드를 작성할 때는 pydanctic 이라는 스키마 디펜던시가 있다. 따라서 pydantic 에서 제공하는 BaseModel 상속없이는 POST 메소드를 작성할 수 없다. 


```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    user_id: str
    password: str

@app.post('/register')
async def register(user: User):
    return user
```

```powershell
(fastapi) PS D:\workspace> http :8000/register user_id=syj password=1234
HTTP/1.1 200 OK
content-length: 35
content-type: application/json
date: Sun, 14 Aug 2022 08:56:05 GMT        
server: uvicorn

{
    "password": "1234",
    "user_id": "syj"
}
```

---

## PUT, PATCH

PUT과 PATCH 메소드는 UPDATE에 해당한다. PUT은 전체 내용을 바꾸고, PATCH는 일부의 내용을 바꾼다. 

### PUT 

```python
from datetime import date
from typing import Optional

from pydantic import BaseModel, Field

from fastapi import FastAPI

user_db = {
    'jack': {'username': 'jack', 'date_joined': '2021-12-01', 'location': 'New York', 'age': 28},
    'jill': {'username': 'jill', 'date_joined': '2021-12-02', 'location': 'Los Angeles', 'age': 19},
    'jane': {'username': 'jane', 'date_joined': '2021-12-03', 'location': 'Toronto', 'age': 52}
}


class User(BaseModel):
    username: str
    date_joined: Optional[date] = None
    location: Optional[str] = None
    age: int = Field(None, gt=5, lt=130)


class UserUpdate(User):
    date_joined: Optional[date] = None
    age : int = Field(None, gt=5, lt=130)


app = FastAPI()

@app.get('/users/{username}')
def get_users_path(username: str):
    return user_db[username]

@app.put('/users')
async def update_user(user: User):
    username = user.username
    user_db[username] = user.dict()
    return {'message': f'Successfully updated user {username}'}
```

PUT으로 바꾸면 안적은 date_joined과 location 값은 null로 초기화 된다. 

```powershell
(fastapi) PS D:\workspace>http :8000/users/jane
HTTP/1.1 200 OK   
content-length: 76
content-type: application/json
server: uvicorn

{
    "age": 52,
    "date_joined": "2021-12-03",
    "location": "Toronto",
    "username": "jane"
}


(fastapi) PS D:\workspace> http PUT :8000/users username=jane age=99
HTTP/1.1 200 OK
content-type: application/json
date: Sun, 14 Aug 2022 09:36:10 GMT        
server: uvicorn

{
    "message": "Successfully updated user jane"
}


(fastapi) PS D:\workspace> http :8000/users/jane
HTTP/1.1 200 OK
content-length: 63
content-type: application/json
date: Sun, 14 Aug 2022 09:36:24 GMT
server: uvicorn

{
    "age": 99,
    "date_joined": null,
    "location": null,
    "username": "jane"
}
```

### PATCH

```python
from datetime import date
from typing import Optional

from pydantic import BaseModel, Field

from fastapi import FastAPI

user_db = {
    'jack': {'username': 'jack', 'date_joined': '2021-12-01', 'location': 'New York', 'age': 28},
    'jill': {'username': 'jill', 'date_joined': '2021-12-02', 'location': 'Los Angeles', 'age': 19},
    'jane': {'username': 'jane', 'date_joined': '2021-12-03', 'location': 'Toronto', 'age': 52}
}


class User(BaseModel):
    username: str
    date_joined: Optional[date] = None
    location: Optional[str] = None
    age: int = Field(None, gt=5, lt=130)


class UserUpdate(User):
    date_joined: Optional[date] = None
    age : int = Field(None, gt=5, lt=130)


app = FastAPI()

@app.get('/users/{username}')
def get_users_path(username: str):
    return user_db[username]

@app.put('/users')
async def update_user(user: User):
    username = user.username
    user_db[username] = user.dict()
    return {'message': f'Successfully updated user {username}'}

@app.patch('/users')
async def update_user_partial(user: UserUpdate):
    username = user.username
    user_db[username].update(user.dict(exclude_unset=True))
    return {'message': f'Successfully updated user {username}'}
```

PATCH는 기존 데이터는 그대로 두고 우리가 바꾸고자 하는 데이터만 바꿔주는 것을 확인할 수 있다.

```powershell
(fastapi) PS D:\workspace> http PATCH :8000/users username=jane age=99
HTTP/1.1 200 OK
content-length: 44
content-type: application/json
date: Sun, 14 Aug 2022 09:39:52 GMT
server: uvicorn

{
    "message": "Successfully updated user jane"
}


(fastapi) PS D:\workspace> http :8000/users/jane
HTTP/1.1 200 OK
content-length: 76
content-type: application/json
date: Sun, 14 Aug 2022 09:40:04 GMT
server: uvicorn

{
    "age": 99,
    "date_joined": "2021-12-03",
    "location": "Toronto",
    "username": "jane"
}
```

---

## DELETE

DELETE 메소드는 삭제하는 메소드이다. 

```python
from datetime import date
from typing import Optional

from pydantic import BaseModel, Field

from fastapi import FastAPI

user_db = {
    'jack': {'username': 'jack', 'date_joined': '2021-12-01', 'location': 'New York', 'age': 28},
    'jill': {'username': 'jill', 'date_joined': '2021-12-02', 'location': 'Los Angeles', 'age': 19},
    'jane': {'username': 'jane', 'date_joined': '2021-12-03', 'location': 'Toronto', 'age': 52}
}


class User(BaseModel):
    username: str
    date_joined: Optional[date] = None
    location: Optional[str] = None
    age: int = Field(None, gt=5, lt=130)


class UserUpdate(User):
    date_joined: Optional[date] = None
    age : int = Field(None, gt=5, lt=130)


app = FastAPI()

@app.get('/users')
def get_users_query(limit: int = 10):
    user_list = list(user_db.values())
    return user_list[:limit]

@app.delete('/users/{username}')
async def delete_user(username: str):
    del user_db[username]
    return {'message': f'Successfully deleted user {username}'}
```

다음과 같이 jane의 데이터를 삭제할 수 있다. 

```powershell
(fastapi) PS D:\workspace> http GET :8000/users  
HTTP/1.1 200 OK
content-length: 237
content-type: application/json
date: Sun, 14 Aug 2022 09:45:12 GMT
server: uvicorn

[
    {
        "age": 28,
        "date_joined": "2021-12-01",
        "location": "New York",
        "username": "jack"
    },
    {
        "age": 19,
        "date_joined": "2021-12-02",
        "location": "Los Angeles",
    },
    {
        "age": 52,
        "date_joined": "2021-12-03",
        "location": "Toronto",
        "username": "jane"
    }
]


(fastapi) PS D:\workspace> http DELETE :8000/users/jane
HTTP/1.1 200 OK
content-length: 44
content-type: application/json
date: Sun, 14 Aug 2022 09:45:38 GMT
server: uvicorn

{
    "message": "Successfully deleted user jane"  
}


(fastapi) PS D:\workspace> http GET :8000/users  
HTTP/1.1 200 OK
content-length: 160
content-type: application/json
date: Sun, 14 Aug 2022 09:45:42 GMT
server: uvicorn

[
    {
        "age": 28,
        "date_joined": "2021-12-01",
        "location": "New York",
        "username": "jack"
    },
    {
        "age": 19,
        "date_joined": "2021-12-02",
        "location": "Los Angeles",
        "username": "jill"
    }
]
```



---

## (참고) 에러 처리

```python
from datetime import date
from typing import Optional

from pydantic import BaseModel, Field

from fastapi import FastAPI, HTTPException, status

user_db = {
    'jack': {'username': 'jack', 'date_joined': '2021-12-01', 'location': 'New York', 'age': 28},
    'jill': {'username': 'jill', 'date_joined': '2021-12-02', 'location': 'Los Angeles', 'age': 19},
    'jane': {'username': 'jane', 'date_joined': '2021-12-03', 'location': 'Toronto', 'age': 52}
}


class User(BaseModel):
    username: str
    date_joined: Optional[date] = None
    location: Optional[str] = None
    age: int = Field(None, gt=5, lt=130)


app = FastAPI()

@app.post('/users')
def create_user(user: User):
    username = user.username
    if username in user_db:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=f'Cannot create user. Username {username} already exists')
    user_db[username] = user.dict() 
    return {'message': f'Successfully created user: {username}'}
```

```powershell
(fastapi) PS D:\workspace> http POST :8000/users 
username=jane age=100
HTTP/1.1 409 Conflict
content-length: 61
content-type: application/json
date: Sun, 14 Aug 2022 10:03:35 GMT
server: uvicorn

{
    "detail": "Cannot create user. Username jane 
already exists"
}
```

---

참고링크: https://github.com/liannewriting/YouTube-videos-public/blob/main/fastapi-python-tutorial-intro/fastapi-python-tutorial-2022-final.py









