APPNAME="excaliver234"
ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

WT_METADATA="{
  id: 1u64
  name: [87u8, 111u8, 110u8, 84u8, 111u8, 107u8, 101u8, 110u8, 0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8],
  symbol: [87u8, 84u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8] 
}"

JT_METADATA="{
  id: 2u64
  name: [74u8,111u8,110u8,103u8,84u8,111u8,107u8,101u8,110u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8],
  symbol: [74u8,84u8,0u8,0u8,0u8,0u8,0u8,0u8] 
}"

ALEO_ADDRESS=aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw

snarkos developer execute "${APPNAME}.aleo" "mint" 1u64 "${WT_METADATA}" "${ALEO_ADDRESS}" 100u64 \
  --path "./build/" \
  --private-key "${PRIVATE_KEY}" \
  --query "https://api.explorer.aleo.org/v1" \
  --priority-fee 3000000 \
  --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" \