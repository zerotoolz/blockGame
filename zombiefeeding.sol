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

  function setKittyContractAddress(address _address) external onlyOwner { //only owner can change kitty contract address with ownable.sol legacy from zombiefactory.sol
    kittyContract = KittyInterface(_address);
} 
  
  function _triggerCooldown(Zombie storage _zombie) internal { 
    _zombie.readyTime = uint32(now + cooldownTime);
  }
  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal { //only internal function 
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie)); // function rquirment = can do this when cooldown time is ok
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(_species) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public { //new function receives kitty genes
    uint kittyDna; //uint for kittyDna
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //genes is #10 so we need it only from KittyIntrface with getKitty
    feedAndMultiply(_zombieId, kittyDna); //asks feed and multiplication for zombieId and KittyDna in way to comstruct new zombie from 2 related DNAs
}