# Private Transfer Example 

## What is Record?

### 1. Bitcoin UTXO
UTXO 모델을 사용하는 Bitcoin은 결제를 위해 설계되었다. 
- UTXO 모델의 장점은 트랜잭션 검증 중 계산이 off-chain에서 수행된다는 것이다. 트랜잭션은 계산 결과이자 증명인 셈이다. 트랜잭션은 블록체인에 저장하는 것으로 충분하며 추가로 전역으로 상태를 처리할 필요가 없다. 트랜잭션은 항상 사용되지 않은 UTXO이며 이를 쉽게 확인이 가능하다. 그래서 중복 트랜잭션이나 입력값을 사용할 수 없다. 
- 그러나 Bitcoin UTXO 모델은 프로그래밍 가능성이 매우 약하다. 복잡한 계산을 생성하는 것은 거의 불가능하다.

### 2. Ethereum Account
그래서 Ethereum이 Account 기반 모델을 최초로 고안해냈다. smart contract라는 복잡한 로직을 가진 프로그램을 작성할 수 있도록 했다. 해당 트랜잭션은 글로벌 상태를 변경하는 이벤트이다. EVM은 이전 블록체인 상태를 기반으로 이벤트의 상태 전환 결과를 계산한다. 
- 장점은 다수결 합의가 이뤄져 전역 상태가 잠겨져 있을 때에도 Account는 다른 작업이 가능하다는 것이다. 트랜잭션과 컨트랙트는 순차적으로 처리되기 때문에 가능하다. 
- 그러나 개발자는 트랜잭션과 컨트랙트 처리 순서를 결정할 수 없으며 이는 블록 생산자와 사용자의 손에 달려있다. 그래서 MEV, 샌드위치와 같은 여러 공격 시도를 조심해야 한다. 또한 병렬화의 복잡성, 트랜잭션이 자주 실패하고, 실패한 트랜잭션에 대해서도 수수료를 지불해야 한다는 점이다.

### 3. Cardano E-UTXO
Cardano는 Bitcoin의 UTXO의 줄기로 부터 이어진다. 개발자가 다양한 작업을 할 수 있게 해주는 스마트 컨트랙트 플랫폼이다. 그래서 확장된 개념이 필요하였다. 

이는 Account 기반 모델에 비해 몇 가지 장점을 제공한다.
- 특히 스마트 컨트랙트 실행 시 보안 강화, 수수료 예측 가능성, 제출 후 거래가 승인되도록 보장하는 로컬 검증, 본질적으로 파편화된 블록체인 상태 등이 있다.이는 트랜잭션 처리에서 병렬화를 가능하게 하며, 이는 온체인 확장성에 긍정적인 영향을 미친다. 병렬화는 스마트 콘트랙트 실행에도 중요하다. 트랜잭션과 마찬가지로 스마트 콘트랙트도 독립적으로, 즉 병렬로 실행할 수 있다.

### 4. Aleo Record
Aleo는 Privacy에 중점을 둔 블록체인으로, Leo라는 프로그래밍 언어를 고안해냈다. 그리고 UTXO-like Record 모델을 사용한다. 

Record는 Bitcoin의 결제 능력과 Cardano의 프로그래밍 가능성을 모두 가지고 있는 동시에 Privacy라는 개념을 추가하였다. apk라는 keyPair를 통해 각 Record의 권한이 설정되며, owner만의 이에 접근할 수 있다. 또한 Record는 key: value의 attributes들을 추가할 수 있는데, 이에 private, public 접근 권한이 가능하게끔 해놨다. 그래서 온체인 트랜잭션이 실행되어도 private된 attribute는 당사자 외에는 볼 수 없다. 

## How to get User Records?
각 User의 Record는 Block에 기록되어 있다. 이를 가져오기 위해서는 전체 블록 또는 특정 블록 기준 설정을 통해서 온체인 쿼리를 하여 가져와야 한다. 현재 [aleo-sdk](https://github.com/AleoHQ/sdk/blob/testnet3/sdk/src/network-client.ts#L102)에 구현되어 있다. 현재는 aleo credits만 조회가 가능하며, 추후 token의 표준, 사용성에 따라 그에 맞는 record 쿼리 메서드가 나올 것으로 보인다. 

<img width="778" alt="스크린샷 2024-04-05 오후 9 24 08" src="https://github.com/loosie/aleo_example/assets/54282927/1cf96ccd-d8be-4694-b8e4-441b62c92f18">

## Privte Transfer Example
해당 Repository에서는 local token program 코드를 사용해서 erc20-like record token을 직접 발행하고 private하게 transfer를 할 수 있는 예제 샘플을 만들었다. 

### How to get started
1. build token program
```
cd token
leo build 
```

2. try local mint & transfer script 
```
./1_local_mint.sh
./2_local_transfer.sh
```

3. back to root & npm install 
```
cd ..
npm i
```

4. frontend start
```
npm run dev 
```

5. generate Account
임의의 Account를 로컬에서 생성한다.
```
- accountId
- privateKey
- viewKey
```

6. select Token & mint 
원하는 token을 선택한 후에 직접 토큰을 총 100개를 발행한다. 

7. Check your records
현재는 token program run 결과를 parsing하여 로컬 상태에 저장해서 사용한다. 추후 온체인 쿼리하는 방식으로 변경이 필요하다. UI를 통해 직접 볼 수 있다. 여기서 중요한 것은 owner, nonce의 값이다. 
- owner: 해당 record 소유자를 의미한다. 다른 유저가 해당 record를 사용하게 되면 'aleo belong to the signer'라는 에러가 발생한다. 
- nonce: 해당 record의 고유 식별자를 생성하는 데 사용되며, owner의 주소 비밀 키 요청과 record의 시리얼 번호에 대한 PRF 평가를 통해 계산된다.

8. private Transfer 
record를 사용하여 직접 발행한 토큰 50개를 다른 유저에게 전송한다. 그러면 사용한 100개를 담고 있는 record는 사용되어 삭제되고, 새롭게 50개가 남은 나의 record와 50개를 새롭게 받은 상대방의 record가 2개 생성된다. 

<img width="874" alt="스크린샷 2024-04-05 오후 9 34 36" src="https://github.com/loosie/aleo_example/assets/54282927/02ab27ab-18aa-4395-87f6-861889736247">


## Record based Defi?
Record와 같은 모델은 각 독립적으로 상호작용하기 때문에 Defi를 만들 때 많은 고민이 필요하다. Cardano 생태계를 예시로 들여다보자. 
- 어떻게 record를 스왑하고 많은 주문을 처리하기 위해서는? [cardano batcher](https://forum.cardano.org/t/cardano-batcher/123312)를 공부해보자
- utxo-like AMM is good?: https://github.com/fallen-icarus/cardano-swaps

현재 Aleo 생테계에는 Private-centrict Dex Arcane Finance가 Uniswap과 같은 AMM 모델을 사용하고 있다.
- 참고: https://testnet3.aleoscan.io/address?a=aleo1mqdnfnjxnpfdkyzewqsup45sw37g3ssyndxg7nt7hgssm7zx3vxslknm3p

## Resources
- Aleo, [Records](https://developer.aleo.org/concepts/records/), Aleo Docs
- Jaromir, [Understanding Cardano Extended-UTXO](https://forum.cardano.org/t/understanding-cardano-extended-utxo/101509), Cardano Forum
JaniceyamGu, [Cardano의 UTxO 모델에서 확장의 의미 이해](https://forum.cardano.org/t/cardano-utxo/124504/1), Cardano forum
