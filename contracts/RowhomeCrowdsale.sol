pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale";
import "@openzeppelin/contracts/crowdsale/validation/WhitelistedCrowdsale.sol";

contract Rowhome is ERC20 {
    // ... see "Tokens" for more info
}

contract RowhomeCrowdsale is Crowdsale, MintedCrowdsale, AllowanceCrowdsale, CappedCrowdsale, WhitelistedCrowdsale  {
    constructor(
        uint256 rate,
        address payable wallet,
        IERC20 token,
	address rfsMultiSignatureWallet,
	uint256 cap
    )
    CappedCrowdsale(cap)
    MintedCrowdsale()
    AllowanceCrowdsale(rfsMultiSignatureWallet)
    Crowdsale(rate, wallet, token)
    public
    {

    }
}

contract RowhomeCrowdsaleDeployer {
    constructor()
    public
    {
        // create a mintable token
        ERC20Mintable token = new Rowhome();

        // create the crowdsale and tell it about the token
        Crowdsale crowdsale = new RowhomeCrowdsale(
            1,               // rate, still in TKNbits
            msg.sender,      // send Ether to the deployer
            token            // the token
        );
        // transfer the minter role from this contract (the default)
        // to the crowdsale, so it can mint tokens
        token.addMinter(address(crowdsale));
	token.renounceMinter();
    }
}
