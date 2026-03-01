// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MockYieldVault is ERC20 {
    IERC20 public underlyingToken;

    event Deposited(address indexed user, uint256 amount);

    constructor(address _underlyingToken) ERC20("Mock Aave USDT", "aUSDT") {
        require(_underlyingToken != address(0), "address is 0");
        underlyingToken = IERC20(_underlyingToken);
    }

    function deposit(uint256 amount) external {
        require(underlyingToken.transferFrom(msg.sender, address(this), amount), "Need to transfer first");

        _mint(msg.sender, amount * 10 * decimals());

        emit Deposited(msg.sender, amount);
    }
}
