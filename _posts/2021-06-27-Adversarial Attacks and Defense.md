---
layout: post
title: Adversarial Attacks and Defense
date: 2021-06-27
category: DeepLearning
use_math: true
---

이번에는 NN의 취약성이 무엇인지 그것을 어떻게 극복할 것인지에 대해 공부한다.  

---

### 1. Adversarial Attack

Adversarial attack은 특정 노이즈를 인풋에 넣었을 때 NN은 정답이 아닌 엉뚱한 대답을 하는 현상이다. 
아래 그림과 같이 팬더 이미지에 특정 노이즈를 주었을 때 나오는 그림은 사람이 보기에는 팬더이지만 컴퓨터가 볼 때는 긴팔원숭이로 판단한다는 것이 대표적이 예시이다. 

![image](https://user-images.githubusercontent.com/61526722/123544203-2a999180-d78d-11eb-9f39-19ba691a2995.png)

그러면 NN을 속이는 이런 노이즈들을 원하는 대로 만들어 낼 수 있을까. 정답은 모든 NN에 대해 무수히 만들어 낼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/123544267-71878700-d78d-11eb-8998-c2c39c6ba6b1.png)

이처럼 하나의 픽셀만 바꿔도 다른 정답을 말할 정도로 노이즈의 영향이 크다. 이렇게 되면 지금까지 우리는 높은 accuracy를 가지는 NN을 사용했는데 믿고 사용할 수 있을지가 문제다. 즉, NN의 신뢰도가 떨어지는 것이다. 예를 들어 이렇게 쉽게 속일 수 있는 NN로 안면 인식기를 만들어 보안 솔루션을 사용하면 많이 위험해 보인다. 의료용으로 사용했을 때 암인데 암이 아니라고 할 수도 있다. 

---

### 2. Why it happens?

그러면  Adversarial attack은 왜 일어날까. 이 분야는 아직도 연구중인 분야로 정확한 해답을 찾지 못했다. 하지만 대략적인 원인은 알고 있으므로 이에 대해 살펴보려고 한다. 

#### Adversarial Examples

