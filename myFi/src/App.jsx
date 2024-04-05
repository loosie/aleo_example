import { useState } from "react";
import aleoLogo from "./assets/aleo.svg";
import "./App.css";
import token_program from "../token/build/main.aleo?raw";
import { AleoWorker } from "./workers/AleoWorker.js";
import { parseMintTokenResult, tokenMetatdata } from "./utils.js";
import {
  Account,
} from "@aleohq/sdk";


const aleoWorker = AleoWorker();
function App() {
  const [userKey, setUserKey] = useState(null);
  const [executing, setExecuting] = useState(false);
  const [showRecords, setShowRecords] = useState(false);
  const [selectedToken, setSelectedToken] = useState(null);
  const [records, setRecords] = useState([]);

  const handleTokenChange = (e) => {
    const tokenKey = e.target.value;
    setSelectedToken(tokenKey);
  };

  const generateAccount = async () => {
    const key = await aleoWorker.getPrivateKey();
    console.log('generateAccount:', key);
    setUserKey(await key.to_string());
  };

  async function mintToken() {
    if (!userKey) {
      alert('no account');
      return;
    }

    if (!selectedToken) {
      alert('no token selected');
      return;
    }
    setExecuting(true);

    // TODO: it should be pull onchain mapping token metadata
    const tokenData = tokenMetatdata[selectedToken];
    const userAccount = new Account({
      privateKey: userKey,
    });
    console.log('account:', userAccount);
    console.log(userAccount.address().to_string());

    const convertArrayToString = (arr) => {
      return arr.map(item => `${item}u8`).join(",");
    };

    const jsonString = `{
        id: ${tokenData.id},
        name: [${convertArrayToString(tokenData.name)}],
        symbol: [${convertArrayToString(tokenData.symbol)}] 
    }`;

    console.log(jsonString);
    // const result = await aleoWorker.localProgramExecution(
    //   userKey,
    //   token_program,
    //   "mint",
    //   [tokenData.id, userAccount.address().to_string(), "100u64", jsonString],
    // );

    // const newRecord = parseMintTokenResult(result[0]);

    // mock data
    const newRecord = {
      owner: userAccount.address().to_string() + '.private',
      amount: '100u64.private',
      id: tokenData.id + '.private',
      _nonce: '6678733339473846553397983115761500889346961254374227042523066233470754662400group.public'
    };
    console.log('newRecord:', newRecord);
    records.push(newRecord);
    setRecords(records);

    // alert(result);
    setTimeout(() => {
      setExecuting(false);
    }, 1000)
  }

  const toggleRecordsDisplay = () => {
    if (!userKey) {
      alert('no account');
      return;
    }

    if (records.length === 0) {
      alert('no records');
      setShowRecords(false);
      return;
    }
    setShowRecords(!showRecords);
  };

  async function privateTransfer() {
    if (!userKey) {
      alert('no account');
      return;
    }
    console.log('trying to private Transfer...', userKey);
    // TODO: it should be pull onchain mapping token metadata
    const record = records.pop();
    console.log('unspent Record:', record);
    const receivedAccount = new Account();
    const recordPlainString = `{
      owner: ${record.owner},
      amount: ${record.amount},
      id: ${record.id},
      _nonce: ${record._nonce}
    }`;

    console.log('input: \n', [recordPlainString, receivedAccount.address().to_string(), "50u64"]);

    const result = await aleoWorker.localProgramExecution(
      userKey,
      token_program,
      "transfer_private",
      [recordPlainString, receivedAccount.address().to_string(), "50u64"],
    );

    console.log(result);

    const myRecord = parseMintTokenResult(result[0]);
    const receivedRecord = parseMintTokenResult(result[1]);

    records.push(myRecord);
    console.log('myRecord:', myRecord);
    console.log('receivedRecord:', receivedRecord);
    alert(JSON.stringify(result));
  }

  return (
    <>
      <div>
        <a href="https://aleo.org" target="_blank">
          <img src={aleoLogo} className="logo" alt="Aleo logo" />
        </a>
      </div>
      <h1>MyFi</h1>
      <h3>private Defi Application Example</h3>
      <div className="card">
        <p>
          <button onClick={generateAccount}>
            {userKey
              ? `Account is generated!`
              : `Click to generate account`}
          </button>
        </p>

        <p>
          <div>
            <select onChange={handleTokenChange} value={selectedToken}>
              <option value="">Select a token...</option>
              <option value="won">WonToken</option>
              <option value="jong">JongToken</option>
            </select>
          </div>

          {selectedToken && (
            <div className="token-details">
              <p>Token ID: {selectedToken}</p>
            </div>
          )}

          <div>
            <button onClick={mintToken} disabled={!selectedToken || executing}>
              {executing
                ? `Executing...check console for details...`
                : `Execute token minting`}
            </button>
          </div>
        </p>

        <div>
          <button onClick={toggleRecordsDisplay}>
            {showRecords ? 'Hide User Records' : 'Get User Records'}
          </button>

          {showRecords && (
            <div className="records-container">
              {records.map((record, index) => (
                <div key={index} className="record-card">
                  <p className="text-ellipsis">Owner: {record.owner}</p>
                  <p>Amount: {record.amount}</p>
                  <p>ID: {record.id}</p>
                  <p className="text-ellipsis">Nonce: {record._nonce}</p>
                </div>
              ))}
            </div>
          )}
        </div>

        <p>
          <button onClick={privateTransfer}>
            private Transfer
          </button>
        </p>

      </div >
    </>
  );
}

export default App;
