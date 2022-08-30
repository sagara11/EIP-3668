// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

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
    uint256 public myData;
    address payable public owner;
    string[] urls = ["http://localhost:3000/getdata"];

    event GetMyData(uint256 _mydata);

    function getData(bytes calldata data) external view returns (uint256) {
        uint256 extraData = 3668;

        revert OffchainLookup(
            address(this),
            urls,
            data,
            this.MyCallback.selector,
            abi.encode(address(this), this.MyCallback.selector, extraData)
        );

        return myData;
    }

    function MyCallback(bytes calldata response, bytes calldata extraData)
        external
    {
        (
            address inner,
            bytes4 innerCallbackFunction,
            uint256 innerExtraData
        ) = abi.decode(extraData, (address, bytes4, uint256));

        // uint256 newData = abi.decode(response, (uint256));
        emit GetMyData(1999);
    }
}
