// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.25 <0.9.0;

// import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CallerContractInterface.sol";

contract EthPriceOracle is Ownable {
    uint256 private randNonce = 0;
    uint256 private modulus = 1000;
    mapping(uint256 => bool) pendingRequests;
    event GetLatestEthPriceEvent(address callerAddress, uint256 id);
    event SetLatestEthPriceEvent(uint256 ethPrice, address callerAddress);

    function getLatestEthPrice() public returns (uint256) {
        randNonce++;
        uint256 id = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))
        ) % modulus;
        pendingRequests[id] = true;
        emit GetLatestEthPriceEvent(msg.sender, id);
        return id;
    }

    function setLatestEthPrice(
        uint256 _ethPrice,
        address _callerAddress,
        uint256 _id
    ) public onlyOwner {
        require(
            pendingRequests[_id],
            "This request is not in my pending list."
        );
        delete pendingRequests[_id];
        CallerContractInterface callerContractInstance;
        callerContractInstance = CallerContractInterface(_callerAddress);
        callerContractInstance.callback(_ethPrice, _id);
        emit SetLatestEthPriceEvent(_ethPrice, _callerAddress);
    }
}
