# Won 토큰 발행
# WonToken [87,111,110,84,111,107,101,110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
# WT [ 87,84,0,0,0,0,0,0 ]

# Jong 토큰 발행 
# JongToken [74,111,110,103,84,111,107,101,110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
# JT [74,84,0,0,0,0,0,0]

# ALEO_ADDRESS=$1
ALEO_ADDRESS=aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw

WON_TOKEN_ID=1u64
leo run mint ${WON_TOKEN_ID} ${ALEO_ADDRESS} 100u64 "{
    id: ${WON_TOKEN_ID},
    name: [87u8, 111u8, 110u8, 84u8, 111u8, 107u8, 101u8, 110u8, 0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8],
    symbol: [87u8, 84u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8] 
}"

JONG_TOKEN_ID=2u64
leo run mint ${JONG_TOKEN_ID} ${ALEO_ADDRESS} 100u64 "{
    id: ${JONG_TOKEN_ID},
    name: [74u8,111u8,110u8,103u8,84u8,111u8,107u8,101u8,110u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8],
    symbol: [74u8,84u8,0u8,0u8,0u8,0u8,0u8,0u8] 
}"
