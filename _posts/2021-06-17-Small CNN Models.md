---
layout: post
title: Small CNN Models
date: 2021-06-17
category: DeepLearning
use_math: true
---

앞에서 학습했던 CNN 모델들은 상당히 학습 파라미터의 양도 많고 계산량도 많다. 지금까지는 사람들은 accuracy를 높이는 방향으로 상당히 큰 CNN 모델들을 사용했는데, 이번에는 약간 다른 방향으로 모바일 환경에서도 사용할 수 있는 상대적으로 작은 경량화된 CNN 모델을 만들어보고자 했다. 이 작고 경량화된 CNN 모델이 Small CNN 모델이다. Accuracy를 약간은 손해보고 계산량을 줄이는 방식이라고 할 수 있다. 물론 최종목표는 accuracy의 손해 없이 CNN을 경량화시키는 것이다. 

---

### 1. Huddles against Small Networks

CNN을 small network로 만들 때 고려해야 하는 것은 <mark>fully connected layer</mark>이다. FC layer는 학습 파라미터의 양이 굉장히 많다. 아래 모델에서 FC layer바로 앞부분에 13x13x256x4096개의 connection이 존재한다. 다음 부분에서는 4096x4096개, 다음은 4096x1000개의 connection이 존재한다. 

![image](https://user-images.githubusercontent.com/61526722/122007938-73e3fb80-cdf3-11eb-957c-7f9bac25b94b.png)

다음으로 small CNN을 만들 때 고려해야 할 것은 <mark>filter의 크기</mark>이다. 빨간색 부분에서 filter에 들어가는 학습 파라미터의 개수는 3x3x384x384 이다. 이때의 operation 개수는 학습 파라미터의 개수에 feature map의 크기를 곱한 3x3x384x384x13x13 개 이다.

![image](https://user-images.githubusercontent.com/61526722/122008667-45b2eb80-cdf4-11eb-9c32-4d9cd049ef44.png)

따라서 경량화된 CNN을 만들기 위해서는 어떻게 convolution 연산을 줄인것인가와 dense layer를 어떻게 줄일것인가가 중요하다. '

---

### 2. MobileNet-v1

#### Depthwise Separable Conv

MobileNet-v1는 convolution을 경량화 시키기 위해 Depthwise Separable Conv를 제안했다. 

![image](https://user-images.githubusercontent.com/61526722/122022960-11dec280-ce02-11eb-9f9c-1a27febf66f0.png)

Regular conv는 output channel을 n개 만들고 싶으면 filter의 개수가 n개가 있어야 한다. Depthwise Separable Conv는 2단계로 나뉜다. 첫번째는 deptiwise conv로 입력을 채널별로 나눈 후 채널별로 filter를 하나씩 두고 conv를 실행한다. 실행한 결과는 다시 합쳐준다. 두번째는 pointwise conv로 1x1 conv를 통해 채널의 수를 줄여준다. 채널별로 섞이지 않은 정보를 섞어서 1개의 채널로 만들어준다. 두 방법은 수학적으로 같지는 않지만 의미적으로 같다. 정리하면 Depthwise Separable Conv는 각 채널에만 존재하는 local pattern을 찾아낸 다음에 각 채널에 존재하는 local pattern을 통합하는 것이다. 

두 방법이 계산량에 차이가 없는 것처럼 보이지만 만약 3개의 채널을 가진 출력을 얻으려면 차이가 커진다. Regular conv는 3x3x3블럭이 3개가 있어야하는 반면 Depthwise Separable Conv는 1x1x3 filter가 3개가 있으면 된다. 전체적으로 계산량도 줄고 학습 파라미터의 개수도 줄어들 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122023306-5ff3c600-ce02-11eb-87dd-7a650856ecaf.png)

두 방법의 계산량과 파라미터 개수를 계산하여 일반화하면 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/122024547-7fd7b980-ce03-11eb-8556-d5220f16c002.png)


아래 그림은 Depthwise Separable Conv를 다시 표현한 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122023941-f6c08280-ce02-11eb-9102-d5264948f813.png)

