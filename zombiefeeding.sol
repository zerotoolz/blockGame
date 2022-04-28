pragma solidity ^0.4.19;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public { //new function 
    require(msg.sender == zombieToOwner[_zombieId]); //ensure zombie owner the same person who sent the zombie 
    Zombie storage myZombie = zombies[_zombieId]; // received zombie from zombies storage
  } 

}
