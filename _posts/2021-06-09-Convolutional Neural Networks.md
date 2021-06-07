---
layout: post
title: Convolutional Neural Networks Basics
date: 2021-06-09
category: DeepLearning
use_math: true
---

지금까지 DNN에 대해 알아보았다. 이번에는 Convolutional Neural Networks (CNN)에 대해 살펴본다.

---

### 1. Convolutional Neural Networks (CNN)

![image](https://user-images.githubusercontent.com/61526722/121026268-ee53c080-c7e0-11eb-85bf-ed6c55d3714a.png)

CNN은 FC와 달리 layer간 모든 노드가 연결되어 있지 않은 partially connected 구조이다. 같은 색상은 같은 connection weight를 가져야 한다. 
CNN은 보통 이미지, 음성, 텍스트 등의 sequential data를 처리하는데 사용된다. Sequential data는 값 뿐만 아니라 값이 나타난 위치까지 중요하게 생각한다.
이미지도 pixel이 어느 위치에 있는지가 중요하기 때문에 sequential data다.

#### convolution이란?

Convolution은 NN과 상관없이 이미지 처리에서 많이 사용하던 행렬 연산이다. 이 convolution과 NN이 만나서 만들어진 것이 CNN이다. 

![image](https://user-images.githubusercontent.com/61526722/121027112-abdeb380-c7e1-11eb-9c92-c4d076023fbb.png)

예를 들어 위와 같이 X와 O를 구분하는 classifier를 만든다고 하자. 하지만 이를 코드로 구현하기가 힘들다. 
따라서 쉽게 local feature들을 찾아내고 그 local feature들 끼리 매칭하여 같은 그림인지 아닌지 구분하는 방법을 사용하기로 한다. 
다시말해서 pixel by pixel로 비교하면 두 그림은 같지 않지만 local feature들의 상대적 위치를 기준으로 비슷하다고 판단한다. 

![image](https://user-images.githubusercontent.com/61526722/121027700-23acde00-c7e2-11eb-8281-55506f5606f1.png)

그러면 이제 어떻게 local feature 들을 찾아낼 것인가? convolution을 사용하여 찾아내면 된다. 

---

### 2. Feature Extraction with Convolution

방금 전에 convolution은 local feature들을 찾기 위한 연산이라고 했다. 그러면 convolution은 어떻게 동작할까. 

![image](https://user-images.githubusercontent.com/61526722/121030460-75566800-c7e4-11eb-9fe0-15c0b3f0e801.png)

![image](https://user-images.githubusercontent.com/61526722/121030929-e269fd80-c7e4-11eb-8e3f-8dc7a2fe0655.png)

convolution은 두 행렬을 element-wise하게 곱해주어 summation을 하면 된다. 이는 NN에서 net값을 구해서 summation하는 것과 비슷하다.

#### Two-Dimensional Convolution

![image](https://user-images.githubusercontent.com/61526722/121029211-61f6cd00-c7e3-11eb-9f03-dac964143f5d.png)

![image](https://user-images.githubusercontent.com/61526722/121029597-af733a00-c7e3-11eb-8d00-61fac6885b81.png)

![image](https://user-images.githubusercontent.com/61526722/121029646-bc902900-c7e3-11eb-9c2b-33f3da91ea57.png)

convolution은 이미지라고 불리는 큰 행렬과 filter라고 불리는 작은 행렬을 입력으로 받아서 행렬을 output으로 출력한다. 
이때 마지막 결과에서 행렬의 테두리가 빈칸이 되는데 filter size가 3이면 한칸씩 빠져나가고, 5면 2줄씩 비게 된다.

#### Padding

이렇게 행렬 사이즈가 바뀌는 것을 방지하지 위해 이미지 행렬의 테두리에 0을 추가해준다. 이를 zero-padding이라고 부른다.

![image](https://user-images.githubusercontent.com/61526722/121030245-45a76000-c7e4-11eb-9c76-ac5914bd65b1.png)

그러면 초기의 입력값의 사이즈를 유지한 상태로 결과가 나오게 된다. 이제 output으로 나온 결과의 의미를 한번 살펴보자.
output 값은 filter라고 불리는 작은 행렬의 값에 따라 달라지며 <mark>filter는 우리가 찾고자 하는 local feature의 definition</mark>이라고 할 수 있다.
따라서 정의된 local feature가 강하게 나타나는 부분에서는 큰 양수값을 output으로 낸다. 
반대로 큰 음수값을 내는 부분은 local feature가 전혀 나타나고 있는 지점이 아니다라고 해석 가능하다.
즉, <mark>convolution output</mark>은 local feature가 원래 이미지의 어느 부분에서 나타나고 있는지 알려주는 <mark>feature map</mark>이라고 할 수 있다. 

#### Threshold 

이 때 local feature가 강하게 나타나는 부분이 중요하므로 feature map의 음수값은 모두 0으로 바꿔준다. 음수도 어짜피 없는 거니깐 바꿔도 상관없다. 

![image](https://user-images.githubusercontent.com/61526722/121032753-87390a80-c7e6-11eb-92cd-5c8d4c2f9b8e.png)

이렇게 변하는 음수는 0으로 양수는 그대로 양수로 두는 연산은 ReLU에서 보던 연산이다. 
즉, 두 행렬의 element-wise하게 곱해주어 summation 하는 것과 음수값을 0으로 바꿔주는 과정을 NN에서 보던 net을 구하고 ReLU를 적용하는 것과 많이 비슷하여 
convolution 과 NN이 혼합될 수 있는 것이다.

#### Three-Dimensional Convolution

우리는 RGB 컬러 이미지를 사용한다. 이에 맞는 convoltion은 다음과 같이 진행된다. 
R채널에 있는 local feature를 찾아내고, G채널에 있는 local feature를 찾아내고, B채널에 있는 local feature를 찾아내서 더해준다.

![image](https://user-images.githubusercontent.com/61526722/121033509-3970d200-c7e7-11eb-9d38-4b9ebd0102e2.png)

![image](https://user-images.githubusercontent.com/61526722/121034090-b603b080-c7e7-11eb-8f67-20b55e1990d4.png)


이때 <mark>입력 이미지의 channel 수는 filter의 channel수는 동일</mark>해야 하기 때문에 RGB이미지가 들어가면 filter의 channel 수도 3이 되어야 한다.
이 때 착각하지 말아야 하는 것이 filter의 개수는 1개이다. RGB 3 channel이 있어도 하나의 이미지라고 하는 것과 같다. 

![image](https://user-images.githubusercontent.com/61526722/121034827-4b06a980-c7e8-11eb-8654-4c60dab4c67c.png)

zero-padding을 한 후에 전체 이미지에 대해 convolution을 진행한 결과이다. 여기서 또 중요한 것은 feature map의 개수는 1장이 나왔다. 

정리하면 
- <mark>입력의 channel 수 = filter의 채널 수 </mark>
- <mark>channel 수가 얼마가 됐던 feature map은 1장 (1 channel)</mark>

![image](https://user-images.githubusercontent.com/61526722/121035745-24953e00-c7e9-11eb-93ee-eb8f8e8b3006.png)

위 그림은 horizontal line을 찾아주는 filter를 적용한 결과이다. <mark>output(feature map)은 local feature가 강조된 이미지</mark>라고 생각할 수 있는데 feature map의 검정색 부분은 원래 이미지의 해당 부분에 horizontal line이 없기 때문에 검정색으로 표현된다. 흰색부분은 horizontal line이 있다는 의미이다.

그러면 filter가 local feature의 defition이라고 했는데 이 filter는 어떻게 정의할까. CNN을 사용하면 이 filter 를 정의할 필요가 없다. 
물론 전통적인 vision에서는 filter를 사람이 손으로 정의해줘야 하지만 CNN에서는 NN의 학습 알고리즘을 이용하여 이 filter를 자동으로 찾아낸다. 


#### Pooling (Sub-sampling)

Pooling은 해상도를 변경하는 연산이다(channel 수는 바뀌지 않음). 아래는 2x2 max-pooling을 진행한 결과이다. 보통은 2x2 max pooling을 많이 사용한다. average pooling 보다 max pooling을 더 많이 사용하는 이유는 feature map의 값들은 그 부분에 local feature가 있다 없다의 값이기 때문에 average pooling을 하면 feature가 0.25만큼 있다라고 바뀌는 것이기 때문이다. 따라서 시그널을 더 잘 유지하기 위해 max pooling을 많이 사용한다.

![image](https://user-images.githubusercontent.com/61526722/121037078-20b5eb80-c7ea-11eb-82ac-e8a77b161729.png)

왜 그냥 feature map을 사용하지 않고 해상도를 줄인 feature map을 사용할까. 
- <mark>계산량이 줄어든다.</mark> 해상도를 줄인다고 해서 feature map 이미지의 정보가 크게 손실되지는 않는다. (사람은 저해상도에서도 사람으로 보이지 원숭이로 보이지 않는다.)
- <mark>shift invariant</mark>: 훨씬더 robust한 feature map을 만든다.

![image](https://user-images.githubusercontent.com/61526722/121037533-7a1e1a80-c7ea-11eb-9e9b-dc401ed50010.png)

두 이미지를 픽셀 단위로 비교하여 동일한 지점을 초록색으로 칠해보면 64개 중에 4군데 밖에 없다. 하지만 pooling후에 픽셀 단위로 비교하면 같은 지점은 16개 중 6군데이다. 따라서 비교가 더 용이해진다.


---

### 3. Convolutional Neural Networks (CNN)


지금까지 CNN의 모든 연산들 (convolution, threshold, padding, pooling)을 설명했다. 

![image](https://user-images.githubusercontent.com/61526722/121039017-b2722880-c7eb-11eb-9b2f-96b0de8a95e6.png)

다시 정리해보면 이미지가 들어가면 convolution+ReLU를 하고 pooling해서 사이즈를 줄이는 연산이 한 세트이다. Pooling은 옵션이다.  

![image](https://user-images.githubusercontent.com/61526722/121042609-d1be8500-c7ee-11eb-8cd2-393ba151e35c.png)

filter를 잘 정의하면 주어진 이미지를 구분하는 데 도움이 되는 feature들이 뽑혀 나오고 크게 고민 안하고 이 feature들만 잘 쳐다봐도 개냐 고양이냐를 구분할 수 있을 것이다 라는게 CNN의 아이디어다. 

여기서 좀더 나아가서 channel 1개 짜리인 feature map이 n개를 합해서 channel n개 짜리 feature map이 1개가 있다고 생각해도 된다. 다시말해 하나의 input 이미지가 들어가서 하나의 이미지(feature map)이 나온다고 할 수 있다. n개의 서로 다른 convolution을 진행하면 n개의 channel을 가진 feature map이 생성된다고 이해하면 된다.

![image](https://user-images.githubusercontent.com/61526722/121043686-d0da2300-c7ef-11eb-92be-f13183b00e5a.png)

그럼 다시 n개의 channel 을 가지는 1개의 feature map은 이미지로 생각할 수 있다. 형식은 이미지이지만 내용은 feature map인 것이다. 어쨋든 feature map을 다시 이미지로 생각해서 local feature들을 다시 뽑아낼 수 있다. 이는 feature들이 가지고 있는 local feature라고 할 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121042897-16e2b700-c7ef-11eb-9ccf-158098c2aa0c.png)

또 다시 feature들을 이미지로 생각해본다. 이를 계속 반복한다. 이렇게 convolution을 반복하면 좋은 feature를 만들어 낼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/121044144-40e8a900-c7f0-11eb-9bc4-378aeaa73193.png)

하지만 input 이미지의 channel 수와 filter channel 수가 같아야 하기 때문에 계속 파라미터의 개수가 급격히 늘어난다. 따라서 NN의 학습 대상이 connection weight 이었다면 CNN의 학습대상은 filter안에 들어가는 숫자들이다. 

---

### 4. CNN - Graphical Representation

![image](https://user-images.githubusercontent.com/61526722/121047862-4f839000-c7f1-11eb-9999-c5037657483b.png)

이를 해석해보면 conv1은 64개의 filter(3x3크기, channel 3)를 사용한 것이다. 그러면 이때는 3x3x3x64개의 숫자를 결정해야 한다. 그 다음 pooling은 이미지 사이즈를 줄이는 과정이며 channel수는 그대로 유지한다. 

마지막에는 식빵모양으로 되어 있는 feature들을 한줄로 세운 후에 shallow NN의 입력으로 준다.  

![image](https://user-images.githubusercontent.com/61526722/121049442-a6d63000-c7f2-11eb-8d86-7ce63ae97e09.png)

그러면 3x3x128x1000개의 connection weight를 설정해 줘야한다. 


---

### 5. CNN - Neural Network Representation (Filter Training) 

CNN을 계속 NN이라고 하는데 이제 filter를 어떻게 학습하는지 생각해보자. NN과 똑같이 gradient descent method를 사용하여 학습한다. 

![image](https://user-images.githubusercontent.com/61526722/121050170-514e5300-c7f3-11eb-939c-e74e9fa9451e.png)
![image](https://user-images.githubusercontent.com/61526722/121050178-53181680-c7f3-11eb-905a-dc8fa16e3fce.png)

일단 input이미지를 세로로 잘라서 한줄로 이어 붙인다. 이렇게 하면 input 이미지의 각 픽셀들이 input layer의 노드 한개로 바뀐다. output도 마찬가지로 세로로 잘라서 한줄로 이어 붙여 노드가 16개인 output layer로 변환한다. 

![image](https://user-images.githubusercontent.com/61526722/121050703-c3bf3300-c7f3-11eb-96ca-69372d7c1b0c.png)
![image](https://user-images.githubusercontent.com/61526722/121050719-c883e700-c7f3-11eb-9e83-8e0be626d7a9.png)

입력을 filter와 convolution 연산을 하여 summation을 구한 것이 output(net값)이 된다. 이것을 모든 픽셀에 대해 진행하면 아래와 같이 된다.

![image](https://user-images.githubusercontent.com/61526722/121051061-1993db00-c7f4-11eb-8032-729917bebc03.png)
![image](https://user-images.githubusercontent.com/61526722/121051075-1bf63500-c7f4-11eb-9ad8-89d00388488d.png) 

즉, partially connected 된 share weight를 가지는 하나의 NN으로 해석된다. 사실은 partially connected가 아닌 대부분의 connection weigth가 0인 NN 으로 이해할 수 있는 것이다.

다음으로 pooling도 하나의 partially connected 된 layer로 해석된다. 

![image](https://user-images.githubusercontent.com/61526722/121051569-83ac8000-c7f4-11eb-9306-05cb1e2d44b2.png)
![image](https://user-images.githubusercontent.com/61526722/121051586-86a77080-c7f4-11eb-894f-93edfc2172c1.png)

그래서 궁극적으로 CNN은 하나의 NN으로 변환될 수 있다.

![image](https://user-images.githubusercontent.com/61526722/121051673-9b840400-c7f4-11eb-81e0-007a94ee0b11.png)

여기서 convolution filter 개수를 추가하면 feature map의 개수가 늘어나고, feature map을 일렬로 늘리니깐 hidden layer의 노드개수를 늘어나게 하는 효과가 있다. 

![image](https://user-images.githubusercontent.com/61526722/121051838-c8d0b200-c7f4-11eb-8fe4-99bc5707dcdb.png)

궁극적으로 CNN 구조를 하나의 fully connected NN으로 해석될 수 있고, connection weight는 gradient method로 학습할 수 있다. filter가 connection weight로 변환되니깐 filter를 자동으로 학습하는 효과를 내는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121052249-282ec200-c7f5-11eb-96eb-0f706f192adb.png)

---

지금까지 CNN에 대해서 공부했다. 다음 문서에서는 대표적인 CNN 구조들을 살펴볼 것이다. 
