// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    //"state variable" init to 0. Stored permanently in contract storage
    uint256 totalWaves;

    //function that is invoked whe smart contract is created
    constructor() {
        console.log("I am a contract!");
    }
    //setter method
    //The public keyword marks that this function is accessible from the outside. requires trx => put into blocks $$$
    function wave() public {
        //change state variable
        totalWaves += 1;
        //msg.sender is wallet add of person who called function (built-in auth)
        console.log("%s has waved!", msg.sender);
    }
    //getter method. doesnt need trx, only reads data
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}