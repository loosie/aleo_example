APPNAME="store_1747229114"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

snarkos developer execute "${APPNAME}.aleo" add_item \
  1u8 \
  10u64 \
  100u64 \
  --private-key "${PRIVATE_KEY}" \
  --query "https://api.explorer.aleo.org/v1" \
  --priority-fee 3000000 \
  --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" \