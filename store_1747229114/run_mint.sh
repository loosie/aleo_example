APPNAME="store_1747229114"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

snarkos developer execute "${APPNAME}.aleo" mint \
  aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw \
  10000u64 \
  --private-key "${PRIVATE_KEY}" \
  --query "https://api.explorer.aleo.org/v1" \
  --priority-fee 3000000 \
  --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" \