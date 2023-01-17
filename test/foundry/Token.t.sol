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
    function test_constant_depositEventSig() public {
        assertEq(
            instance.depositEventSig(),
            0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c
        );
    }

    function test_constant_withdrawEventSig() public {
        assertEq(
            instance.withdrawEventSig(),
            0x884edad9ce6fa2440d8a54cc123490eb96d2768479d49ff9c7366125a9424364
        );
    }

    function test_deposit_checkDepositOf() public {
        vm.prank(ALICE);

        instance.deposit{value: 1 ether}();

        assertEq(instance.depositsOf(ALICE), 1 ether);
    }

    function test_deposit_checkTotalETHDeposited() public {
        vm.prank(ALICE);

        instance.deposit{value: 1 ether}();

        assertEq(instance.totalETHDeposited(), 1 ether);
    }

    function test_deposit_withEvent_Deposit() public {
        vm.prank(ALICE);
        vm.recordLogs();

        instance.deposit{value: 1 ether}();

        ///@dev events generated with `log3`, we can use `vm.expectEmit` & `emit`
        Vm.Log[] memory entries = vm.getRecordedLogs();
        // only Deposit events registered
        assertEq(entries.length, 1);
        assertEq(entries[0].topics[0], instance.depositEventSig());
        assertEq(address(uint160(uint256(entries[0].topics[1]))), ALICE);
        assertEq(entries[0].topics[2], bytes32(uint256(1 ether)));

        //// If an element is not indexed, it not in `topics` but `data`
        // assertEq(abi.decode(entries[1].data, (string)), string(testData1));
    }
}
