// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../src/MinimalVault.sol";

contract MinimalVaultTest is Test {
    MinimalVault public instance;

    function setUp() public {
        instance = new MinimalVault();
    }

    /*//////////////////////////////////////////////////////////////
                                 BASIC ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    function test_truthy() public {
        assertTrue(true);
    }
}
