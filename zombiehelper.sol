pragma solidity ^0.4.19;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
  modifier aboveLevel(uint _level, uint _zombieId) { //modifier checks zombie level
  require(zombies[_zombieId].level >= _level); //level must be more than
  _;
}

}