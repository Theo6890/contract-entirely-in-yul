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
    function deposit() public payable {
        uint256 amount;

        // update depositsOf
        assembly {
            amount := callvalue()
            // 0x00 - 0x3f: scratch space for hashing methods (64 bytes)
            mstore(0x00, caller())
            mstore(0x20, depositsOf.slot)

            let depositSlot := keccak256(0x00, 0x40)
            sstore(depositSlot, amount)
        }

        // update totalETHDeposited
        assembly {
            let oldTotal := sload(totalETHDeposited.slot)
            sstore(totalETHDeposited.slot, add(oldTotal, amount))
        }
    }

    function withdraw() public {}
}