depthwise conv는 spatial correlation을 찾아낸다. 채널에 존재하는 공간상의 위치를 파악하는 것이다. 다음으로는 채널별 정보를 통합하는 pointwise conv가 있다. 

![image](https://user-images.githubusercontent.com/61526722/122025142-12785880-ce04-11eb-9b86-841c426fb8b4.png)

Regluar conv는 3x3conv-BN-ReLU로 구성되지만 Depthwise Separable Conv는 3x3conv-BN-ReLU-1x1conv-BN-ReLU(or ReLU6)로 구성된다. ReLU나 ReLU6는 큰 차이가 없지만 NN의출력이 ReLU를 쓰면 0에서 무한대까지 나오는데 ReLU6쓰면 0에서 6사이의 값이 나온다. 차이는 출력을 표시할 수 있는 비트 수에 있다. ReLU는 16이나 32비트를 써야 출력값을 표시할 수 있다면 ReLU6는 4비트나 8비트를 쓰면된다. 이러한 이유로 경량회된 NN에서는 ReLU대신에 ReLU6를 많이 사용한다. 

MobileNet-v1의 구조이다. 

![image](https://user-images.githubusercontent.com/61526722/122026572-4e5fed80-ce05-11eb-9c1f-052ad89ef0f2.png)

#### Width Multiplier and Resolution Multiplier

MobileNet-v1에서는 Depthwise Separable Conv말고 두 가지를 더 제안한다. <mark>Width Multiplier와 Resolution Multiplier</mark>는 성능 좋은 base model을 하나 찾아놓고 base model을 기반으로 살짝살짝 손을 봐서 더 손쉽게 더 경량화된 모델을 만드는 방법을 공부한 것이다. 

Width Multiplier는 각 conv에서 채널의 수를 조정해본다. Width Multiplier를 $\alpha$로 고정하고 각 conv의 채널수에 모두 $\alpha$를 곱한다. base model은 바꾸지 않고 채널의 개수를 일괄적으로 계속 줄여가면서 조절하는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122028232-caa70080-ce06-11eb-8875-50cf55380fed.png)

Resolution Multiplier는 입력의 사이즈를 줄여서 CNN에 넣는 것이다. CNN에서는 보통 입력의 크기가 고정되어 있는데 입력의 크기가 크면 당연하게 CNN의 계산량이 증가한다. 입력의 면적에 비례해서 계산량이 줄어들기 때문에 동일한 구조의 CNN을 쓰더라도 계산량은 줄어든다. 하지만 입력의 크기를 줄이면 성능은 떨어지기 마련이다. 

![image](https://user-images.githubusercontent.com/61526722/122028925-705a6f80-ce07-11eb-9bc1-22cf01094062.png)

이런 방식으로 앞에서 정의한 base model에 Width Multiplier와 Resolution Multiplier를 계속 곱해가면서 가장 좋은 것을 찾아낸다.

#### Global Average Pooling

하지만 어떻게 입력의 사이즈가 바뀌는데 같은 구조의 CNN을 사용해도 될까. 사실은 입력의 크기가 바뀌면 convolution feature extraction과 FC layer를 연결하는 부분에서 구조의 변화가 생긴다. 왜냐하면 feature extraction에서 나오는 결과를 flatten하게 바꿀 때 이미지의 사이즈가 바뀌면 flatten된 벡터의 크기도 변할 것이기 때문이다. 이를 해결하기 위한 것이 <mark>Global Average Pooling</mark>이다.

Global pooling은 전체이미지를 하나로 바꾸는 것이다. 하나로 바꿀때 전체를 평균낸 값으로 바꾸는 것이 global average pooling이고, 가장 큰것 하나를 뽑아내는 것이 global max pooling이다. 

![image](https://user-images.githubusercontent.com/61526722/122030723-fd51f880-ce08-11eb-8b1c-11f34e406d0a.png)

Global average pooling을 쓰면 정말로 NN의 구조변화가 필요없는지 확인해보자. 

![image](https://user-images.githubusercontent.com/61526722/122031217-78b3aa00-ce09-11eb-91af-f06da7f4caf1.png)

위 그림에서 볼 수 있듯이 우리가 flatten이 아니라 global average pooling을 쓰면 입력의 사이즈가 바뀌더라도 동일한 NN을 쓸수 있다. 물론 입력의 크기를 128로 했을 때와 256으로 했을 때의 학습은 다르다. connection weight가 다 달라져야 하겠지만 NN의 구조는 변화없이 입력만 변화시키는 것이 가능하다.  

파라미터의 수를 줄이겠다고 depth를 줄이는 것보다는 channel 수를 줄이는 것이 좋다. 이말은 channel multiplier를 사용하는 것이 좋다는 말이다. 마지막 테이블은 사이즈를 변경한 것인데 NN의 구조가 바뀌지는 않으므로 파라미터의 수는 동일하지만 계산량은 줄어든다. 

![image](https://user-images.githubusercontent.com/61526722/122032125-4eaeb780-ce0a-11eb-8c1e-edd9df9373ba.png)


---

### 3. MobileNet-v2

MobileNet-v1에서 제안된 depthwise seperable convolution은 depthwise conv와 pointwise conv 두 부분으로 구성되어 있다. MobileNet-v2에서는 bottleneck residual block을 제안한다. 

![image](https://user-images.githubusercontent.com/61526722/122047733-6f333d80-ce1b-11eb-9176-8f116407f58d.png)

Bottleneck residual block은 처음에 1x1 conv를 통해 채널 수를 늘려주고 3x3 depthwise conv를 통해 채널을 다시 줄여주고 1x1 projection을 해준다. 이를 다시 그리면 다음과 같다. 

![image](https://user-images.githubusercontent.com/61526722/122047812-87a35800-ce1b-11eb-8854-0e41ecef73e1.png)

이 블럭은 두번 연속해서 그려서 설명해보면 빨간색 영역에서 projection은 1x1 linear만 있고 그 다음에는 1x1 conv가 있다. 1x1 linear와 1x1 conv를 합치면 수학적으로 1x1 conv와 동일한 연산이 된다. 결국은 depwise conv - pointwise conv가 연속적으로 일어나는 것이다. 직접적으로 1x1 conv를 하면되지 두 번을거쳤기 때문에 bottleneck에 해당된다. Bottleneck을 두는 이유는 필요없는 정보는 버리고 중요한 정보들만 넘기기 위함이다. Bottleneck layer를 통과하는데 accuracy 는 최대한 높이라고 하면 bottleneck layer는 중요한 정보만을 뽑을 것이다. 다른 말로는 manifold를 얻어내겠다는 말이 된다. 

![image](https://user-images.githubusercontent.com/61526722/122047968-b1f51580-ce1b-11eb-9f49-396da03eabc6.png)

#### Inverted Residual Link

그러면 왜 residual link를 아래쪽 그림처럼 할까. 위쪽은 블록의 입출력이 크기 때문에 계산량은 똑같지만 전달의 정보량이 크다. 아래처럼 상대적으로 작은 텐서를 가지게 됨으로써 계산할 때, 계산량을 다음 블록으로 전달할 때 그 전달의 파라미터가 줄어든다. 따라서 블록에서 나온 출력을 작은 캐시 메모리에도 들어갈 수 있고, 작은 입출력만 일어나게 해서 전반적으로 작은 디바이스에 적용할 수 있는 것이다.

![image](https://user-images.githubusercontent.com/61526722/122049571-8d01a200-ce1d-11eb-8d1c-215a7d9bee22.png)

이렇게 원래 처럼하지 않고 한번 옆으로 link를 옮겼다고 해서 inverted residual link이라고 한다. 다시말해서 internal한 계산을 입력과 출력으로 바꾼것이다. 

![image](https://user-images.githubusercontent.com/61526722/122053579-d5bb5a00-ce21-11eb-8b48-0bd777f4d7f6.png)


#### Projection convolution

Projection convolution에서 linear를 사용한다. ReLU는 50%의 확률로 0을 출력하는데 만약 projection에서 ReLU를 사용하면 결과에서 50%의 확률로 0을 출력하게 된다. Bottleneck의 임무는 앞단의 중요한 정보를 뽑는데 ReLU를 사용하면 반이 0이라는 것이다. 그래서 MobileNet-v2에서는 ReLU를 사용하지 않았다고 한다. 하지만 bottleneck의 채널 수가 충분히 크다면 ReLU를 사용해도 충분히 중요한 정보를 추출할 수 있을 것이다. 이것을 아래 그림이 증명해준다. 

![image](https://user-images.githubusercontent.com/61526722/122052881-2088a200-ce21-11eb-9408-6f125d57ee87.png)

출력의 채널을 점점 높여가면 이미지가 충분히 복원된다는 것을 보여준다. 즉, 출력 채널이 작을 때 ReLU를 사용하면 정보 손실이 많다는 것이다. 

![image](https://user-images.githubusercontent.com/61526722/122053522-cb00c500-ce21-11eb-9933-7bce632f817e.png)

---

### 4. ShuffleNet

#### Group Convolution

ShuffleNet은 group convolution으로 동작하는 모델이다. 

![image](https://user-images.githubusercontent.com/61526722/122054814-ff28b580-ce22-11eb-81f6-0b1dabad5f40.png)

Regular conv는 filter 1개당 채널 1개를 만들어내니깐 filter가 $c_{2}$개 있어야 한다. 따라서 학습 파라미터의 개수는 $h_{1}w_{1}c_{1}c_{2}$ 개가 필요하다. Group conv는 group이 2라는 가정하에 채널을 두개로 자른 다음 앞쪽채널들끼리만 conv를 하고 뒷쪽 채널들끼리만 conv를 한다. 따라서 학습 파라미터의 개수는 $h_{1}w_{1}(c_{1}/2)(c_{2}/2) + h_{1}w_{1}(c_{1}/2)(c_{2}/2)$가 되어 전체적인 학습 파라미터 수는 절반으로 줄어든다. 만약에 그룹이 3개가 되면 학습 파라미터의 양은 1/3로 줄어들것이다. 계산량도 이에 비례해서 줄어든다. 

#### Channel Shuffling

하지만 group convolution은 그룹별로 정보가 섞이지 않는다는 문제가 있다. 따라서 channel shuffling이라는 연산을 집어넣어 채널별 출력을 섞는다. 이것들을 다시 group conv로 집어넣으면 계산량은 줄어들고 채널끼리 섞어야하는 정보들을 잘 섞는 구조를 만들어 낼 수 있다. 

![image](https://user-images.githubusercontent.com/61526722/122055975-203dd600-ce24-11eb-8ad5-97d2529df43b.png)

더 자세한 것은 논문을 참고하면 된다. 

---

### 5. SqueezeNet


SqueezeNet은 먼저 1x1 conv를 통해서 채널 수를 줄이고 그다음에는 1x1 conv와 3x3 conv를 같이 사용하여 계산량을 줄였다. 

![image](https://user-images.githubusercontent.com/61526722/122056659-c38eeb00-ce24-11eb-822d-40ea13cc8c4c.png)

---

### 6. Xception

Xception은 Depthwise Separable Convolution과 비슷하다. 

![image](https://user-images.githubusercontent.com/61526722/122056760-e6b99a80-ce24-11eb-9273-49a36122ce03.png)

Depthwise Separable Convolution은 depthwise conv 후에 pointwise conv를 적용한다. 하지만 Xception에서는 순서를 바꾸어 pointwise conv를 먼저 사용해 채널들을 통합한 후에 새로운 채널들을 만들고 그 새로운 채널들에 대해서 depthwise conv를 적용한다. 

---

이런식으로 경량화된 CNN을 만들기 위한 많은 연구들이 존재한다. 

















