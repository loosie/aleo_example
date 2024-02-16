# 프라이빗 스토어
- https://explorer.hamp.app/transaction?id=at15xc9c7z22gzavyaupegyc59y5qwy4u7j4l45j95j4ws5ccqu9vrsewp7cm

transition 의 결과로 생성된 Record는 주인의 ViewKey로만 복호화할 수 있도록 암호화된 채 네트워크에 저장된다. 기존의 Record를 사용해 함수 호출을 하는 것이 가능하며, 기존 Record를 토대로 새로운 Record를 생성할 수 있다. finalize 의 인자로 사용한 값은 평문으로 공개된다.

## Mint
mint 함수 인자(parameter)
- 주소값: mint 된 토큰을 받을 주소 (`receiver`)
- 수량: mint 될 토큰의 수량
```
leo run mint aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw 10000u64
```

#### output
```
➡️  Output

 • {
  owner: aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw.private,
  amount: 10000u64.private,
  _nonce: 5212622781859889803950216885919156510950481382129275644186267206217862975778group.public
}
```
#### 트랜잭션 
https://explorer.hamp.app/transition?id=au1kef65tqjjt2cxcstx0uw4hrap4d5cx93x0g8rav7j6dezmypr5pq6ra0qv
- `receiver`로 지정된 사람만 확인할 수 있는 Record가 네트워크 상에 저장된다.
- `receiver`의 ViewKey가 없으면 누구도 확인할 수 없는 private 정보이다.
- Private Data (초록색 글씨)
   - Input 값의 private address(receiver 주소), private u64(토큰 수량)
   - Output 값의 Record Data

따라서, 새로운 Token을 받는 대상(receiver)에 대한 정보가 안전하게 보호된 mint 함수를 실행할 수 있다.

<img src="https://i.imgur.com/MQGqQNx.png">


## Add Item
add_item 함수 인자(parameter)
- 아이템 넘버: 추가하고자 하는 아이템의 번호(id 처럼 사용함)
- 수량: 추가할 아이템의 수량
- 가격: 추가한 아이템의 가격
```
leo run add_item 1u8 10u64 100u64
```

### output
```
➡️  Outputs

 • {
  program_id: store_1747229114.aleo,
  function_name: add_item,
  arguments: [
    1u8,
    10u64,
    100u64
  ]
}
```

### 트랜잭션 
https://explorer.hamp.app/transaction?id=at1j448cc55el80khdpj9ml667nvl5cfly0gd6wvlm5e2ef9grg55rq96t37j


## Buy Item
buy 함수 인자(parameter)
- 프라이빗 토큰: mint 를 통해 확보한 토큰, 프라이빗 스토어이기 때문에 본인만 확인할 수 있는 토큰으로 값을 지불
- 아이템 넘버: 구매하고자 하는 아이템의 번호(id처럼 사용)
- 수량: 구매하고자 하는 아이템의 수량
- 지불가격: 아이템을 구매하며 지불하려는 금액을 미리 계산하여 함께 입력
```
leo run buy '{                                                                    
  owner: aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw.private,
  amount: 10000u64.private,
  _nonce: 55028146645976692020358098906249415128562926350820493791856558229050125108group.public
}' 1u8 5u64 50u64
```

### output
```
➡️  Outputs

 • {
  owner: aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw.private,
  amount: 9950u64.private,
  _nonce: 6888305205403568900161443206246796492075101275282030369742466523501644189427group.public
}
 • {
  owner: aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw.private,
  item: 1u8.private,
  quantity: 5u64.private,
  _nonce: 3394087164967848598543359215287334327986445549340126311090480953295770491355group.public
}
 • {
  program_id: store_1747229114.aleo,
  function_name: buy,
  arguments: [
    1u8,
    5u64,
    50u64
  ]
}
```

### 트랜잭션 

- buy 의 인자로, mint를 통해 획득한 token을 사용한다.
- 오직 ViewKey로 token을 소유한 사람만이 buy를 실행할 수 있다.
- buy 함수의 실행 결과(output)
   - 잔돈 개념으로 거슬러 받은 Token Record
   - 구매한 Item Record

ViewKey를 가진 주인만 트랜잭션 결과 정보를 올바르게 복호화하여 사용할 수 있다. 즉, `Token`과 `Item`의 주인 외에는 프라이빗 스토어 프로그램 상에서의 활동에 대한 아무런 정보도 확인할 수 없다.



## Transfer Item
transfer_item 함수 인자(parameter)
- 아이템: 추가하고자 하는 아이템 정보
   - 아이템 owner pub 주소
   - 아이템 id 
   - 전송하고자하는 아이템 수량 
- 주소값: 아이템을 받을 주소

```
leo run transfer_item '{
    owner: aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw.private,
    item: 123u8.private,
    quantity: 123u64.private,
    _nonce: 6454746015393505811671401129091330549036205015618570235834391641324347085342group.public
}' aleo180hp9fhgm0v993vxmqw6te0l7293zed692t5cqtetxyv02dluc9qjke8ca
```

### output 
```
➡️  Output

 • {
  owner: aleo180hp9fhgm0v993vxmqw6te0l7293zed692t5cqtetxyv02dluc9qjke8ca.private,
  item: 123u8.private,
  quantity: 123u64.private,
  _nonce: 6045431943873544748805606110612503687745477068462844894104811623212349395272group.public
}
```

### 트랜잭션 