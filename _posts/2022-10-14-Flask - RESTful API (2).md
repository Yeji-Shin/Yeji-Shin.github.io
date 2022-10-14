---
layout: post
title: Flask - RESTful API (2)
date: 2022-10-14
category: Flask
use_math: true
---

API 문서자동화를 위해 Flask RESTX로 재사용 가능한 네임스페이스형 API 정의해본다.

### Flask RESTX로 재사용 가능한 네임스페이스형 API 정의

먼저 Flask resetx 를 설치한다.

```
pip install flask-restx==0.2.0
```

```python
from flask import Blueprint
from flask_restx import Api

blueprint = Blueprint(
    'api',
    __name__,
    url_prefix='/api'
)

api = Api(
    blueprint,
    title='Myapp API',
    version='1.0',
    doc='/docs',
    description='Welcome My API docs',
)
```

다음으로 네임스페이스 처리 및 블루프린트를 등록한다.

```python
from flask import Flask, render_template, g
from flask_wtf.csrf import CSRFProtect

from myapp.routes import auth_route, base_route
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


csrf = CSRFProtect()
db = SQLAlchemy()
migrate = Migrate()

def create_app():
    print('---- Run create_app ')

    app = Flask(__name__)

    app.config['SECRET_KEY'] = 'secretkey'
    app.config['SESSION_COOKIE_NAME'] = 'mycookie' 
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql:///root:password@localhost/mydb?charset=utf8'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False 

    if app.config['DEBUG']:
        app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 1

    # csrf init
    csrf.init_app(app)
 
    # DB init
    db.init_app(app)
    if app.config['SQLALCHEMY_DATABASE_URI'].startswith('sqlite'):
        migrate.init_app(app, db, render_as_batdh=True)
    else:
        migrate.init_app(app, db)

    # blueprint 연결
    app.register_blueprint(base_route.bp)
    app.register_blueprint(auth_route.bp)

    # restx init
    from myapp.apis import blueprint as api
    app.register_blueprint(api)

    @app.errorhandler(404)
    def page_404(error):
        return render_template('404.html'), 404

    return app
```

![image](https://user-images.githubusercontent.com/61526722/195835109-f0ee5873-c25f-4287-a7c4-24c1d7c28f15.png)

이제 기본적인 API 만들기는 끝이 났다. 

---

### API 문서자동화

유저 단 복수 조회 API 작성 및 리스폰스 맵핑을 한다. 
