const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    
    const waveContract = await waveContractFactory.deploy(
      {
        value:hre.ethers.utils.parseEther("0.1"),
      }
    );
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance:",hre.ethers.utils.formatEther(contractBalance));
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());
    let waveTxn = await waveContract.wave("Hey techscribbler!!!");
    await waveTxn.wait();
    
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance: ",hre.ethers.utils.formatEther(contractBalance));

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave("Oh My Dear!! You Won!!");
    await waveTxn.wait();
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance: ",hre.ethers.utils.formatEther(contractBalance));

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);

    waveCount = await waveContract.getTotalWaves();

};
  
const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
};

runMain()