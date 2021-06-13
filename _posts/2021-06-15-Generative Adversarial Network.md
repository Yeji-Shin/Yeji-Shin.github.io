---
layout: post
title: Generative Adversarial Network
date: 2021-06-15
category: DeepLearning
use_math: true
---

Generative Adversarial Network (GAN)은 지금까지 다뤄왔던 모델들과는 조금 다른 구조를 가지고 있다. GAN은 generative model중 하나이며 적대적으로 학습을 진행한다.
이제 generative model이 무엇인지, 적대적으로 학습하는 것이 무엇을 의미하는지 하나씩 살펴보자. 

---

### 1. Discriminative Model and Generative Model

지금까지 우리가 공부했던 모델들은 discriminative models이다. Discriminative model은 NN에 X를 주면 Y를 출력하는 구조를 말한다. 주어진 입력이 강아지인지 고양이인지 구별하는 NN이라는 말이다. Y는 softmax 값으로 나왔고 우리는 이를 확률로 이해했다. 즉, $P(X|Y)$ 를 구했던 것이다.

이와 다르게 generative Model은 X만을 입력으로 받아서 P(X)를 출력한다. 예를 들어 여러장의 강아지 사진을 가지고 NN을 학습시킨 다음에 특정 사진을 보여주고 그것이 강아지일 확률을 출력하는 것이다. 다르게 말하면 강아지 사진이 분포하는 영역 P(X)을 확인한 후에 샘플링 기법을 통해서 새로운 이미지를 생성해내는 것이다. 

---

### 2. Generative Adversarial Network (GAN)

GAN은 두 개의 NN으로 이루어진 시스템이다. Generator와 discriminator이다. 

