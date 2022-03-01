require('dotenv').config();
require('@nomiclabs/hardhat-etherscan');
require('@nomiclabs/hardhat-waffle');

const config = require('./.config.js');

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    rinkeby: {
      url: process.env.PROVIDER_RINKEBY,
      accounts: config.KEYS,
      timeout: 60000
    },
    moonbase: {
      url: process.env.PROVIDER_MOONBASE,
      chainId: 1287,
      accounts: config.KEYS,
      timeout: 60000
    }
  },
  mocha: {
    timeout: 6000000
  },
  etherscan: {
    apiKey: {
      mainnet: process.env.ETHERSCAN_APIKEY,
      ropsten: process.env.ETHERSCAN_APIKEY,
      rinkeby: process.env.ETHERSCAN_APIKEY,
      goerli: process.env.ETHERSCAN_APIKEY,
      kovan: process.env.ETHERSCAN_APIKEY,
      moonbaseAlpha: process.env.MOONSCAN_APIKEY
    }
  },
  gasReporter: {
    enabled: true,
    fast: true,
    currency: 'USD',
    coinmarketcap: process.env.COINMARKETCAP_APIKEY
  }
};
