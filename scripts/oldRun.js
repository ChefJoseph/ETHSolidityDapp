const main = async () => {
    //in order to deploy, need wallet address: randomPerson created
    const [owner, randomPerson] = await hre.ethers.getSigners();
    //compile contract and generate necessary files under artifacts dir
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    //hardhat will create local eth network just for contract and refresh. Easier to debug from clean slate
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    //once deployed, it will give address of deployed contract
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    //need to manually call our functions like any API
    //grab total waves
    await waveContract.getTotalWaves();
    //wave
    const firstWaveTxn = await waveContract.wave();
    await firstWaveTxn.wait();
    //grab total waves
    await waveContract.getTotalWaves();
    //simulate another user
    const secondWaveTxn = await waveContract.connect(randomPerson).wave();
    await secondWaveTxn.wait();
  
    await waveContract.getTotalWaves();
};

const runMain = async () => {
    try {
        await main();
        process.exit(0); //exit Node process without error
    } catch (error) {
        console.log(error);
        process.exit(1); //exit Node while indicating error message
        //status codes here: https://stackoverflow.com/a/47163396/7974948
    }
};

runMain();
     