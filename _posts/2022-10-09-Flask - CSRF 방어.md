---
layout: post
title: Flask - CSRF 방어
date: 2022-10-09
category: Flask
use_math: true
---

### CSRF

CSRF (Cross Site Request Forgery)의 약자로, 사이트간 요청 위조를 뜻한다. 희생자의 의지와 무관하게 공격자가 의도한 작업이 진행 되게끔 유도하는 해킹방법이다. 예를 들어 버튼을 클릭하면 사용자의 비밀번호가 바뀌는 로직을 타게 만들어 해킹한다.

![image](https://user-images.githubusercontent.com/61526722/194734420-95c7c1ef-7725-40fe-af10-af8f9158f8d1.png)

1. 공격자는 공격용 Web 페이지를 준비하고 사용자가 액세스하도록 유도한다.
2. 사용자가 공격용 Web 페이지에 액세스하면, 미리 준비되어 있던 잘못된 요청이 공격 대상 서버에 보내진다.
3. 공격 대상 서버의 Web 응용 프로그램은 잘못된 요청을 처리하고 사용자가 의도하지 않은 처리를 진행한다.


CSRF를 방지하기 위한 가장 대표적인 방법은 CSRF 토큰 검증이다. CSRF방어가 필요한 요청(쓰기/변경이 가능한 엔드포인트 및 메서드들) 들마다 특정 토큰을 포함시켜서 요청하여 서버에서 비교하는 방식이다. 토큰이 다를 경우에는 이 요청이 잘못되었다고 판단하는 것이다. 

---

### Flask WTF을 이용한 CSRF 공격 조치

```bash
$ pip install flask-wtf
```

```python
from flask import Flask
from flask import render_template
from flask_wtf.csrf import CSRFProtect
from myapp.forms.auth_form import LoginForm, RegisterForm

csrf = CSRFProtect()

def create_app():
    print('---- Run create_app ')

    app = Flask(__name__)

    # wtf는 secret key가 무조건 등록되어 있어야 함 (csrf token이 암호화 되어 있기 때문)
    app.config['SECRET_KEY'] = 'secretkey'

    if app.config['DEBUG']:
        app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 1

    # csrf init
    csrf.init_app(app)

    @app.route('/')
    def index():
        return render_template('index.html')

    @app.route('/auth/login')
    def login():
        form = LoginForm()
        return render_template('login.html', form=form)

    @app.route('/auth/register')
    def register():
        form = RegisterForm()
        return render_template('register.html', form=form)

    @app.route('/auth/logout')
    def logout():
        return 'Logout'

    @app.errorhandler(404)
    def page_404(error):
        return render_template('404.html'), 404

    return app
```

```
# forms.py

from flask_wtf import FlaskForm

class LoginForm(FlaskForm):
    pass

class RegisterForm(FlaskForm):
    pass
```

```html
# login.html
{{ form }}
```

```html
# register.html
{{ form.csrf_token }}
```

http://localhost:5000/auth/login 에서는 LoginForm 이라는 갯체가 불러와 진것을 볼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/194735046-50e11785-a992-4fc3-a10d-1ac9c76e749f.png)

http://localhost:5000/auth/register 에서는 value에 암호화된 무언가가 있을 것이다. 

![image](https://user-images.githubusercontent.com/61526722/194735111-7c5142e1-2715-481b-837c-07ba0d0ec5ec.png)

앞으로 html 에서 form을 만들 때 csrf_token을 같이 넣어주기만 하면 된다. 

---

### Flask WTF으로 로그인 회원가입 폼 레이아웃 작성

wtforms는 flask에서 forms를 간편하게 사용할 수 있게 매핑해 주는 라이브러리이다. 먼저 아래와 같이 코드들을 수정해준다. 

```python
# auth_form.py

from tokenize import String
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField
from wtforms.validators import DataRequired, EqualTo

class LoginForm(FlaskForm):
    user_id = StringField('UserID', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])


class RegisterForm(LoginForm):
    password = PasswordField(
        'Password', 
        validators=[DataRequired(), EqualTo(
            'repassword',  # repassword와 같은 값을 넣었는지 확인
            message='Password must match!'  # 장애일 경우 어떤 메세지 노출
        )])
    repassword = PasswordField('Confirm Password', validators=[DataRequired()])
    user_name = StringField('User Name', validators=[DataRequired()])
```

```html
# login.html

<!-- __init__.py의 login 함수를 실행-->
<form method = "POST" action="{{ url_for('login') }}">
    {{ form.csrf_token }}
    {{ form.user_id.label }} {{ form.user_id(minlength=4, maxlength=20) }}
    {{ form.password.label }} {{ form.password(minlength=4, maxlength=20) }}
    {{ form.errors }}
    <input type="submit" value="go">
</form>
```

```html
# register.html

<form method = "POST" action="{{ url_for('register') }}">
    {{ form.csrf_token }}
    {{ form.user_id.label }} {{ form.user_id(minlength=4, maxlength=20) }}
    {{ form.user_name.label }} {{ form.user_name(minlength=4, maxlength=20) }}
    {{ form.password.label }} {{ form.password(minlength=4, maxlength=20) }}
    {{ form.repassword.label }} {{ form.repassword(minlength=4, maxlength=20) }}
    {{ form.errors }}
    <input type="submit" value="go">
</form> 
```

```python
# __init__.py

from crypt import methods
from flask import Flask
from flask import render_template
from flask_wtf.csrf import CSRFProtect
from myapp.forms.auth_form import LoginForm, RegisterForm

csrf = CSRFProtect()

def create_app():
    print('---- Run create_app ')

    app = Flask(__name__)

    # wtf는 secret key가 무조건 등록되어 있어야 함 (csrf token이 암호화 되어 있기 때문)
    app.config['SECRET_KEY'] = 'secretkey'

    if app.config['DEBUG']:
        app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 1

    # csrf init
    csrf.init_app(app)

    @app.route('/')
    def index():
        return render_template('index.html')

    @app.route('/auth/login', methods=['GET', 'POST'])
    def login():
        form = LoginForm()
        return render_template('login.html', form=form)

    @app.route('/auth/register', methods=['GET', 'POST'])
    def register():
        form = RegisterForm()
        return render_template('register.html', form=form)

    @app.route('/auth/logout')
    def logout():
        return 'Logout'

    @app.errorhandler(404)
    def page_404(error):
        return render_template('404.html'), 404

    return app
```


login과 register에 모두 csrf_token이 잘 들어간 것을 확인할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/194735660-c8364c55-5f0a-4015-9b97-80acf6e7cd40.png)

![image](https://user-images.githubusercontent.com/61526722/194735669-43a0e2c3-fac2-4ada-8663-34f593dd6923.png)
