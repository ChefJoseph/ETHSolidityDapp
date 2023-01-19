// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    //"state variable" init to 0. Stored permanently in contract storage
    uint256 totalWaves;
    //for random number gen
    uint256 private seed;
    //events
    event NewWave(address indexed from, uint256 timestamp, string message);
    //struct is where you customize the attributes for the datatype.
    struct Wave {
        address waver; 
        string message; 
        uint256 timestamp;
    }
    Wave[] waves;
    //  This is an address => uint mapping, meaning I can associate an address with a number!
    //  In this case, I'll be storing the address with the last time the user waved at us.
    mapping(address => uint256) public lastWavedAt;
    
    //function that is invoked when smart contract is created
    constructor() payable {
        console.log("We have been constructed!");
        seed = (block.timestamp + block.difficulty) % 100;
    }
    //setter method
    //The public keyword marks that this function is accessible from the outside. requires trx => put into blocks $$$
    function wave(string memory _message) public {
        
        require(lastWavedAt[msg.sender] + 2 minutes < block.timestamp, "Must 2 minutes before waving again.");
        
        // Update the current timestamp we have for the user
        lastWavedAt[msg.sender] = block.timestamp;
        //change state variable
        totalWaves += 1;
        //msg.sender is wallet add of person who called function (built-in auth)
        console.log("%s has waved w/ message %s!", msg.sender, _message);
        //store wave data array
        waves.push(Wave(msg.sender, _message, block.timestamp));
        seed = (block.difficulty + block.timestamp + seed) % 100;
    // Give a 50% chance that the user wins the prize.
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
    // The same code we had before to send the prize.
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        //emit logs alongside transaction and can be read by client
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    //returns waves for client view
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
    //getter method. doesnt need trx, only reads data
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}