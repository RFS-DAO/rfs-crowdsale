# RFS Crowdsale

This repository holds the crowdsale contract for the Rowhome Floor Sweepers DAO, based on Open Zeppelin 2.5 smart contracts using a Hardhat sample project.

This contract sale follows *The Forwarding Method* as outlined here: https://blog.openzeppelin.com/handling-crowdsale-funds-securely-c348467da74c/

## Compiling contracts

```shell
npx hardhat compile
```

## Deploying in Ropsten Testnet

```shell
npx hardhat run --network ropsten scripts/deploy.js
```

## Mainnet release

RFS Token: https://etherscan.io/token/0x83fe29f50ccc32410aaac979ca386cd3b11fcf9d

Deployer: https://etherscan.io/address/0xa51454e04fb3e979aba8a4e34437e8523919499f

Crowdsale: https://etherscan.io/address/0xc922b15b76e6a660bc5e9fbc6e171c702d0f708f

Issues found: By default OZ crowdsale contracts can't forward funds to Gnosis Safe multisig contracts because this contracts have fallback code running on ETH receival, so the standard transfer gas limit can't be applied. For more information on the fix: https://ethereum.stackexchange.com/questions/103750/openzeppelin-contracts-why-cant-i-use-a-gnosis-safe-as-the-crowdsale-wallet

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
