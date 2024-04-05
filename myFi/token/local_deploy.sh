APPNAME="wontoken"
ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

snarkos developer deploy "${APPNAME}.aleo" \
  --path "./build/" \
  --private-key "${PRIVATE_KEY}" \
  --query "https://localhost:3030" \
  --priority-fee 3000000 \
  --broadcast "https://localhost:3030/testnet3/transaction/broadcast" \