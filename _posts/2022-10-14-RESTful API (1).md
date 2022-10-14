---
layout: post
title: Flask - RESTful API (1)
date: 2022-10-14
category: Flask
use_math: true
---

### API (Application Programming Interface)

응용 프로그램에서 사용할 수 있도록, 운영 체제나 프로그래밍 언어가 제공하는 기능을 제어할 수 있게 만든 인터페이스이다. 즉, 개발자가 특정 요청을 날렸을 때 응답을 받을 수 있게 하는 엔드포인트 이다. 

---

### RESTful (Representational State Transfer)

RESTful은 
- 규칙보다는 가이드. 법은 아님
- RESTful 하게 API를 설계할지 말지는 개발자의 선택
- RESTful 하지 않다고 나쁜 API는 아니지만 웹 발전적이라고는 말할 수 없다

REST의 구성요소
- 자원
- 행위
- 표현

여기서 중요한 것은 RESTful API는 URL을 통해 자원을 표현하고 접근 자원에 대한 행위를 METHOD로 구분한다는 것이다.

---

### RESTful 예시

##### 접근 자원에 대한 행위를 METHOD로 구분

![image](https://user-images.githubusercontent.com/61526722/195831236-48ef5df6-0dfa-4686-a26b-612cb5294de1.png)

##### URL을 통해 자원을 표현

메서드로 충분히 어떤 행위를 할 것인지 정해졌기 때문에 URL에 그 행위를 표시할 필요가 없다.

- 메모 데이터 조회할 경우
```
GET http://test.com/api/memos/1 (O)
GET http://test.com/api/memos/read/1 (X)
```

- 메모 데이터를 생성할 경우

```
POST http://test.com/api/memos (O)
POST http://test.com/api/memos/create (X)
```

- 메모 데이터를 삭제할 경우

```
DELETE http://test.com/api/memos/1 (O)
DELETE http://test.com/api/memos/delete/1(X)
```

- 메모 데이터를 수정할 경우

```
PUT http://test.com/api/memos/1 (O)
PUT http://test.com/api/memos/update/1(X)
```

##### URL로 계층 표시

RESTful API는 계층 구조를 URL로 설명할 수 있다.

```
http://test.com/api/backends/languages/pythons/{version}
```

참고로 URL을 설계할 때는 
- 대문자와 밑줄(_)은 사용하지 않는다.
- 가독성을 위해 써야한다면, 하이픈(-)을 사용한다.
- 확장자는 URI에서 제거한다.

---

### (참고) HTTP Status codes

https://developer.mozilla.org/ko/docs/Web/HTTP/Status
