//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @custom:forkedfrom BuidlGuidl
 * @author Fabriziogianni7
 * @custom:inspired by solidityByExample https://docs.soliditylang.org/en/latest/solidity-by-example.html#safe-remote-purchase
 * a Market for bikes that allow seller and buuyer to have:
 * for seller: a warranteed payment
 * for buyer: that he receives the bike
 */
contract BikeToken is ERC20 {
    constructor() ERC20("BikeToken", "BKT") {}
}
