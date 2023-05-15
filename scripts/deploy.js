// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

const Minters = [
  "0xafa9f9f984e47d883db2d017d7ad589007c6a3e8"
]

async function main() {
  const baseURI = "QmbH7yPsnoCJdm6oxyU86KANJ4HTjHFMmAQE7PfcEVmiPR";

  const PuzzleNFT = await hre.ethers.getContractFactory("PuzzleNFT");
  const puzzleNFT = await PuzzleNFT.deploy(baseURI);
  console.log('address of singer: ', (await hre.ethers.getSigner()).address);

  await puzzleNFT.deployed();

  console.log(
    `PuzzleNFT deployed to ${puzzleNFT.address} with baseURI ${baseURI}`
  );
  
  Minters.forEach(async (minterAddress, i) => {
    const setMinterResponse = await puzzleNFT.addMinter(minterAddress);
    console.log(`setMinterResponse ${i}: ${JSON.stringify(setMinterResponse)}`);
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
