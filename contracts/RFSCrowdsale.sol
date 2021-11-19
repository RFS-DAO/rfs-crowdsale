pragma solidity ^0.5.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";

contract RFS is Context, ERC20, ERC20Detailed {
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

contract RFSCrowdsale is Crowdsale, CappedCrowdsale {
    constructor(
        uint256 rate,
        address payable wallet,
        IERC20 token,
	address rfsMultiSignatureWallet,
	uint256 cap
    )
    CappedCrowdsale(cap)
    Crowdsale(rate, wallet, token)
    public
    {

    }
}

contract RFSCrowdsaleDeployer {
    constructor()
    public
    {
        ERC20 rfsToken = new RFS("RFS", "RFS", 25000000000000000000000);
        address payable multisig = address(0x99E21A5982F3EB95883745a0B9A79873484Ed497);

        RFSCrowdsale crowdsale = new RFSCrowdsale(
            1,               // rate RFS per ETH
            multisig,      // send Ether to the deployer
            rfsToken,           // the token
	    multisig,
	    1000000000000000000000
        );

	// Transfer RFS to the crowdsale
        rfsToken.transfer(address(crowdsale), 100000000000000000000);

	// Transfer the remains to multisignature
        rfsToken.transfer(multisig, 2400000000000000000000);
    }
}
