//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
// import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @custom:forkedfrom BuidlGuidl
 * @author Fabriziogianni7
 * @custom:inspired by solidityByExample https://docs.soliditylang.org/en/latest/solidity-by-example.html#safe-remote-purchase
 * a Market for bikes that allow seller and buuyer to have:
 * for seller: a warranteed payment
 * for buyer: that he receives the bike
 */
contract BikeMarket {
    // State Variables

    // Events: a way to emit log statements from smart contract that can be listened to by external parties

    // Constructor
    constructor(string memory name) {}

    // Modifier: used to define a set of rules that must be met before or after a function is executed

    //Functions
    // external
    function greeting() external pure returns (string memory greet) {
        greet = "Aho";
    }
    // public
    // internal/private (what is the difference?)
    // getters

    /**
     * Function that allows the contract to receive ETH
     */
    receive() external payable {}
}
