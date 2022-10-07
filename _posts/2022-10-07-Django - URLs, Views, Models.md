---
layout: post
title: Django - URLs, Views, Models
date: 2022-10-07
category: Django
use_math: true
---


### URLs

URL에 요청이 들어오면 그 path를 가지고 어디로 보낼지 어떤 함수를 실행시킬지 정해주는 코드를 보자. 

```python
from django.contrib import admin
from django.urls import path
from shortner.views import index, redirect_test

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", index, name="index"),
    path("redirect", redirect_test),
]
```

root path는 index가 되고, <path>/redirect는 redirect_test를 실행하라는 의미이다. HTML을 렌더링해야 하니깐 간단한 HTML을 아래와 같이 짜서 실행해본다. 


```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>FastCampus Django</title>
    </head>
    <body>
        {{ welcome_msg }}
    </body>
</html>
```

장고의 template에서는 {{}}를 써줘야한다. 그러면 장고 render 함수에 포함되어 있는 값이 template으로 넘어오면서 치환된다. templates 이라는 폴더를 인식하게 하기 위해 setting.py에서 DIRS를 추가해줘야 한다. 

![image](https://user-images.githubusercontent.com/61526722/194522854-1b26a9be-6593-484d-b675-0b9c95a2b535.png)


### Views

```python
from shortner.models import Users
from django.shortcuts import redirect, render

# Create your views here.
def index(request):
    # 장고 ORM: Users 테이블에서 username이 admin인 것을 필터해서 첫번째 것을 가지고 와라
    user = Users.objects.filter(username="admin").first()
    # user가 있으면 user.eamil을 줘라
    email = user.email if user else "Anonymous User!"
    print(email)
    # 로그인이 되어있는지 확인
    print(request.user.is_authenticated)
    if request.user.is_authenticated is False:
        email = "Anonymous User!"
    print(email)
    return render(request, "base.html", {"welcome_msg": "Hello FastCampus!"})

# request를 쓰지 않지만 써줘야함
def redirect_test(request):
    print("Go Redirect")
    return redirect("index_1")
```

redirect 함수는 index라는 함수로 redirect를 하는 것이 아니라, url의 name이 index인 것으로 redirect를 하는것이다. 

```bash
$ python manage.py runserver
```

