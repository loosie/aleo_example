APPNAME="store_1747229114"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)


snarkos developer execute "${APPNAME}.aleo" buy \
'{
  owner: aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw.private,
  amount: 10000u64.private,
  _nonce: 6454746015393505811671401129091330549036205015618570235834391641324347085342group.public
}' \
  1u8 \
  5u64 \
  500u64 \
  --private-key "${PRIVATE_KEY}" \
  --query "https://api.explorer.aleo.org/v1" \
  --priority-fee 3000000 \
  --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" \