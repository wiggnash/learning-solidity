// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
Given 3 numbers, we want to check wheather it is possible to create a right 
angled triangle such that the lengths of the 3 sides of the triangle are same as the 3 numbers
*/
contract RightAngledTriangle {
    //To check if a triangle with side lenghts a,b,c is a right angled triangle
    function check(uint a, uint b, uint c) public pure returns (bool) {
        if ((a == 0 && b == 0 && c == 0) || (a == 0 || b == 0 || c == 0)) {
            return false;
        } else {
            uint[3] memory triSides = [a, b, c];
            for (uint i = 0; i < 3; i++) {
                for (uint j = i + 1; j < 3; j++) {
                    if (triSides[i] > triSides[j]) {
                        uint temp = triSides[i];
                        triSides[i] = triSides[j];
                        triSides[j] = temp;
                    }
                }
            }

            uint twoSides = triSides[0] ** 2 + triSides[1] ** 2;
            if (twoSides == triSides[2] ** 2) {
                return true;
            } else {
                return false;
            }
        }
    }
}
