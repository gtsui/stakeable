//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Stakeable.sol";

contract Token is ERC20, Stakeable {


  constructor(
              string memory name_,
              string memory symbol_
              ) ERC20(name_, symbol_) {
    _mint(msg.sender, 1000e18);
  }
  
  function stake(uint256 amount) public {

    // Staking amount must be valid
    require(amount <= balanceOf(msg.sender), "Token: Not enough balance");
    
    _stake(amount);

    _burn(msg.sender, amount);
  }
  
}
