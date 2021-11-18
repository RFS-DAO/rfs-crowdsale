pragma solidity ^0.5.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/WhitelistCrowdsale.sol";

contract Rowhome is Context, ERC20, ERC20Detailed {
     /**
     * @dev Constructor that gives _msgSender() all of existing tokens.
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) public ERC20Detailed(name, symbol, 18) {
        _mint(_msgSender(), initialSupply);
    }
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

contract RowhomesCrowdsaleDeployer {
    constructor()
    public
    {
        // create a mintable token
        ERC20 rowhomeToken = new Rowhome("ROWHOME", "ROWHOME", 25000000000000000000000);

        // create the crowdsale and tell it about the token
        Crowdsale crowdsale = new RowhomesCrowdsale(
            1,               // rate ROWHOME per ETH
            msg.sender,      // send Ether to the deployer
            rowhomeToken,           // the token
            address(0x99E21A5982F3EB95883745a0B9A79873484Ed497),
	    25000000000000000000000
        );
        // transfer the minter role from this contract (the default)
        // to the crowdsale, so it can mint tokens
        // token.addMinter(address(crowdsale));
	// token.renounceMinter();
    }
}
