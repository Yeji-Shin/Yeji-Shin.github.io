---
layout: post
title: 쉘 프로그래밍
date: 2022-10-23
category: Linux
---

### 쉘 스크립트란?

**스크립트**

스크립트는 인터프리터 방식으로 동작하는 컴파일되지 않은 프로그램이다. 쉽게 말해 한 줄씩 읽어 해석하고 실행하는 과정을 반복하도록 작성된 파일이다. 쉘 스크립트, 자바 스크립트 등 스크립트 앞에 여러가지 수식어가 붙는데, 이 수식어는 스크립트를 읽어 실행해주는 인터프리터 엔진을 뜻한다. 쉘 스크립트는 쉘(bash, ksh, csh 등)이 읽어 실행해주고, 자바 스크립트는 웹 브라우저가 읽어 실행해준다. 

**쉘 스크립트**

쉘 스크립트(shell script)는 쉘이나 명령 줄 인터프리터에서 돌아가도록 작성되었거나 운영 체제를 위해 쓰인 스크립트이다. 쉘 스크립트가 수행하는 기능으로는 파일 이용, 프로그램 실행, 문자열 출력 등이 있다. 

- 장점
    - 쉘 스크립트는 다른 프로그래밍 언어의 같은 코드로 쓰인 것보다 훨씬 더 빠른 경우가 많다
    - 다른 해석 언어에 비해 쉘 스크립트는 컴파일 단계가 없기 때문에 디버깅을 하는 동안 빠르게 실행할 수 있다.
- 단점
    - 스크립트 내에 많은 명령들이 수행될 경우 각 명령에 대한 새로운 프로세스의 필요에 따라 많은 프로세스들이 생성됨을 필요로 함으로 속도가 느려질 수 있다.
    - 단순 쉘 스크립트는 다양한 종류의 유닉스, 리눅스, BSD 등 운영체제의 시스템 유틸리티와 잘 호환된다는 장점이 있지만 복잡한 쉘 스크립트의 경우 쉘, 유틸리티, 다른 필수 요소 간의 차이가 많은 경우 실패할 가능성이 있다. (각 운영체제가 제공하는 유틸리티 명령 등이 다를 경우 수행이 안될 수 있다.)

**쉘 스크립트의 특징**

아래 코드는 같은 기능을 하는 프로그램이다. 



C언어로 작성된 프로그램은 컴파일하여 기계어로 번역된 Object File로 만들어준 뒤 링크 과정을 거치고 실행 권한을 주어야만 실행이 가능하지만, 쉘 스크립트로 작성된 파일은 이러한 과정이 필요없고 실행 권한만 주면 된다. 

또한, C언어로 작성된 프로그램은 실행을 위해 컴파일되면 vi나 cat 과 같은 명령으로 내용을 확인할 수 없는 바이너리 구조로 변형되지만, 쉘 스크립트는 파일의 변환과정이 없어 내용물을 이해할 수 있다. 

그리고 C언어로 작성된 프로그램은 기계어로 변환되었기 때문에 커널에 의해 실행되지만, 쉘 스크립트는 쉘(bash, sh, ksh) 이 한줄씩 읽어 실행한다. 

마지막으로 C언어로 작성된 프로그램은 정식 프로세스로 생성되지만 쉘 스크립트로 작성된 프로그램은 이름은 보이지만 정식 프로세스는 아니다.

---

### 쉘 문법

**쉘 변수**

- `echo “Hello World”`
    - “echo”는 쉘 프로그램에서 출력을 수행
    - “Hello World”라는 문자열을 표준출력으로 보냄
- `shvar=“Hello World”`
    - 변수에 값을 저장
    - 문자열은 큰 따옴표로 묶고, “=“ 주위에 공백이 없습니다.
- `echo $shvar`
    - 쉘 변수의 값은 앞에 “$”를 붙여서 얻음
    - 해당 쉘 변수에 값을 저장하지 않았다면 빈 줄이 생김
- `cp $olddir $newdir`
    - 쉘 변수에 저장된 값은 다른 프로그램의 매개 변수로도 사용 가능
