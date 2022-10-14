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

### 유저 조회 API 

유저 단 복수 조회 API 작성 및 리스폰스 맵핑을 한다. 

```python
# models/user.py

# 모델에 접근하는 api 만들기

from flask_restx import Namespace, Resource, fields
from myapp.models.user import User as UserModel

ns = Namespace(
    'users', # url
    description='유저 관련 API'
)

user = ns.model('User', {
    'id': fields.Integer(required=True, description='유저 고유 아이디'),
    'user_id': fields.String(required=True, description='유저 아이디'),
    'user_name': fields.String(required=True, description='유저 이름'),
})

# /api/user
@ns.route('')
class UserList(Resource):
    # 데이터 매핑을 위해 넣음
    @ns.marshal_list_with(user, skip_none=True) # data가 null 값이면 key를 아예 지워버리기
    def get(self):
        """유저 복수 조회"""
        data = UserModel.query.all()
        return data

# /api/user/1
@ns.route('/<int:id>')
@ns.param('id', '유저 고유 번호')
class User(Resource):

    @ns.marshal_list_with(user, skip_none=True)
    def get(self, id):
        """유저 단수 조회"""
        data = UserModel.query.get_or_404(id) # id가 없으면 404 에러
        return data
```

```python
# models/__init__.py

from flask import Blueprint
from flask_restx import Api

from myapp.models.user import User
from .user import ns as UserNamespace

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

# Add namespace to Blueprint
api.add_namespace(UserNamespace)
```

`app.config['SWAGGER_UI_DOC_EXPANSION'] = 'list'` 옵션을 넣어주면 저 리스트를 맨날 펼치지 않아도 된다. 

![image](https://user-images.githubusercontent.com/61526722/195859091-1dd6f7f7-a87e-457b-b427-a73462209dcf.png)

![image](https://user-images.githubusercontent.com/61526722/195859010-d07d70cc-469b-4f31-a04f-ed484c490d70.png)

---

### 유저 추가 API 작성 및 리퀘스트 파서

```python
from flask_restx import Namespace, Resource, fields, reqparse
from flask import g
from myapp.models.user import User as UserModel
from werkzeug import security

ns = Namespace(
    'users',
    description='유저 관련 API'
)

user = ns.model('User', {
    'id': fields.Integer(required=True, description='유저 고유 아이디'),
    'user_id': fields.String(required=True, description='유저 아이디'),
    'user_name': fields.String(required=True, description='유저 이름'),
})

# api 호출 시에도 값을 전달 받은 후에 db에 넣어주는 일련의 과정이 필요
post_parser = reqparse.RequestParser()
post_parser.add_argument('user_id', required=True, help='유저 고유 아이디')
post_parser.add_argument('user_name', required=True, help='유저 이름')
post_parser.add_argument('password', required=True, help='유저 패스워드')

@ns.route('')
@ns.response(409, 'User id is already exists.')
class UserList(Resource):

    @ns.marshal_list_with(user, skip_none=True)
    def get(self):
        """유저 복수 조회"""
        data = UserModel.query.all()
        return data

    @ns.expect(post_parser) # post_parser를 이용할 것을 알려주기
    @ns.marshal_list_with(user, skip_none=True)
    def post(self):
        """유저 생성"""
        args = post_parser.parse_args()
        user_id = args['user_id']
        user = UserModel.find_one_by_user_id(user_id)
        if user:
            ns.abort(409)
        user = UserModel(
            user_id=user_id,
            user_name=args['user_name'],
            password=security.generate_password_hash(args['password'])
        )
        g.db.add(user)
        g.db.commit()
        return user, 201


@ns.route('/<int:id>')
@ns.param('id', '유저 고유 번호')
class User(Resource):

    @ns.marshal_list_with(user, skip_none=True)
    def get(self, id):
        """유저 단수 조회"""
        data = UserModel.query.get_or_404(id)
        return data
```

![image](https://user-images.githubusercontent.com/61526722/195861227-80c5d0ec-7c7c-479f-9513-d6c5cd5b0435.png)

