# ./local_deposit.sh ${ALEO_ADDRESS}

ALEO_ADDRESS=$1

leo run deposit "{
  owner: "${ALEO_ADDRESS}".private,
  amount: 100u64.private,
  _nonce: 7351748676533310215545800791460305774028420594845948018838463981834851927879group.public
}" 30u64