![image](https://user-images.githubusercontent.com/61526722/123544561-d7284300-d78e-11eb-93c1-03c949f05a99.png)

그림에서 네모 안의 영역이 의미하는 것은 사람이 가운데 점의 이미지와 구분을 못하는, 사람 눈에는 동일하게 보이는 것들의 영역이다. 이때 경계선을 그린 후에 빨간색 별에 해당하는 그림을 보여주면 사람과 NN은 다르게 대답한다. 이 빨간 점들이 <mark>adversarial example</mark>이다. 

실제로는 대부분의 점들 근처로 수많은 경계선들이 지나가는데 그러면 더 많은 양의 adversarial example들이 있을 것이다. 더 복잡한 차원으로 이야기하면 다음과 같다.

![image](https://user-images.githubusercontent.com/61526722/123544821-0e4b2400-d790-11eb-89cf-7dd24ea028fa.png)

여기서 원은 사람이 같은 답을 말하는 범위이고, 이 범위 내에서 loss함수가 다 작아지길 원한다. 하지만 x'과 같이 loss가 큰 부분이 존재하는데 loss가 크다는 것은 NN이 실제 정답과 다르게 이야기할 가능성이 크다는 뜻이다. 따라서 x'를 NN에 넣으면 착각해서 엉뚱한 대답을 할 확률이 크다.

따라서 adversarial example은 다음과 같은 조건을 만족한다.

![image](https://user-images.githubusercontent.com/61526722/123545015-fde77900-d790-11eb-83a1-d7d813bd5c39.png)

원래 이미지 $X$와 공격이미지 $\widetilde{X}$ 사이의 거리가 $ \epsilon$ 보다 작아야 한다. $ \epsilon$은 사람이 정해주는 값이다. $\widetilde{X}$가 주어졌을 때의 maximum에 대한 label이 정답과 달라져야 한다. 경우에 따라서는 $\widetilde{X}$ 의 범위가 주어질 수 있다. 이미지 같은 경우는 0~255 사이 값을 가져야 한다. 

거리를 계산할 때는 $L_{2} norm$이나 $L_{\infty} norm$를 사용한다. 이중에서도 특히 계산이 편한 $L_{\infty} norm$을 더 많이 사용한다. $L_{\infty} norm$는 축마다 차이를 계산한 것의 max값을 취해주면 된다. 

![image](https://user-images.githubusercontent.com/61526722/123545119-6c2c3b80-d791-11eb-9793-c3f2b3d92623.png)

$L_{2} norm$은 같은 거리에 있는 점들이 원으로 나타나는데, $L_{\infty} norm$은 사각형으로 나타난다. 처음 그림에서 네모 영역으로 그린 이유가 $L_{\infty} norm$을 사용했기 때문이다. 

이러한 adversarial example들은 웬만한 이미지에 대해서 모두 찾아낼 수 있다. 그리고 만약 training data가 똑같다면 NN1과 NN2가 완전히 다르다 할지라도 NN1이 속는 이미지를 NN2에 주면 NN2도 속을 가능성이 크다고 한다. 다시말하면 특정한 구조의 NN의 특정한 이미지에 대해서만 adversarial example을 찾아낼 수 있는 것이 아니고 거의 모든 구조의 거의 모든 이미지에 대해  adversarial example들을 찾아낼 수 있다. 

---

### 3. Threat Models

이제 이러한 adversarial sample들을 만들어내는 공격 기법에 대해 살펴보자. 

#### White-box Attacks

White-box는 어떤 이미지들을 이용해서 어떤 구조의 NN을 만들었고 node랑 layer 몇개씩 사용했고 connection weight을 이렇게 썼다라는 것을 모두 알려준다. 이런 정보를 기반으로 NN을 속이는 이미지를 만들어내는 것이다. White-box는 공격자 한테 유리한 기법이 된다. 

![image](https://user-images.githubusercontent.com/61526722/123545491-3be59c80-d793-11eb-83f3-6ef99dca59a0.png)


#### Black-box Attacks

Black-box은 training data는 알려주고 query를 날릴수는 있지만 어떠한 NN을 사용했는지 알려주지 않은 상태에서 NN을 속이는 이미지를 만들어낸다. 
Black-box는 공격자에게 불리한 기법이다. 

![image](https://user-images.githubusercontent.com/61526722/123545509-51f35d00-d793-11eb-95bc-d804cd0e536e.png)

아까 adversarial example은 특정 구조에 특화되어 있지 않다고 했다. 구조가 달라져도 training data가 같으면 adversarial example을 넣었을 때 속을 가능성이 높다. 따라서 임의의 NN model을 하나 만들고 white-box처럼 adversarial example을 찾아내면 된다. 

#### Targeted vs. Untargeted Attacks

Untargeted Attacks은 정답이 아닌 값을 말하는 adversarial example을 찾아내는 것이고, 

![image](https://user-images.githubusercontent.com/61526722/123545672-27ee6a80-d794-11eb-9267-2792dfbd28ee.png)

Targeted는 의도된 틀린 값을 말하는 adversarial example을 찾아내는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/123545679-376db380-d794-11eb-94da-2026074fe4f1.png)

---

### 4. One Step Gradient Method

Black-box와 White-box외의 attack 기법인 One Step Gradient Method가 실제로 attack을 어떻게 하는지 adversarial sample들을 어떻게 만들어내는지 살펴보자. 

####  Untargeted: Fast Gradient Sign Method (FGSM)

실제로 NN을 잘 속이는 이미지를 만들어내는 것은 cost가 비싸다. FGSM는 공격의 품질보다는 공격의 스피드를 빠르게 하는 기법이다. 

공격에서 찾고자 하는 것은 loss가 최대가 되는 x이다. 간단하게 loss 함수를 최대화하면 되는 거니깐 gradient ascent method를 사용하면 될것이다. 학습할 때는 w로 미분을 했지만 여기서는 loss를 x에 대해 미분해서 loss를 증가시키는 방향으로 가면 된다. 단 두 점의 거리가 $ \epsilon$보다 작아야한다. 

![image](https://user-images.githubusercontent.com/61526722/123546320-19558280-d797-11eb-8623-1665a1ebc8a3.png)

![image](https://user-images.githubusercontent.com/61526722/123546154-6422ca80-d796-11eb-9b5a-0fca203b3022.png)
 
이를 반복적으로 진행하면 시간이 많이 걸리니깐 FGSM에서는 <mark>gradient ascent를 딱 한번</mark>만 한다. 여기서 signed인 이유는 기울기는 방향과 길이를 나타내는데 그 중에서 길이는 무시하고 방향만 취해서 그 방향으로 $ \epsilon$만큼 이동한다. 우리는 loss가 최대화 되는 지점을 찾아야하는데 FGSM은 현재 위치에서의 기울기가 가장 급한 방향으로 한 번 점프해서 $x_{t}$를 구하기 때문에 빠르지만 좋은 공격 기법은 아니다.  

#### Randomized Fast Gradient Sign Method (RAND+FGSM)

따라서 이를 극복하기 위해 FGSM을 변형한 몇 가지 방법들이 나왔다. FGSM은 주어진 자리에서 출발했다면 RAND+FGSM은 아무 방향으로나 $\alpha$만큼 랜덤하게 점프를 한 다음에 그 자리에서 원래 지점의 기울기방향으로 $ \epsilon - \alpha$ 이동한다. 그러면 총 이동 길이는 $ \epsilon$이 된다. 

![image](https://user-images.githubusercontent.com/61526722/123546334-24a8ae00-d797-11eb-90a9-b3494bcce047.png)

![image](https://user-images.githubusercontent.com/61526722/123546305-09d63980-d797-11eb-96bc-d23e8dc162c8.png)

RAND+FGSM가 FGSM가 더 좋다고 알려져 있는데 그 이유는 다음과 같다. 처음의 x는 loss가 0에 가까운 부분으로 gradient가 굉장히 작다. 왜냐면 이 training data에 맞추려고 학습되었기 때문이다. 하지만 한 번 랜덤하게 다른 지점으로 이동해서 gradient ascent를 하면 더 좋은 지점으로 갈 수 있을 것이다. 

---

### 5. Iterative Methods

One Step Gradient Method는 한번만 이동하는 방법이라고 했는데 Iterative하게 이동하는 방법도 있다. 이 방법은 공격 이미지를 만드는데 시간이 오래걸린다는 단점이 있다.  

#### Basic iterative method 

![image](https://user-images.githubusercontent.com/61526722/123546511-c9c38680-d797-11eb-91ef-f169a040bf76.png)

![image](https://user-images.githubusercontent.com/61526722/123546651-7aca2100-d798-11eb-9349-349036cf263e.png)

여기서는 gradient의 방향만 가져와서 그 방향으로 $\alpha$만큼씩 점프를 한다. 이때 축이 여러개가 있으면 어떤 축으로는 $ \epsilon$을 벗어날 수도 있다. 그러면 벗어난 축은 $ \epsilon$범위 안으로 projection을 시켜야 하는데 이를 clip이라고 한다. 이를 정해진 횟수 N만큼 반복한다. 

![image](https://user-images.githubusercontent.com/61526722/123546696-aa792900-d798-11eb-8477-aa8735b6d615.png)

위 그림처럼 iterative method가 one step method보다 더 사실적인 공격이미지를 만들어내는 것을 확인할 수 있다. 

#### Projected Gradient Descent (PGD)

여기에 random start도 조금 넣으면 되지 않을까라고 생각할 수 있다. 그 중 하나가 PGD라는 방법인데 PGD는 지금까지 알려진 가장 강력한 공격기법이다.

![image](https://user-images.githubusercontent.com/61526722/123546977-da74fc00-d799-11eb-9c8d-cde1dd2e6c14.png)

PGD는  random하게 점프를 한 다음에 반복적으로 gradient ascent 방법을 적용한다. 그리고 PGD는 공격을 한 번만 하지 않고 공격에 실패하면 다시 random jump를 하고 iterative하게 gradient ascent를 해서 속으면 stop한다. 다시말해서 속는 이미지를 만들 때까지 계속 반복한다. 따라서 PGD를 이용하면 거의 웬만하면 속이는 이미지를 찾아낼 수 있다. 대신 시간을 엄청 오래 걸리 것이다. 

---

### 6. Defense

지금까지 NN을 속이는 이미지를 만드는 attack 기법들을 봤다면 이번에는 속이는 이미지가 NN에 들어와도 안 속게 하는 defense 기법을 살펴본다. Defense에는 크게 다음과 같은 세가지 방법이 있다. 

#### Adversarial Training

Adversarial Training는 일종의 data augmentation이다. 먼저 NN을 학습하고 만약 NN이 못맞추는 공격 이미지가 들어오면 label을 달아서 training set으로 넣자는 아이디어다. 물론 무자비하게 늘려가면 안된다. 원래 데이터와 NN이 못맞추는 취약한 데이터들을 얼만큼의 비율로 섞어서 다음 학습을 진행할지도 잘 정해줘야 한다. Adversarial Training에 다음과 같은 기법들을 추가하기도 한다.

- Adversarial Logit Pairing: softmax의 입력이 logit인데 원본이미지x의 logit 값과 속이는 이미지x'의 logit 값은 같아야 한다는 것이다. 이를 loss에 추가한다. 
- Defensive Distillation: 큰 NN이 학습한 내용을 작은 NN에 집어넣는 것이다. 모델이 작아지면 오버피팅이나 노이즈 요소가 많이 줄어서 훨씬 일반화가 잘 되는 모델이 얻어지기도 한다. 
- Label Smoothing: NN이 1이 아닌 0.9라도 해도 맞았다고 한다.

#### Filtering/Detecting

이미지가 들어오면 detector를 거치는데 detector는 이미지가 나를 속이려고 하는 것인지 정상적인 이미지인지 판단한 다음에 정상적인 이미지이면 NN에 집어넣고 비정상이라고 판단되면 버린다. 

#### Denoising (Preprocessing)

원래 이미지에 노이즈를 섞었는데 NN에 이미지가 들어오면 그대로 집어넣지 말고 노이즈를 제거한 다음에 NN에 집어넣자는 아이디어다. 간단히 NN앞에 denoising 모듈을 붙여서 노이즈를 제거하면 NN가 안속을거 아니냐고 생각한 것이다. 

하지만 detector나 denoising 모듈은 보통 NN으로 만들어지는데 이 또한 공격당할 수도 있다. 그러면 미분 불가능한 모델로 만들면 되지 않을까 생각할 수 있지만 이를 근사시키는 미분 가능한 모델을 만들어 공격하면 되기 때문에 attack을 피해갈 수 없다. 

---

이번 문서에서는 Adversarial Attacks이 왜 가능하며 어떻게 방어해야 하는지에 대해 살펴봤다. 하지만 정확한 원인은 모르기 때문에 아직도 연구되고 있는 분야이다.







