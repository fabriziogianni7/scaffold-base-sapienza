//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

import {IERC20} from "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)

/**
 * @custom:forkedfrom BuidlGuidl
 * @author Fabriziogianni7
 * @custom:inspired by solidityByExample https://docs.soliditylang.org/en/latest/solidity-by-example.html#safe-remote-purchase
 * a Market for bikes that allow seller and buuyer to have:
 * for seller: a warranteed payment
 * for buyer: that he receives the bike
 */
contract BikeMarket {
    // Errors
    error BikeMarket__MsgSenderNotTheBuyer(address sender);
    // State Variables

    struct Bike {
        address seller;
        uint256 price;
        string model;
        string imageUrl;
        bool ordered;
    }

    struct Order {
        address buyer;
        address seller;
        uint256 price;
        uint256 bikeId;
        bool completed;
    }

    uint256 public s_bikeCounter;
    uint256 public s_orderCounter;
    address public s_acceptedToken;
    uint256 public constant DEPOSIT = 1e18;

    mapping(uint256 => Bike) public s_bikes;
    mapping(uint256 => Order) public s_orders;

    // Events: a way to emit log statements from smart contract that can be listened to by external parties
    event BikeAdded(address indexed owner);
    event OrderPlaced(address indexed buyer);

    // Constructor
    constructor(address _acceptedToken) {
        s_acceptedToken = _acceptedToken;
    }

    // Modifier: used to define a set of rules that must be met before or after a function is executed

    //Functions
    // external
    // storage
    // memory
    // calldata
    //
    function addBike(Bike memory bike) external {
        // adding bike to our mapping
        s_bikes[s_bikeCounter] = bike;
        s_bikeCounter += 1;

        // emit an event
        emit BikeAdded(msg.sender);

        // seller to deposit some money as a warrantee
        IERC20(s_acceptedToken).transferFrom(msg.sender, address(this), DEPOSIT);
    }

    // Cecks Effects Interactions
    function placeOrder(uint256 bikeId) external {
        Bike memory bike = s_bikes[bikeId];

        // create new order
        Order memory order =
            Order({buyer: msg.sender, seller: bike.seller, price: bike.price, bikeId: bikeId, completed: false});

        // insert order in mapping
        s_orders[s_orderCounter] = order;
        s_orderCounter += 1;

        // make the ordered field true
        s_bikes[bikeId].ordered = true;

        // emit an event
        emit OrderPlaced(msg.sender);

        // put some money in the contract + deposit
        IERC20(s_acceptedToken).transferFrom(msg.sender, address(this), DEPOSIT + bike.price);
    }

    function confirmOrder(uint256 orderId) external {
        // Checks
        Order memory order = s_orders[orderId];

        if (order.buyer != msg.sender) {
            revert BikeMarket__MsgSenderNotTheBuyer(msg.sender);
        }
        // Effects
        s_orders[orderId].completed = true;

        // todo add event

        // Interactions
        // pay the price + deposit to seller
        IERC20(s_acceptedToken).transfer(order.seller, s_orders[orderId].price + DEPOSIT);

        // give back the deposit to the buyer
        IERC20(s_acceptedToken).transfer(order.buyer, DEPOSIT);
    }
}
