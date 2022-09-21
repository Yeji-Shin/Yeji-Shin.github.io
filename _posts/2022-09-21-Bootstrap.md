---
layout: post
title: Bootstrap
date: 2022-09-21
category: Web
use_math: true
---


### Bootstrap 이란?

https://getbootstrap.com/docs/5.2/getting-started/introduction/

부모 요소는 CSS 에서 자식 요소보다 위쪽에 적어야 한다. 미리 CSS 를 완성시켜 놓은 상태에서 HTML 에 적용하는 방식을 사용하면 좀더 손쉽게 웹사이트를 구현할 수 있다. 그때 사용하는 것이 UI 프레임워크이다. UI 프레임워크는 먼저 만들어진 기능들이고, 우리는 그 기능들을 클래스 이름으로 가져와서 사용하면 된다. 대표적으로 bootstrap UI 프레임워크가 있다.

bootstrap 링크는 css 링크 이전에 작성해야 하고, JS 링크(bootstrp에서 사용할수 있는 JS) 는 아무데나 있어도 된다. 

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>=Document</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link rel="stylesheet" href="./main.css">
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
  
</head>
<body>
  <div class="btn btn-primary">Hello!</div>
</body>
</html>
```

https://getbootstrap.com/docs/5.2/components/dropdowns/에 많은 예시들을 참고하면 된다. 

---

### Layout - container 기능

https://getbootstrap.com/docs/5.2/layout/containers/

Bootstrap은 container라는 레이아웃 기능을 제공한다. container라는 클래스를 부여해 놓은 요소를 통해서 화면에 보여지는 다양한 내용들을 잘리지 않게 화면의 가운데로 몰아줄 수 있다. 아래 표는 브라우저의 뷰포트 크기가 변할 때 어떻게 레이아웃의 크기를 변경시킬 것인지 보여준다. 

![image](https://user-images.githubusercontent.com/61526722/191443444-422ff92b-2fc2-4b27-815d-7ab0bba121ae.png)

```html
<div class="container">
  <!-- Content here -->
</div>
```

---

### Layout - columns 기능

https://getbootstrap.com/docs/5.2/layout/columns/

columns는 하나의 그리드 시스템이다. columns를 통해서 하나의 줄을 만들 수 있는데 기본적으로 12개의 칸으로 이루어져 있다. 그 12개의 칸중에 내가 몇개의 칸만큼 layout 구조를 사용하겠다라는 것을 columns로 지정할 수 있다. 하나의 줄을 만들 때는 row라는 클래스로 만들어 주고, row 요소 안에 col 요소를 사용해 몇칸 씩 차지할 것인지 지정해준다. 예를 들어 col이 3개가 있다면 하나의 col은 12/3=4칸씩 차지하게 된다. 

![image](https://user-images.githubusercontent.com/61526722/191446087-e69ef26a-fa87-4e5b-b56d-2f05557a3ab3.png)

```html
<body>
  <div class="row">
    <div class="col box">A</div>
    <div class="col box">B</div>
    <div class="col box">C</div>
  </div>
</body> 
```

![image](https://user-images.githubusercontent.com/61526722/191446221-e1fc1da6-16b6-40ed-9b2e-45be6212299f.png)

뒤의 숫자는 몇 칸을 차지할지 정해주는데 row 하나에 12칸이기 때문에 첫번째 row에 다 들어갈 수 없어 C가 자동으로 다음칸으로 넘어가버린다. 

```html
<body>
  <div class="row">
    <div class="col-4 box">A</div>
    <div class="col-4 box">B</div>
    <div class="col-8 box">C</div>
  </div>
</body> 
```

반응형도 만들수 있다. col-md-7은 뷰포트의 가로 길이가 md 인 상태가 되면 차지하는 col의 개수는 7칸으로 하겠다는 뜻이다. 브레이크포인트는 아래와 같다. 

![image](https://user-images.githubusercontent.com/61526722/191447032-68cd5faf-ba81-458e-be0d-c8cdc9307723.png)


![image](https://user-images.githubusercontent.com/61526722/191446928-0b64e3ff-5ed6-4093-b136-c0c95924430b.png)

```html
<body>
  <div class="row">
    <div class="col-1 box">A</div>
    <div class="col-3 col-md-7 box">B</div>
    <div class="col-8 col-md-4 box">C</div>
  </div>
