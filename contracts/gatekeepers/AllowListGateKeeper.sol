// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import "./IGateKeeper.sol";

// A GateKeeper that implements a simple allow list (really a mapping) per gate.
contract AllowListGateKeeper is IGateKeeper {

    uint256 private _lastId;
    mapping (bytes12 id => mapping (address => bool)) _isAllowedByGateId;

    function isAllowed(
        address participant,
        bytes12 id,
        bytes memory /* userData */
    )
        external
        view
        returns (bool)
    {
        return _isAllowedByGateId[id][participant];
    }

    function createGate(address[] memory members)
        external
        returns (bytes12 id)
    {
        id = ++_lastId;
        for (uint256 i = 0; i < members.length; ++i) {
            _isAllowedByGateId[id][members[i]] = true;
        }
    }
}
