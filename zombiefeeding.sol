pragma solidity ^0.4.19;

import "./zombiefactory.sol";

contract KittyInterface { // interface for zombie feeding from kitty related contract and it's function
  function getKitty(uint256 _id) external view returns ( //receiving kitty's data below
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner { //only owner can change kitty contract address
    kittyContract = KittyInterface(_address);
} 

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public { //new function receives kitty genes
    uint kittyDna; //uint for kittyDna
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //genes is #10 so we need it only from KittyIntrface with getKitty
    feedAndMultiply(_zombieId, kittyDna); //asks feed and multiplication for zombieId and KittyDna in way to comstruct new zombie from 2 related DNAs
}