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
    /// @dev avoid using `constant` to have storage access in YUL
    bytes32 public depositEventSig = keccak256("Deposit(address,uint256)");
    bytes32 public withdrawEventSig = keccak256("Withdraw(address,uint256)");

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

        // emit Deposit event
        assembly {
            // no offet, no size, event signature, index 2 values as topics
            log3(0x00, 0x00, sload(2), caller(), amount)
        }
    }

    function withdraw() public {}
}
