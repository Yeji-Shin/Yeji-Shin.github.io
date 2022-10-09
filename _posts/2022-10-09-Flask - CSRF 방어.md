---
layout: post
title: Flask - CSRF 방어
date: 2022-10-09
category: Flask
use_math: true
---

### CSRF

CSRF (Cross Site Request Forgery)의 약자로, 사이트간 요청 위조를 뜻한다. 희생자의 의지와 무관하게 공격자가 의도한 작업이 진행 되게끔 유도하는 해킹방법이다. 

![image](https://user-images.githubusercontent.com/61526722/194734420-95c7c1ef-7725-40fe-af10-af8f9158f8d1.png)

1. 공격자는 공격용 Web 페이지를 준비하고 사용자가 액세스하도록 유도한다.
2. 사용자가 공격용 Web 페이지에 액세스하면, 미리 준비되어 있던 잘못된 요청이 공격 대상 서버에 보내진다.
3. 공격 대상 서버의 Web 응용 프로그램은 잘못된 요청을 처리하고 사용자가 의도하지 않은 처리를 진행한다.

---

### Flask WTF을 이용한 CSRF 공격 조치

Flask WTF을 이용한 CSRF 공격 조치

