# Solidity dAPP
# FAQ
What is a smart contract? Smart contracts are self-executing lines of code (transactions) with the terms of an agreement between buyer and seller automatically verified and executed via a computer network. These transactions are traceable, transparent, and irreversible.

# Hardhat

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
//to start local ethereum network
npx hardhat node 
//test
npx hardhat test
```
# Folder Structure
1. /contracts is where your Solidity files go to.
2. /scripts is where you store hardhat scripts
3. /test is where your contract test files go.

# Imitate blockchain environment to test
```shell
1. Compile it.
    npx hardhat compile
2. Deploy it to our local blockchain.
    npx hardhat run scripts/run.js
    npx hardhat run scripts/deploy.js
3. Execute
    Confirm with console.log
```
hre.ethers
  hre is short for Hardhat Runtime Environment. It is an object containing all the functionality that Hardhat exposes when running a task, test or script.

# scripts/run.js
Here we create a local ETH network and run the functions on the Solidity contracts WavePortal.js.
Here we will simulate storing data, retrieving data, and changing state with multiple test users.
1. Creating a new local Ethereum network.
  ```shell
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  ```
2. Deploying your contract.
  ```shell
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();
  ```
3. Then, when the script ends Hardhat will automatically destroy that local network.
  ```shell
  const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
  };
  ```