</body> 
```

--- 

### Forms

https://getbootstrap.com/docs/5.2/forms/form-control/

form은 `class="form-control"`을 추가하면 기능을 사용할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/191449840-a93064c2-c51a-4e4c-aa5c-d686c63a98b9.png)

```html
<body>
  <div class="container mt-2">
    <div class="row">
      <div class="col>
        <input type="text" class="form-control placeholder="이름을 입력하세요.">
      </div>
      <div class="row">
        <input type="password" class="form-control>
      </div>
    </div>
  </div>
</body> 
```

---

### Components

https://getbootstrap.com/docs/5.2/components/buttons/

![image](https://user-images.githubusercontent.com/61526722/191450068-a51481e6-9214-49b1-b92d-fd95a10970a7.png)

```html
<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-secondary">Secondary</button>
<button type="button" class="btn btn-success">Success</button>
<button type="button" class="btn btn-danger">Danger</button>
<button type="button" class="btn btn-warning">Warning</button>
<button type="button" class="btn btn-info">Info</button>
<button type="button" class="btn btn-light">Light</button>
<button type="button" class="btn btn-dark">Dark</button>

<button type="button" class="btn btn-link">Link</button>
```

https://getbootstrap.com/docs/5.2/components/card/

![image](https://user-images.githubusercontent.com/61526722/191451413-0b740adf-f111-45ff-ba9f-0961d511781a.png)

```html
<div class="card" style="width: 18rem;">
  <img src="..." class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
```

https://getbootstrap.com/docs/5.2/components/offcanvas/

offcanvas는 숨겨져 있는 네비게이션을 만들 때 사용한다. 

![image](https://user-images.githubusercontent.com/61526722/191451896-c9cd4797-4965-443a-bdd8-caa560819fb0.png)

```html
<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
  Link with href
</a>
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
  Button with data-bs-target
</button>

<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasExampleLabel">Offcanvas</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div>
      Some text as placeholder. In real life you can have the elements you have chosen. Like, text, images, lists, etc.
    </div>
    <div class="dropdown mt-3">
      <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
        Dropdown button
      </button>
      <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="#">Action</a></li>
        <li><a class="dropdown-item" href="#">Another action</a></li>
        <li><a class="dropdown-item" href="#">Something else here</a></li>
      </ul>
    </div>
  </div>
</div>
```

---

### Utilities

https://getbootstrap.com/docs/5.2/utilities/colors/

`<div>` 요소는 블록요소인데 CSS 에서 display 속성을 사용해 강제로 인라인 요소로 만들 수 있다.  

https://getbootstrap.com/docs/5.2/utilities/display/

`d-none`은 display:none; 이라는 뜻으로 화면에 보여지는 것이 없다는 것이다. 이건 블록요소도 아니고 인라인 요소도 아니고 플레스 요소이다. 요소가 투명해지는 것이 아니라 요소가 아예 화면에서 제거된다. 구조적으로 남아 있지만 화면에 출력되지 않도록 만들때 사용한다. `d-block`은 블록 요소가 아닌것을 블록 요소로 만들수 있다. 이렇게 display라는 CSS 속성을 제어할 때 CSS를 작성하지 않고도 class 이름만으로도 제어할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/191453469-9fad4e37-4704-4372-a03e-3c039e5b91bb.png)

https://getbootstrap.com/docs/5.2/utilities/shadows/

요소에 그림자도 넣을 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/191454350-7768659c-69e5-4a0b-854a-d7a52a1dbfb2.png)

```html
<div class="shadow-none p-3 mb-5 bg-light rounded">No shadow</div>
<div class="shadow-sm p-3 mb-5 bg-body rounded">Small shadow</div>
<div class="shadow p-3 mb-5 bg-body rounded">Regular shadow</div>
<div class="shadow-lg p-3 mb-5 bg-body rounded">Larger shadow</div>
```

https://getbootstrap.com/docs/5.2/utilities/spacing/

spacing은 요소와 요소 사이의 여백을 의미한다. 

즉, utility에 있는 기능들은 별도의 CSS 작업을 통해서 충분히 만들 수 있지만 CSS의 작성은 최소화하고 HTML의 클래스만 가지고도 빠르게 작업할 수 있다. 
