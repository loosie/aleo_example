# Private Transfer Example 

## What is Record?

### 1. Bitcoin UTXO
Bitcoin, which uses the UTXO model, was designed for payments.

so What is UTXO? It's fullname is Unspent Transaction Outputs.
- In the UTXO model, whenever a transaction occurs, unused outputs are converted into new inputs and validates the transaction. 
- each UTXO can only be used once, the problem of double spending (spending the same coin twice) is effectively avoided.
- so Transactions are both computational results and proofs. It's clear where it came from and where it goes.

However, the Bitcoin UTXO model has very weak programmability. It's almost impossible to create complex program. and As the size of the UTXOs continues to grow, the transaction verification time and storage space in the off-chain required more bigger.

### 2. Ethereum Account
That's why Ethereum came up with the Account-based model, which allows you to write programs with complex logic called smart contracts.
- In the account-based model, there are two types of accounts: Externally Owned Accounts (EOA) and Contract Accounts.
- Each account has an Ethereum balance, and transactions are made by directly transferring ether from one account to another.

An Ethereum transaction is an event that changes the global state. The EVM calculates the outcome of the event's state transition based on the previous blockchain state.
- So in Ethereum's account-based model, the state of all accounts is stored in one global state. This can complicate concurrency with other transactions. This makes the order of transactions important, and Ethereum strictly manages the order of transactions to handle this.
- However, developers cannot determine the order in which transactions and contracts are processed, which is in the hands of block producers and users, so they need to watch out for various attack attempts such as MEV and Sandwich, sniper

### 3. Cardano E-UTXO
Cardano follows in the footsteps of Bitcoin's UTXOs. It's a smart contract platform that allows developers to do a lot of different things, so an expanded concept was needed.

It offers several advantages over the Account-based model.
- These include Bitcoin's settlement power, local validation that ensures transactions are approved after submission, and the inherently fragmented state of the blockchain.
- This allows for parallelization in transaction processing, which has a positive impact on on-chain scalability. 

### 4. Aleo Record
Aleo is a privacy-focused blockchain that has devised a programming language called Leo and uses a UTXO-like record model.
- Record has all the settlement power of Bitcoin and the programmability of Cardano, while adding the concept of privacy. 
- Each Record is authorized through a keyPair called apk, and only the owner can access it. Records can also add (key, value) attributes, which can be privately or publicly accessible, so that even when an on-chain transaction is executed, the privatized attributes are not visible to anyone but the parties.


## How to get User Records?
Each user's record is recorded in a block. To get it, you need to make an on-chain query by setting the criteria for the entire block or a specific block.  This is implemented in the [aleo-sdk](https://github.com/AleoHQ/sdk/blob/testnet3/sdk/src/network-client.ts#L102). Currently, only aleo credits can be queried, and it is expected that the record query method will be released in the future depending on the standard and usability of the token. 

<img width="778" alt="스크린샷 2024-04-05 오후 9 24 08" src="https://github.com/loosie/aleo_example/assets/54282927/1cf96ccd-d8be-4694-b8e4-441b62c92f18">

## Privte Transfer Example
In this repository, I have created an example sample that allows you to issue record tokens directly and transfer them privately using local token program code. 

### How to get started
1. build token program
```
cd token
leo build 
```

2. try local mint & transfer script 
```
./1_local_mint.sh
./2_local_transfer.sh
```

3. back to root & npm install 
```
cd ..
npm i
```

4. frontend start
```
npm run dev 
```

5. generate Account
```
- accountId
- privateKey
- viewKey
```

6. select Token & mint 
Select the desired token and mint a total of 100 tokens directly. 

7. Check your records
Currently, the token program run result is parsed and stored in the local state. In the future, we need to change it to query on-chain. You can see it directly through the UI. Let's see owner and nonce. 
- owner: The owner of the record. If another user tries to use the record, an error 'aleo must belong to the signer' will be thrown. 
- nonce: Used to generate a unique identifier for the record, which is calculated by requesting the owner's address secret key and evaluating the PRF against the record's serial number.

8. private transfer 
Use the record to send 50 of your own tokens to another user. The record containing the 100 used tokens is then used and deleted, and two new records are created: your record with 50 remaining tokens and the other user's record with 50 new tokens. 

<img width="1164" alt="스크린샷 2024-04-05 오후 10 36 51" src="https://github.com/loosie/aleo_example/assets/54282927/2bc8aa26-79fd-4f2c-b21c-6cc76b7d211f">


## Record-based Defi?
Models like Record require a lot of thought when building Defi because they interact independently. Let's look at the Cardano ecosystem as an example. 
- How do you swap records and fulfill many orders? let's study [cardano batcher](https://forum.cardano.org/t/cardano-batcher/123312)
- utxo-like AMM is good?: https://github.com/fallen-icarus/cardano-swaps

Currently, the Aleo ecosystem has a private-centric Dex, Arcane Finance, that uses an AMM model like Uniswap.
- ref: https://testnet3.aleoscan.io/address?a=aleo1mqdnfnjxnpfdkyzewqsup45sw37g3ssyndxg7nt7hgssm7zx3vxslknm3p

## Resources
- Aleo, [Records](https://developer.aleo.org/concepts/records/), Aleo Docs
- Jaromir, [Understanding Cardano Extended-UTXO](https://forum.cardano.org/t/understanding-cardano-extended-utxo/101509), Cardano Forum
- JaniceyamGu, [Cardano의 UTxO 모델에서 확장의 의미 이해](https://forum.cardano.org/t/cardano-utxo/124504/1), Cardano forum
