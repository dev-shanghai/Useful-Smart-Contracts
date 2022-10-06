// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.25 <0.9.0;

abstract contract EthPriceOracleInterface {
    function getLatestEthPrice() public virtual returns (uint256);
}
