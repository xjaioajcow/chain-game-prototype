// scripts/deploy.js

// 说明：
// 1. 确保已安装依赖：npm install ethers dotenv
// 2. 将 .env.example 重命名为 .env 并填写 PRIVATE_KEY 和 RPC_URL
// 3. 运行：node scripts/deploy.js

const fs = require('fs');
const path = require('path');
const { ethers } = require('ethers');
require('dotenv').config();

async function main() {
  const privateKey = process.env.PRIVATE_KEY;
  const rpcUrl = process.env.RPC_URL;

  if (!privateKey || !rpcUrl) {
    console.error('Error: Please set PRIVATE_KEY and RPC_URL in .env');
    process.exit(1);
  }

  // 创建 Provider 和 Wallet
  const provider = new ethers.providers.JsonRpcProvider(rpcUrl);
  const wallet = new ethers.Wallet(privateKey, provider);

  console.log('Deploying contracts with address:', wallet.address);

  // Helper: 编译合约
  async function compileContract(fileName) {
    const source = fs.readFileSync(path.join(__dirname, `../contracts/${fileName}.sol`), 'utf8');
    const solc = require('solc');
    const input = {
      language: 'Solidity',
      sources: {
        [`${fileName}.sol`]: {
          content: source,
        },
      },
      settings: {
        outputSelection: {
          '*': {
            '*': ['abi', 'evm.bytecode.object'],
          },
        },
      },
    };
    const output = JSON.parse(solc.compile(JSON.stringify(input)));
    const contract = output.contracts[`${fileName}.sol`][fileName];
    return {
      abi: contract.abi,
      bytecode: contract.evm.bytecode.object,
    };
  }

  // 1. 部署 GameToken
  console.log('Compiling GameToken.sol...');
  const gameTokenCompiled = await compileContract('GameToken');
  const GameTokenFactory = new ethers.ContractFactory(
    gameTokenCompiled.abi,
    gameTokenCompiled.bytecode,
    wallet
  );
  console.log('Deploying GameToken...');
  const gameToken = await GameTokenFactory.deploy();
  await gameToken.deployed();
  console.log('GameToken deployed to:', gameToken.address);

  // 2. 部署 GameItem
  console.log('Compiling GameItem.sol...');
  const gameItemCompiled = await compileContract('GameItem');
  const GameItemFactory = new ethers.ContractFactory(
    gameItemCompiled.abi,
    gameItemCompiled.bytecode,
    wallet
  );
  console.log('Deploying GameItem...');
  const gameItem = await GameItemFactory.deploy('GameItem', 'GI');
  await gameItem.deployed();
  console.log('GameItem deployed to:', gameItem.address);

  // 3. 部署 GameCore
  console.log('Compiling GameCore.sol...');
  const gameCoreCompiled = await compileContract('GameCore');
  const GameCoreFactory = new ethers.ContractFactory(
    gameCoreCompiled.abi,
    gameCoreCompiled.bytecode,
    wallet
  );
  console.log('Deploying GameCore...');
  const gameCore = await GameCoreFactory.deploy(gameToken.address, gameItem.address);
  await gameCore.deployed();
  console.log('GameCore deployed to:', gameCore.address);

  console.log('All contracts deployed successfully!');
}

main().catch((error) => {
  console.error('Deployment error:', error);
  process.exit(1);
});
