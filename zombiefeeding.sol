pragma solidity ^0.4.19;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus; // ensure zombie skin with exact 16 digits
    uint newDna = (myZombie.dna + _targetDna) / 2; // everage meening between myZombie and _targetDna
    _createZombie("NoName", newDna); // new zombie creation 
  }

}
