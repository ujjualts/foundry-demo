// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

contract HotelRoom {
    enum Status {
        Vacant,
        Occupied
    }
    Status currentStatus;
    address payable public owner;
    uint8 public x = 1;

    event Occupy(address _occupant, uint256 _value);

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Status.Vacant;
    }

    modifier onlyWhileVacant() {
        require(currentStatus == Status.Vacant, "Currently occupied");
        _;
    }

    modifier costs(uint256 amount) {
        require(msg.value >= amount, "Not enough eth");
        _;
    }

    function recieve() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Status.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}
