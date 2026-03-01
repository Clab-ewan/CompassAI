// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract EnterpriseVault is Ownable {
    
    event TransactionExecuted(address indexed target, uint256 value, bytes data);

    constructor(address initialOwner) Ownable(initialOwner) {}
    
    // Allow the vault to receive native AVAX
    receive() external payable {}

    // This is the function the AI will prepare data for!
    function executeBatch(
        address[] calldata targets,
        uint256[] calldata values,
        bytes[] calldata payloads
    ) external onlyOwner {
        require(targets.length == values.length && targets.length == payloads.length, "Mismatched arrays");

        for (uint i = 0; i < targets.length; i++) {
            (bool success, ) = targets[i].call{value: values[i]}(payloads[i]);
            require(success, "Transaction failed in batch");
            emit TransactionExecuted(targets[i], values[i], payloads[i]);
        }
    }

}