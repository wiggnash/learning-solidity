// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract LCM {
    function min_number(uint a, uint b) private pure returns (uint) {
        return a <= b ? a : b;
    }

    function gcd(uint a, uint b) private pure returns (uint) {
        uint result;
        result = min_number(a, b);
        while (result > 0) {
            if (a % result == 0 && b % result == 0) {
                break;
            }
            result--;
        }

        return result;
    }

    function lcm(uint a, uint b) public pure returns (uint) {
        return (a / gcd(a, b)) * b;
    }
}
