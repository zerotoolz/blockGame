// SPDX-License-Identifier: MIT
pragma solidity >=0.4.19; //solidity version

contract ZombieFactory { //contract name

    uint dnaDigits = 16; //zombie skin
    uint dnaModulus = 10 ** dnaDigits; //zombie skin check = exact 16 digits

    struct Zombie {
        string name; //zombie name
        uint dna; // zombie skin
    }

    Zombie[] public zombies; //zombie array structure stogare with public access

    function _createZombie (string _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str)); //keccakfrom _str
        return rand % dnaModulus; // zombie skin with exact 16 digits
    }
    
        function createRandomZombie(string _name) public { //rando, zombie creation
        uint randDna = _generateRandomDna(_name); // skin and name creation 
        _createZombie(_name, randDna); // creation
    }
}
