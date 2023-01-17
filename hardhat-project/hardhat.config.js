require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const MUMBAI_URL = process.env.MUMBAI_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    mumbai: {
      url: MUMBAI_URL,
      accounts: [PRIVATE_KEY],
    },
  },
};