---
layout: post
title: Flask - Configs
date: 2022-10-14
category: Flask
use_math: true
---

### config 분리

configs.py 파일을 만들어서 환경별 Flask config 설정을 분리할 수 있다. 

```python
class Config(object):
    """Flask Config"""

    SECRET_KEY = 'secret'
    SESSION_COOKIE_NAME = 'mycookie'
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:password@localhost/myapp?charset=utf8'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SWAGGER_UI_DOC_EXPANSION = 'list'


class DevelopmentConfig(Config):
    """Flask Config for Dev"""
    DEBUG=True
    SEND_FILE_MAX_AGE_DEFAULT = 1
    TEMPLATES_AUTO_RELOAD = True
    # TODO: Front호출시 토큰 삽입
    WTF_CSRF_ENABLED = False


class ProductionConfig(Config):
    """Flask Config for Production"""
    pass
```

이렇게 환경별로 분리를 한 다음에 `__init__.py`에서 이 config.py를 불러와서 사용하면 된다. ㄷ

```python
# __init__.py

from flask import Flask, render_template, g
from flask_wtf.csrf import CSRFProtect
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

csrf = CSRFProtect()
db = SQLAlchemy()
migrate = Migrate()

# flask run -> create_app()
def create_app(config=None):
    print('run: create_app()')
    app = Flask(__name__)

    """ Flask Configuration """
    from .configs import DevelopmentConfig, ProductionConfig
    if not config:
        if app.config['DEBUG']:
            config = DevelopmentConfig()
        else:
            config = ProductionConfig()

    print('run with: ', config)
    app.config.from_object(config)
```

이렇게 config를 따로 빼면 더 확장성 있게 flask를 관리할 수 있다.
