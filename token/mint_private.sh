APPNAME="token_999126"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

QUERY_URL="https://api.explorer.aleo.org/v1"
BROADCAST_URL="${QUERY_URL}/testnet3/transaction/broadcast"

snarkos developer execute "${APPNAME}.aleo" mint_private\
    aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw \
    100u64 \
  --private-key "${PRIVATE_KEY}" \
  --query "${QUERY_URL}" \
  --priority-fee 3000000 \
  --broadcast "${BROADCAST_URL}" \