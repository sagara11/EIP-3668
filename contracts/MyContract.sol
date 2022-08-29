// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

error InvalidOperation();
error OffchainLookup(
    address sender,
    string[] urls,
    bytes callData,
    bytes4 callbackFunction,
    bytes extraData
);

contract MyContract {
    uint256 public unlockTime;
    address payable public owner;

    event Withdrawal(uint256 amount, uint256 when);

    function getData(bytes calldata data) external view returns (bytes memory) {
        revert OffchainLookup(
            address(this),
            urls,
            callData,
            Oracle.aCallback.selector,
            abi.encode(address(target), callbackFunction, extraData)
        );
    }

    function MyCallback(bytes calldata response, bytes calldata extraData)
        external
        view
        returns (bytes memory)
    {
        (
            address inner,
            bytes4 innerCallbackFunction,
            bytes memory innerExtraData
        ) = abi.decode(extraData, (address, bytes4, bytes));
        return
            abi.decode(
                inner.call(
                    abi.encodeWithSelector(
                        innerCallbackFunction,
                        response,
                        innerExtraData
                    )
                ),
                (bytes)
            );
    }
}
