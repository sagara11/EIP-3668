// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.9;

// // Import this file to use console.log
// import "hardhat/console.sol";

// contract Oracle {
//      error InvalidOperation();
//     error OffchainLookup(address sender, string[] urls, bytes callData, bytes4 callbackFunction, bytes extraData);

//     function getDataOracle(bytes calldata data) external view returns(bytes memory) {
//         try target.b(data) returns (bytes memory ret) {
//             return ret;
//         } catch OffchainLookup(address sender, string[] urls, bytes callData, bytes4 callbackFunction, bytes extraData) {
//             if(sender != address(target)) {
//                 revert InvalidOperation();
//             }
//             revert OffchainLookup(
//                 address(this),
//                 urls,
//                 callData,
//                 Oracle.aCallback.selector,
//                 abi.encode(address(target), callbackFunction, extraData)
//             );
//         }
//     }

//     function oracleCallback(bytes calldata response, bytes calldata extraData) external view returns(bytes memory) {
//         (address inner, bytes4 innerCallbackFunction, bytes memory innerExtraData) = abi.decode(extraData, (address, bytes4, bytes));
//         return abi.decode(inner.call(abi.encodeWithSelector(innerCallbackFunction, response, innerExtraData)), (bytes));
//     }
// }
