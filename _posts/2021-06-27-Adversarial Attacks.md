---
layout: post
title: Adversarial Attacks
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

그림에서 네모 안의 영역이 의미하는 것은 사람이 가운데 점의 이미지와 구분을 못하는, 사람 눈에는 동일하게 보이는 것들의 영역이다. 이때 경계선을 그린 후에 빨간색 별에 해당하는 그림을 보여주면 사람과 NN은 다르게 대답한다. 이 빨간 점들이 adversarial example이다. 

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






























