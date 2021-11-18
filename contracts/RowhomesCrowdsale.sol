pragma solidity ^0.5.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/WhitelistCrowdsale.sol";

contract Rowhome is ERC20 {
    // ... see "Tokens" for more info
}

contract RowhomesCrowdsale is Crowdsale, MintedCrowdsale, AllowanceCrowdsale, CappedCrowdsale, WhitelistCrowdsale  {
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
        ERC20 token = new Rowhome();

        // create the crowdsale and tell it about the token
        Crowdsale crowdsale = new RowhomesCrowdsale(
            1,               // rate, still in TKNbits
            msg.sender,      // send Ether to the deployer
            token,           // the token
            address(0x99E21A5982F3EB95883745a0B9A79873484Ed497),
	    25000000000000000000000
        );
        // transfer the minter role from this contract (the default)
        // to the crowdsale, so it can mint tokens
        // token.addMinter(address(crowdsale));
	// token.renounceMinter();
    }
}
