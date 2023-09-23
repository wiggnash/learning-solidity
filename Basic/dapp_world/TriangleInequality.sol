// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TriangleInequality {
    //To check if a triangle is possible with lengths a,b and c
    function check(uint a, uint b, uint c) public pure returns (bool) {
        return (a + b > c && b + c > a && a + c > b) ? true : false;
    }
}
