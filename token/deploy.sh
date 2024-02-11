APPNAME="token_999126"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

QUERY_URL="https://api.explorer.aleo.org/v1"
BROADCAST_URL="${QUERY_URL}/testnet3/transaction/broadcast"

snarkos developer deploy "${APPNAME}.aleo" \
  --path "./build/" \
  --private-key "${PRIVATE_KEY}" \
  --query "${QUERY_URL}" \
  --priority-fee 3000000 \
  --broadcast "${BROADCAST_URL}" \