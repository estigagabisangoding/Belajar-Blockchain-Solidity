// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TomAndJerryPeace {
    address public tom;
    address public jerry;
    uint256 public cheesePlacedTime;
    bool public cheeseAccepted;

    constructor(address _jerry) {
        tom = msg.sender;
        jerry = _jerry;
    }

    modifier onlyTom() {
        require(msg.sender == tom, "Only Tom can do this.");
        _;
    }

    modifier onlyJerry() {
        require(msg.sender == jerry, "Only Jerry can do this.");
        _;
    }

    function placeCheese() external onlyTom {
        cheesePlacedTime = block.timestamp;
        cheeseAccepted = false;
    }

    function takeCheese() external onlyJerry {
        require(block.timestamp <= cheesePlacedTime + 24 hours, "Time to take cheese has expired.");
        cheeseAccepted = true;
    }

    function checkStatus() external view returns (string memory) {
        if (cheeseAccepted) {
            return "Cheese accepted. Apology received.";
        } else if (block.timestamp > cheesePlacedTime + 24 hours) {
            return "Cheese not accepted. Time expired.";
        } else {
            return "Cheese is on the table.";
        }
    }
}
