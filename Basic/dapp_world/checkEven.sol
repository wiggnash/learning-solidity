// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    function Checkeven(int _a) public pure returns (bool) {
        return _a % 2 == 0;
    }
}
