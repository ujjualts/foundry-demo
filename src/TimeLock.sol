//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "@openzeppelin/utils/math/SafeMath.sol ";

contract Timelock {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public lockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] += block.timestamp + 1 weeks;
    }

    function increasedTimeLock(uint256 _increasedSec) public {
        lockTime[msg.sender] = lockTime[msg.sender].add(_increasedSec);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient fund");
        require(block.timestamp > lockTime[msg.sender], "locktime has expired");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "failed to sensd");
    }
}
