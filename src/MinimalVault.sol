// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// solhint-disable-next-line no-empty-blocks
contract MinimalVault {
    /*//////////////////////////////////////////////////////////////
                                USER DATA
    //////////////////////////////////////////////////////////////*/
    mapping(address => uint256) public depositsOf;
    uint256 public totalETHDeposited;

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    event Deposit(address indexed depositor, uint256 indexed amount);
    event Withdraw(address indexed depositor, uint256 indexed amount);

    /*//////////////////////////////////////////////////////////////
                        DEPOSIT/WITHDRAWAL LOGIC
    //////////////////////////////////////////////////////////////*/
    function deposit() public payable {}

    function withdraw() public {}
}
