import {
  Account,
  ProgramManager,
  PrivateKey,
  initThreadPool,
  AleoNetworkClient,
  NetworkRecordProvider,
} from "@aleohq/sdk";
import { expose, proxy } from "comlink";

await initThreadPool();

async function localProgramExecution(key, program, aleoFunction, inputs) {
  const programManager = new ProgramManager();

  const account = new Account({
    privateKey: key,
  });
  programManager.setAccount(account);

  const executionResponse = await programManager.run(
    program,
    aleoFunction,
    inputs,
    false,
  );

  // array any 
  return executionResponse.getOutputs();
}

// !recordProvider.findRecords is NOT IMPLEMENTED
async function getUserRecords(key) {
  const account = new Account({
    privateKey: key,
  });
  const networkClient = new AleoNetworkClient("http://localhost:3030");
  networkClient.setAccount(account);

  const recordProvider = new NetworkRecordProvider(account, networkClient);
  return await recordProvider.findRecords(true);
}


async function getPrivateKey() {
  const key = new PrivateKey();
  return proxy(key);
}


async function getAccount(key) {
  const account = new Account({
    privateKey: key,
  });

  console.log('account:', account);
  const address = account.address().to_string();
  console.log('passed address', address);

  return account;
}

const workerMethods = { localProgramExecution, getPrivateKey, getAccount, getUserRecords };
expose(workerMethods);
