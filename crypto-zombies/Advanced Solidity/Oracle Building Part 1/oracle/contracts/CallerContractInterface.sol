// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.25 <0.9.0;

abstract contract CallerContractInterface {
    function callback(uint256 _ethPrice, uint256 id) public virtual;
}
