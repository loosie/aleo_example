APPNAME="private_aleo_won"
ENV_FILE=".env"
PRIVATEKEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)


snarkos developer deploy "${APPNAME}.aleo" \
  --private-key "${PRIVATEKEY}" \
  --query "https://api.explorer.aleo.org/v1" \
  --path "./build/" \
  --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" \
  --priority-fee 1000000 