![image](https://user-images.githubusercontent.com/61526722/121808368-12a51680-cc93-11eb-8928-c93c076749c8.png)

Generator는 random noise 벡터를 기반으로 가짜 이미지를 생성한다. Discriminator는 생성된 가짜 이미지와 훈련 데이터의 실제 이미지 중 하나를 골라서 해당 이미지가 진짜(1)인지 가짜(0)인지 판단한다. 이 때 generator는 dicriminator를 속일 만한 가짜 이미지를 생성하도록 학습되고 discrimnator는 속지 않도록 학습된다. 이러한 방식으로 적대적으로 학습하여 결국 generator는 진짜 같은 이미지를 만들고 discriminator는 그것을 구분못할 것이다. 마지막에 우리는 generator만 가져다가 쓰면 된다. 

#### Objective Function

GAN의 Objective Function은 아래와 같다. 여기서 $\theta$ 는 connection weight이다. 

![image](https://user-images.githubusercontent.com/61526722/121808866-72042600-cc95-11eb-8f9d-d0ab8178af12.png)

먼저 ①번은 training data에 속하는 어떤 x에 대해서 discriminator의 출력값에 log 씌운것의 평균이다. 그럼 discriminator는 진짜(1)이라고 말해야 될것이고 log(1)=0이 된다. 즉, 진짜 이미지를 진짜라고 판단하면 0이 나오고, 진짜 이미지를 가짜라고 판단하면 -무한대가 나올 것이다. 따라서 discriminator는 이 수식을 최대화하면 된다. 

다음으로 ②번은 random noise(가짜 이미지)에 대해서 discriminator는 가짜(0)이라고 말해야 될 것이고 그 때의 log(1-0)=0가 된다. 반대로 가짜 이미지를 진짜(1)라고 판단하면 그 때의 log(1-1)=-무한대가 된다.

정리하면 objective function은 discriminator가 진짜 이미지를 진짜로 판단하고, 가짜 이미지를 가짜로 판단할 때 최대화가 되도록 디자인 되어 있다. 따라서 학습시킬 때는 objective function가 최대화가 되도록 gradient ascent method로 학습시킨다. 

반대로 generator는 이 objective function 최소화하도록 학습된다. 결론적으로 한 번은 objective function가 최대화되도록 D의 weight를 학습하고, 한 번은 objective function이 최소화되도록 G의 weight를 학습시킨다. 하지만 이 구조는 수렴이 보장되지 않아 generator가 항상 성공적으로 학습된다고는 할 수 없다. 

#### Cost Function

GAN을 학습시킬때는 discriminator는 objective function을 그대로 가져와서 그 수식이 최대화가 되로록 connection weight를 학습시킨다. Generator도 마찬가지로 objective function이 최소화가 되도록 connection weight을 학습시키는데 잘 보면 ①번은 generator에 대해서 상수의 항이다. 따라서 아래와 같이 cost function 이 정의된다.

![image](https://user-images.githubusercontent.com/61526722/121809457-d58f5300-cc97-11eb-81e0-4ff745ef4a6c.png)

결국 똑같은 loss 함수를 이용하긴 하지만 cost function은 약간 다르게 정의되는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121809523-0ec7c300-cc98-11eb-8537-b12529d85434.png)

이렇게 학습을 진행하면 discriminator가 50%의 확률로 이미지가 진짜인지 가짜인지 판단할 때, 다시말해 진짜인지 가짜인지 잘 모르겠다라고 말할 때 optimal solution이 존재한다고 한다.

#### Training Algorithm

![image](https://user-images.githubusercontent.com/61526722/121809636-8e559200-cc98-11eb-9023-11e45428e506.png)

그림을 보면 discriminator를 k번, generator를 1번 학습하는 것이 1 iteration임을 알 수 있다. Discriminator는 왜 여러번 학습할까. 만약 discriminator가 바보라면 어떤 이미지를 보여줘도 진짜인지 가짜인지 헷갈려한다면 generator더 학습될 필요가 없다. 따라서 GAN은 discriminator를 똑똑하게 만드는 것이 중요하다고 볼 수 있고 discriminator을 여러번 학습시켜서 generator가 더 똑똑해지도록 하는 것이다. 

하지만 그냥 1번씩 학습하는 옵션도 있으니 필요에 따라 설계하면 된다.

#### Problem in Training Generator

Generator의 학습 과정을 보면 loss는 아래와 같이 변한다. x축이 0.0인 부분은 generator가 아직 학습이 되지 않은 상태이고, 1.0인 부분은 학습 완료된 상태이다.

![image](https://user-images.githubusercontent.com/61526722/121810253-0fae2400-cc9b-11eb-8848-9ea9499a77be.png)

이 때 이상한 것은 loss의 gradient가 학습이 완료되수록 커진다는 것이다. 다시말해서 우리가 사용하고 있는 loss함수는 학습이 안됐을때는 gradient가 작고 학습이 됐을때는 gradient가 크기 때문에 generator의 학습이 잘 될리가 없다는 문제가 있다. 따라서 loss를 아래 형태로 변형하여 학습을 진행한다. 

![image](https://user-images.githubusercontent.com/61526722/121810399-b397cf80-cc9b-11eb-9917-8232251b7119.png)

물론 이렇게 바꾼다고 해서 GAN이 optimal soltuion으로 수렴하냐는 보장되지 않는다. 할 수도 있고 못 할 수도 있다. 그 이유는 gradient descent나 gradient ascent method는 objective funtion를 풀기위한 방법이 아니다. 그저 이것을 풀 수 없으니 할 수 없이 gradient descent나 gradient ascent method를 사용해서 objective funtion을 푸는 척하고 있는 것이다. 

---

### 3. Advantage of GAN

- sampling이 직관적이다.
- Maximum Likelihood estimation을 사용하지 않는다. GAN구조로 생성된 이미지들은 굉장히 선명하다. 
- 오버피팅에 robust하다. Generator는 training data를 한번도 보지 않는다. 따라서 training data에 존재하는 bias들의 영향에서 상대적으로 자유롭다는 말이다.
- distribution의 mode를 잘 캡처한다. 

GAN구조로 생성된 이미지들은 굉장히 선명하다고 했는데 그 이유를 살펴보자. 

![image](https://user-images.githubusercontent.com/61526722/121811267-d081d200-cc9e-11eb-8b1f-700031d36234.png)

Autoencoder는 또 다른 generataive model이다. Autoencoder를 학습시킨 다음 decoder만 가져와서 random noise를 주면 가짜 이미지를 만들 수 있다. 이렇게 generator를 만들 수 있지만 여러가지 문제가 있다. 예를 들어 벡터가 200차원이라고 하면 200차원 공간에 벡터를 뿌리면 예쁜모양으로 나오지 않고 이상한 모양으로 나온다. (이를 entangle 되었다고 한다.) 그러면 z를 선택할 때 이미지가 존재하는 영역에서 뽑아야 하는데 이 영역이 이상한 모양으로 나오기 때문에 그것을 알아내기 쉽지 않아 z를 올바르게 선택할 방법이 존재하지 않는다. 이 문제를 해결하는 것이 VAE이다. 만약 VAE로 z를 제대로 뽑았다고 하더라도 생성된 가짜 이미지의 퀄리티가 굉장히 낮다. 그 이유는 AE를 학습시킬 때는 loss 함수로 MSE를 쓸수 밖에 없는데 MSE를 쓰면 training data와의 거리의 제곱을 최소화시키는 지점으로 수렴하게 된다. 하지만 이 지점은 아래와 같이 가지고 있는 training data의 분포에서 벗어난 지점이다.  

![image](https://user-images.githubusercontent.com/61526722/121811220-b47e3080-cc9e-11eb-84c4-2ba7b4c1e996.png)

따라서 autoencoder는 흐릿한 이미지를 생성한다. GAN은 MSE loss를 사용하지 않고 discriminator를 속이라고 하기 때문에 training data가 있는 분포 내에서 샘플링을 한 후에 generator의 입력으로 준다. 

---

### 4. Issue of GAN

계속 말했지만 GAN의 optimal solution은 존재하지만 SGD는 GAN 문제의 optimal solution을 찾기 위해 디자인된 것이 아니다. 우리는 generator에게 discriminator를 속이라고 하지 진짜 같은 이미지를 만들라고 하지는 않는다. 따라서 optimal solution에 갔더라도 그것이 그림을 잘 그리는 지점이 아닐 수 있다. 즉, 진짜 같은 그림을 그리지는 않지만 discriminator를 속일 수 있는 지점에 빠져서 우리가 진짜 원하는 optimal point에 가지 못할 수도 있다는 것이다. 이것이 <mark>mode collapse</mark>라는 문제이다. 

예를 들어 강아지 그림을 그리는 generator를 학습한다고 생각하자. 강아지에는 진돗개, 푸들, 포메라니안 등등 종이 다양한데 이 때 generator는 모든 종의 강아지를 다 잘그리려고 하는 것이 아니라 한 종류의 강아지만 잘 그리려고 한다. 당연히 generator입장에서 discriminator를 빨리 속일 수 있는 방법은 한 종류만 그리는 것이다. 이렇게 푸들만 잘 그려내도 discriminator는 속는다. 그러면 discriminator입장에서 보면 유독 푸들 그림을 보면 잘 속는다고 생각하고 generator가 푸들만 그리는구나라고 깨닫게 될것이다. 그 다음부터는 푸들이 들어오면 discriminator가 가짜라고 말할 것이다. 그러면 이번에는 generator가 진돗개를 잘 그리려고 한다. 계속 반복되어 어느 순간 generator가 수렴했을 때 어떤 특정 그림만 그리고 있을 것이다. 여기서 강아지의 종을 mode라고 하고 하나의 종만을 잘 그린다는 의미로 mode collapse라고 하는 것이다.

![image](https://user-images.githubusercontent.com/61526722/121812043-5a329f00-cca1-11eb-8270-601e51b3d1c1.png)
![image](https://user-images.githubusercontent.com/61526722/121812133-bac1dc00-cca1-11eb-88e0-47f1950ab884.png)


아래 예시는 mode collapse를 쉽게 표현한 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121812091-99f98680-cca1-11eb-8164-deca1ed57a6d.png)

---

### 5. Improving Techniques

Mode collapse가 일어나지 않게 하려면 어떻게 해야할까.

#### Feature matching

Generator에게 discriminator를 속이라고 하지말고 진짜 같은 그림을 그리라고 하는 것이다. 다시말해서 discriminator의 feature extraction 부분의 중간 단계에서 나오는 가짜 이미지의 특징들을 실제 이미지의 특징들과 비슷하게 만들라고 하는 것이다. 이 방법은 학습과정을 안정화시킨다.

![image](https://user-images.githubusercontent.com/61526722/121812587-56078100-cca3-11eb-8c6e-fd0d3499f9ea.png)

![image](https://user-images.githubusercontent.com/61526722/121812629-84855c00-cca3-11eb-8ebc-dabc215c16c7.png)


#### Historical averaging

Generator가 mode를 갑자기 바꿀 때 다른 그림을 그려야 하니깐 connection weight값들이 급격하게 계단식으로 널뛰기 하면서 바뀔것이다. 따라서 mode collapse를 방지하지 위해 connection weight가 급격하게 변하는 것을 규제하는 것이다. 이렇게 하면 generator는 mode를 바꾸기 어렵게 되어 전부를 다 학습하게 된다.

![image](https://user-images.githubusercontent.com/61526722/121812823-55bbb580-cca4-11eb-8305-b2ee5cfac383.png)

#### Minibatch Discrimination

Discriminator에게 mode collapse가 일어났다는 시그널을 추가적으로 준다. 가짜 이미지 x가 존재했던 mini-batch의 다른 이미지들과 x의 유사도를 계산하여 추가적인 정보 $o(x)$를 준다. $o(x)$가 크다면 fake image일 확률이 크다. real image mini-batch에는 당연히 다양한 종류의 이미지들이 존재할 것이기 때문이다. 따라서 $o(x)$만 보고도 충분히 진짜 이미지인지 가짜 이미지인지 추론할 수 있다는 것이다. 그러면 mode collapse가 일어나는 순간 discriminator가 깨닫게 될 것이므로 generator는 real image에서 나오는 $o(x)$와 비슷한 $o(x)$를 내보내는 fake image mini-batch를 만들 것이다. 

![image](https://user-images.githubusercontent.com/61526722/121813140-a41d8400-cca5-11eb-8d73-f0bdd8e24888.png)

Fully connected, fully connected, copy해서 더하고 다시 fully connected layer를 써서 0/1을 구분하게 만든다.

---

정리하면 GAN에서 가장 어려운 것은 수렴되지 않는다는 것이다. 그 이유는 generator한테 discriminator를 속이라고 했지 진짜 같은 이미지를 만들라고 하지는 않았기 때문이다. 그래서 생기는 문제가 mode collapse이고 그것을 해결할 수 있는 방법들에 대해 알아보았다. 





