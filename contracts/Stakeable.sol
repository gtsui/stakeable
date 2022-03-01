//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Stakeable {

  /// @notice Array for storing all Stakes on the contract.
  Stakeholder[] internal stakeholders;

  /// @notice Keep track of index for stakers in stakes array
  /// account -> `stakeholders` index
  mapping(address => uint256) internal stakes;

  /// @notice Emitted whenever user stakes token
  event Staked(address indexed user, uint256 amount, uint256 index, uint256 timestamp);

  /// @notice Representation of stakes
  /// @member user User address
  /// @member amount Amount staked
  /// @member since Timestamp of stake
  struct Stake {
    address user;
    uint256 amount;
    uint256 since;
  }

  struct Stakeholder {
    address user;
    Stake[] address_stakes;
  }
  
  constructor(){
    stakeholders.push(); //push to avoid index 0
  }


  /** INTERNAL FUNCTIONS **/

  /// @notice Adds a new stakeholder to the `stakeholders` array
  /// @param stakeholder Address of stakeholder to add
  /// @return uint256 Index of latest stakeholder
  function _addStakeholder(address stakeholder) internal returns(uint256){

    // Push empty item to `stakeholders` to make space for new stakeholder
    stakeholders.push();

    // Calculate index of last item in the array
    uint256 userIndex = stakeholders.length - 1;

    // Assign address to new index
    stakeholders[userIndex].user = stakeholder;

    // Add index to `stakes` mapping
    stakes[stakeholder] = userIndex;

    return userIndex;
  }

  /// @notice Function for staking the sender's tokens
  /// @param amount Amount to stake
  function _stake(uint256 amount) internal {

    // Stake amount must be positive
    require(amount > 0, "Stakeable: stake amount must be positive");

    uint256 index = stakes[msg.sender];
    uint256 timestamp = block.timestamp;

    if(index == 0){
      // User is a first time staker. Need to add them to the `stakeholders` array
      index = _addStakeholder(msg.sender);
    }

    // Create new stake for the user
    Stake memory s = Stake(msg.sender, amount, timestamp);

    // Add it to the user's stakes
    stakeholders[index].address_stakes.push(s);

    // Emit the staking event
    emit Staked(msg.sender, amount, index, timestamp);
  }
}
