require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  solidity: {
    compilers: [
      {
        version: "0.8.19",
      },
    ],
    settings: {
      metadata: {
        // Not including the metadata hash
        // https://github.com/paulrberg/hardhat-template/issues/31
        bytecodeHash: "none",
      },
      // Disable the optimizer when debugging
      // https://hardhat.org/hardhat-network/#solidity-optimizer-support
      optimizer: {
        enabled: true,
        runs: 800,
      },
    },
  },
  networks: {
    hardhat: {
      chainId: 1337,
      initialBaseFeePerGas: 0,
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
      chainId: 1337,
      timeout: 6000000,
    },
    polygonMumbai: {
      url: `${process.env.MUMBAI_PROVIDER_URL}`,
      accounts: [
        process.env.DEPLOYER_PRIVATE_KEY,
      ],
      chainId: 80001,
    },
    polygon: {
      url: `${process.env.POLYGON_PROVIDER_URL}`,
      accounts: [
        process.env.DEPLOYER_PRIVATE_KEY,
      ],
      chainId: 137,
    },
  }
};


