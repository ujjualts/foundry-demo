// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;
import "ds-test/test.sol";

import "../HotelRoom.sol";

contract ContractTest is DSTest {
    HotelRoom hRoom;

    function setUp() public {
        hRoom = new HotelRoom();
    }

    function testExample() public {}
}
