// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../src/MinimalVault.sol";

contract MinimalVaultTest is Test {
    MinimalVault public instance;

    address public constant FORGE = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;

    address public constant ALICE = 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990;
    address public constant BOB = 0xDEe2C8F3345104f6DD081657D180A9058Be7Ab05;

    function setUp() public {
        instance = new MinimalVault();

        vm.deal(ALICE, 7 ether);
        vm.deal(BOB, 7 ether);
    }

    /*//////////////////////////////////////////////////////////////
                                 BASIC ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    function test_truthy() public {
        assertTrue(true);
    }
}
