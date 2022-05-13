pragma solidity ^0.4.19;
import "./zombiehelper.sol";
contract ZombieBattle is ZombieHelper {
  uint randNonce = 0; 
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;

  }

  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId]; //attacker zombies
    Zombie storage enemyZombie = zombies[_targetId]; //victime zombies 
    uint rand = randMod (100); //resultof attack via random
        if (rand <= attackVictoryProbability) { // check win or loss, if win then add wincount and level +1, add losscount for enemy and create new zombie from zombiefeeding.sol with f. feedAndMultiply
      myZombie.winCount++;
      myZombie.level++;
      enemyZombie.lossCount++;
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");      
    } else { // if loss add +1 to my zombie losscount and +1 to enemy win count
      myZombie.lossCount++; 
      enemyZombie.winCount++;
    }
    _triggerCooldown(myZombie); //for both scenarious frigget cooldown 
}