- `$shvar=“”`
    - NULL 문자열을 지정하여 쉘 변수에 저장된 값을 지울 수 있음
- `mv $myfile $myfile2`(X) `mv $myfile ${myfile}2`(O)
    - “myfile”이라는 쉘 변수에 파일 이름이 있고 같은 이름을 가지고 있지만 “2”가 붙은 다른 파일로 해당 파일을 복사하려고 한다고 가정, 그러나 쉘은 “myfile2”가 다른 쉘 변수라고 생각하고 작동하지 않음
- `export shvar`
    - 쉘 프로그램에서 다른 쉘 프로그램을 호출하고 호출 프로그램과 동일한 쉘 변수를 사용하게 하려면 “export(내보내기)“ 해야 함

```bash
$ cat > shtest1.sh
#!/bin/bash  
echo "This is shtest1"
echo $shvar

$ cat > shtest2.sh
#!/bin/bash  
shvar="Hello"
export shvar  
echo "Call shtest1"
./shtest1.sh  
echo "Done"

$ chmod +x shtest1.sh shtest2.sh
$ ./shtest2.sh 
Call shtest1
This is shtest1
Hello
Done
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ca45e3cf-739e-4c32-9392-eda9200b48de/Untitled.png)

- `“$(숫자)”`
    - 쉘 프로그램 매개변수를 참조
    - “$1”은 첫 번째 매개변수, “$2”는 두 번째 매개변수, ...
- `$#`
    - 쉘 프로그램 매개변수의 개수
- `$*`
    - 쉘 프로그램 매개변수 전체 내용($1, $2, ...)
- `$$`
    - 쉘 프로그램 실행 프로세스 ID
- `$!`
    - 쉘 프로그램이 실행시킨 백그라운드 프로세스 ID
- `$?`
    - 쉘 프로그램이 실행한 프로그램 종료값(리턴값)

```bash
$ cat > shtest.sh
#!/bin/bash  
echo "Argument number: $#"
echo "Arguments: &*"
echo "PID: $$"

top &
echo "Background PID $!"    

ls 
echo "Result $?"

$ chmod +x shtest.sh
$ ./shtest.sh arg1 arg2
Argument number: 2
Arguments: &*
PID: 10549
Background PID 10550
shtest.sh
Result 0
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ceb404ec-2389-40fe-90b7-cf103c6f5167/Untitled.png)

**쉘 의사결정**

쉘 프로그램은 인수와 변수에 대해 조건부 테스트를 수행하고 결과에 따라 다른 명령을 실행할 수 있다.

- 문자열
    - `[ -n $shvar ]` – 문자열의 길이가 0보다 큰지
    - `[ -z $shvar ]` – 문자열의 길이가 0인지
    - `[ “$shvar” = “fox” ]` – 문자열이 같으면 true
    - `[ “$shvar” != “fox” ]` – 문자열이 다르면 true
    - `[ “$shvar” = “” ]` – 문자열이 null이면 true
    - `[ “$shvar” != “” ]` – 문자열이 null이 아니면 true
- 숫자
    - `[ “$nval” –eq 0 ]` - 0과 같으면 true
    - `[ “$nval” –ge 0 ]`- 0과 같거나 크면 true
    - `[ “$nval” –gt 0 ]` – 0보다 크면 true
    - `[ “$nval” –le 0 ]` - 0보다 작거나 같으면 true
    - `[ “$nval” –lt 0 ]` - 0보다 작으면 true
    - `[ “$nval” –ne 0 ]` - 0과 다르면 true
- 파일
    - `[ -d tmp ]` – tmp 가 디렉토리면 true
    - `[ -f tmp ]` – tmp가 파일이면 true
    - `[ -r tmp ]` – tmp가 읽기 가능하면 true
    - `[ -s tmp ]` – tmp의 사이즈가 0이 아니면 true
    - `[ -w tmp ]` – tmp가 쓰기 가능하면 true
    - `[ -x tmp ]` – tmp가 실행 가능하면 true
- 결합
    - `[ conditionA –a conditionB ]` – 조건문 A, B 모두 참인지, AND
    - `[ conditionA –o conditionB ]` – 조건문 A, B 중 하나라도 참인지, OR

```bash
$ cat > shtest.sh
#!/bin/sh
if [ "$1" = "fork" ]
then
echo "fork not allowed."
exit
elif [ "$1" = "knife" ]
then
echo "knife not allowed."
exit
else
echo "fork & knife not allowed"
fi
echo "spoon please"

