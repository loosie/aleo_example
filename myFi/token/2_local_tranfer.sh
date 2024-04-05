FROM_ALEO_ADDRESS=aleo1uwr68zj0ml6dw6nqrnpt9zad3wfvrdzdtmjrqesj4qf67heztcyqg75vrw
TO_ALEO_ADDRESS=aleo1hlungck8zq205kkulmvke7pvmnf8arlnqzqlw9rem65ady4pzu8s0whs6n

leo run transfer_private "{
  owner: ${FROM_ALEO_ADDRESS}.private,
  amount: 100u64.private,
  id: 2u64.private,
  _nonce: 1914556620666455402908639844519250664316487953567314981200627445680212139703group.public
}" "${TO_ALEO_ADDRESS}" 50u64
