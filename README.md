# RFS Crowdsale

This repository holds the crowdsale contract for the Rowhome Floor Sweepers DAO, based on Open Zeppelin 2.5 smart contracts using a Hardhat sample project.

## Compiling contracts

```shell
npx hardhat compile
```

## Deploying in Ropsten Testnet

```shell
npx hardhat run --network ropsten scripts/deploy.js
```

## Verifying contracts

### Deployer

```shell
npx hardhat verify "<deployer-contract-address>" --network ropsten
```

### RFS Token

```shell
npx hardhat verify "<token-contract-address>" --network ropsten RFS RFS 25000000000000000000000
```

### Crowdsale 

```shell
npx hardhat verify "<crowdsale-contract-address>" --network ropsten 1 <multisig-address> <rfs-token-address> <multisig-address> <rfs-amount>
```
