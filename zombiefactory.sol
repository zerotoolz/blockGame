// SPDX-License-Identifier: MIT
pragma solidity >=0.4.19; //solidity version

import "./ownable.sol"; //import into ownable.sol
contract ZombieFactory is Ownable {//contract name (ownable for ownable.sol), the function takes zombie name and generates ramdon zombie after add it blockchain

    event NewZombie(uint zombieId, string name, uint dna); //event new zombie check

    uint dnaDigits = 16; //zombie skin
    uint dnaModulus = 10 ** dnaDigits; //zombie skin check = exact 16 digits

    struct Zombie {
        string name; //zombie name
        uint dna; // zombie skin
        uint32 level; //zombie level
        uint32 readyTime; //when can eat next
    }

    Zombie[] public zombies; //zombie array structure stogare with public access

    mapping (uint => address) public zombieToOwner; //zombie owner address
    mapping (address => uint) ownerZombieCount; //exact zombie number for this owmner address

    function _createZombie (string memory _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1; // recently new zombie addedid
        zombieToOwner[id] = msg.sender; //new zombie id chains with it's owner address for mapping
        ownerZombieCount[msg.sender]++; //increising (js ++) zombie count for it's owner in mapping
        NewZombie(id, _name, _dna); //new zombie event related 
    } 

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(_str)); //keccakfrom _str
        return rand % dnaModulus; // zombie skin with exact 16 digits
    }
    
        function createRandomZombie(string memory _name) public { //random, zombie creation
        require(ownerZombieCount[msg.sender] == 0); //checks only one zombie for this owner 
        uint randDna = _generateRandomDna(_name); // skin and name creation 
        _createZombie(_name, randDna); // creation
    
    }
}