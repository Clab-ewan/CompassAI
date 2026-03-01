// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MockUSDT.sol";
import "../src/MockYieldVault.sol";
import "../src/EnterpriseVault.sol";

contract DeployScript is Script {
    function run() external {
        // Grab the private key from your .env file
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        console.log("Deploying contracts with address:", deployerAddress);

        // Start broadcasting transactions to the network
        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy the Mock Stablecoin
        MockUSDT usdt = new MockUSDT();
        console.log("MockUSDT deployed to:", address(usdt));

        // 2. Deploy the Mock Yield Vault (passing the USDT address)
        MockYieldVault yieldVault = new MockYieldVault(address(usdt));
        console.log("MockYieldVault deployed to:", address(yieldVault));

        // 3. Deploy the Enterprise Treasury Vault (owned by the deployer for now)
        EnterpriseVault enterpriseVault = new EnterpriseVault(deployerAddress);
        console.log("EnterpriseVault deployed to:", address(enterpriseVault));

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("Phase 1 Deployment Complete! Save these addresses for Phase 2.");
    }
}
