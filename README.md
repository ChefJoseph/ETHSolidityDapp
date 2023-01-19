# Solidity dApp
# Intro
This is a dApp while completing Buildspace.io Web3 course. It utilizes Solidity, Goerli Ethereum testnet, React, Hardhat, Chai. User connects wallet (MetaMask). Once connected, user can see how many waves the page (address) has received and also can send waves. Each wave is a transaction that is mined and persists on the blockchain. I've added a visual wave counter, message form, and transaction history.
<br>
Deployed using REPL:
<a>https://waveportal-project.chefjoseph.repl.co</a>
# FAQ
What is dAPPs? dAPPs are decentralized applications that operate autonomously through smart contracts, that run on a decentralized blockchain, computing, or distributed ledger system.
<br>
What is a smart contract? Smart contracts are self-executing lines of code (transactions) with the terms of an agreement between buyer and seller automatically verified and executed via a computer network. These transactions are traceable, transparent, and irreversible.
<br>
Check transactions:
<br>
My Goerli Test Network address: 0x1b5c30e5e994195a86c3b8aaFe32aEa7fd1B1756
<br>
<a>https://goerli.etherscan.io/address/0x1b5c30e5e994195a86c3b8aafe32aea7fd1b1756</a>

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

1. Compile it.
  ```shell
  npx hardhat compile
  ```
2. Deploy it to our local blockchain.
  ```shell
  npx hardhat run scripts/run.js
  npx hardhat run scripts/deploy.js --network localhost
  ```
3. Execute
 ```shell
 Confirm with console.log
 ```
    Check transaction blocks:

    <a>https://goerli.etherscan.io/address/0x1b5c30e5e994195a86c3b8aafe32aea7fd1b1756</a>

hre.ethers
<br>
  hre is short for Hardhat Runtime Environment. It is an object containing all the functionality that Hardhat exposes when running a task, test or script.

# scripts/run.js
Here we create a local ETH network and run the functions on the Solidity contracts WavePortal.js.
<br>
We will simulate storing data, retrieving data, and changing state with multiple test users.
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
  <h3>Call functions from Solidity contracts/WavePortal.js</h3>
  
  ```shell
  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  await waveContract.getTotalWaves();

  const firstWaveTxn = await waveContract.wave();
  await firstWaveTxn.wait();

  await waveContract.getTotalWaves();

  const secondWaveTxn = await waveContract.connect(randomPerson).wave();
  await secondWaveTxn.wait();

  await waveContract.getTotalWaves();
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
  
# scripts/deploy.js

Here we deploy to the real test net using Quicknode and Goerli. Each transaction is broadcasted to the testnet blockchain. The goerli testnet is a clone of the mainnet using fake ETH but are run by actual miners.
<br>
Start local Ethereum network:
```shell
npx hardhat node
```
Deploying to Goerli testnet
```shell
hardhat.config.js
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
    solidity: "0.8.17",
    networks: {
      goerli: {
        url: "YOUR_QUICKNODE_API_URL",
        accounts: ["YOUR_PRIVATE_GOERLI_ACCOUNT_KEY"]
      },
    },
};
```
# React frontend
Deployed using REPL:
<br>
<a>https://waveportal-project.chefjoseph.repl.co</a>
<br>
Click 'Connect Wallet' button to signin with Metamask extension.
<br>
This is possible with:
```shell
const getEthereumObject = () => window.ethereum;
const accounts = await ethereum.request({
    method: "eth_requestAccounts",
});
```
By clicking on the 'Wave at me' button, the wave() function from WavePortal.sol is called on. totalWaves state variable is incremented +=1.
<br>
wave() costs ETH.
<br>
getTotalWaves() is only reading so it is free.