$ chmod +x ./shtest.sh
$ ./shtest.sh fork
fork not allowed.
$ ./shtest.sh knife
knife not allowed.
$ ./shtest.sh
fork & knife not allowed
spoon please
```

---

### 쉘 프로그래밍

**awk**

AWK(오크)는 유닉스에서 처음 개발된 일반 스크립트 언어이다. AWK의 기본 기능은 텍스트 형태로 되어있는 입력 데이터를 행과 단어 별로 처리해 출력하는 것이다. 명령의 수행 결과나 파일의 데이터 내용을 한 줄씩 읽어 들여 한 줄의 내용을 단어 단위로 끊어서 읽어 들이고 이를 조작 및 연산에 활용할 수 있다.

- awk ‘패턴 {동작} 패턴 {동작} ... 패턴 {동작}’ 파일명
- command | awk ‘패턴 {동작} 패턴 {동작} ... 패턴 {동작}’
- awk –f awk파일명 파일명

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e93e6d62-1433-422e-bf10-a66bb36429e0/Untitled.png)

- `BEGIN { 동작 }` # 입력을 읽기 전에 주어진 '동작'을 먼저 실행한다.
- `END { 동작 }` # 위와 비슷하다. 입력을 모두 훑고 마지막에 주어진 ＇동작'을 실행한다.
- `/패턴/` # '패턴'에 일치하는 줄을 출력한다.
- `{ 동작 }` # 매 줄을 읽을 때마다 '동작'을 실행한다.
- `print`는 텍스트를 출력한다.

아래와 같이 awk를 이용해 패턴 일치가 성공하면 특정 필드만 출력할 수 있다. 카운팅 등의 연산도 가능하다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6c3a6559-311b-49ab-bb5b-fd7929390ee6/Untitled.png)

**sed**

sed(stream editor)는 유닉스에서 텍스트를 분해하거나 변환하기 위한 프로그램이다.

- `sed 's/regexp/replacement/g' inputFileName > outputFileName`
    - inputFileName을 읽어 전체에서 regexp 패턴을 찾아 replacement로 치환한 후 outputFileName으로 쓴다.
- `generateData | sed ‘s/x/y/g’`
    - generateData 수행 후 데이터를 만든 다음 x를 y로 치환
- `echo xyz xyz | sed ‘s/x/y/g`
    - yyz yyz

아래는 전체에서 문자 Won을 Woo로 바꾼다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bfba1c77-62be-45f4-89c4-5d61d64cf97b/Untitled.png)

문자열 031이 발견되는 1번째 패턴을 02로 바꾼다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/37bc04b7-0a1d-43c9-ae1c-beb28b487729/Untitled.png)

- i: 문자열 삽입
- a: 새로운 행을 추가
- d: 행 삭제
- s: 특정 문자열을 다른 문자열로 변환
- c: 특정 행을 다른 행으로 변환
- p: 출력

두번째줄 삭제

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/05c8700f-9b2d-46e5-9484-e7d98d27cb50/Untitled.png)

문자열 Won 이 발견되는 라인 삭제

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c0ccf879-b267-428d-a5e4-80057507d1a0/Untitled.png)

2번째 줄에 새로운 라인 삽입 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/883c98f3-803c-4824-bb17-021d0753335b/Untitled.png)

/proc/meminfo 파일 정보를 읽어 메모리 사용률을 보여주는 스크립트

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f7c6e5a3-c03b-4940-be01-28b1889654f3/Untitled.png)
