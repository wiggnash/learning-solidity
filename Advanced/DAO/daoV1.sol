// SPDX-License-Identifier: MIT

/*
====== DAO Decentralised autonomous organisation ========
Oraganisation which is decentralised where everybody can have a say it in
and we can use our power in the DAO with the smart contract 

----------- Voting Smart contract which is used in DAO's -------
    1. owner rights
    2. owners can approve people to vote => we dont want anybody to vote
    because smart contracts are publically accessible  
    3. where people have to pay a small amount of money to contribute to
    the cause 
------------------------------------------------------------------

1. Include the owner of the smart contract = Owner is the person who
deploys the smart contract on chain and people who are outside can also see
who is the owner of the DAO
2. Deadline to vote for something date => which can be done with uint by epoch 
time stamp ( date is done with epoch ) voting deadline 
3. Amount to pay for someone to vote => we can put money in a smart contract
with a function 
4. Candidate details
    1. name
    2. voteCount => 0 - when not voted and 1 when voted. Because ony the 
    members of the DAO can be able to vote 

5. list of all candidates => candiate array
6. mapping will store address for the people , mapped with bool to check
if we voted or not 
7. Event is used here to check whether the candidate is added or not 

*/

pragma solidity ^0.8.10;

contract Dao {
    address public owner;
    uint public votingDeadline;
    uint public voteCost = 0.01 ether;

    struct Candidate {
        string name;
        uint voteCount;
    }

    constructor(uint durationInMins) {
        owner = msg.sender;
        votingDeadline = block.timestamp + durationInMins * 1 minutes;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier beforeDeadline() {
        require(block.timestamp < votingDeadline, "Voting has already ended");
        _;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    event candidateAdded(string name);

    function addCandidate(string memory _name) public onlyOwner beforeDeadline {
        candidates.push(Candidate(_name, 0));
        emit candidateAdded(_name);
    }

    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }

    // -------------- voting function --------------------------
    /*
1. vote function will take the index of the particular candidate 
2. Only people from outside can call the vote , therefore external 
3. it will be dealing with money , therefore payable keyword
4. check the deadline before 
5. check if the candidate index if smaller than the candidates array
6. check if the value of the money they are putting in
7. vote count of a candidate is increased which 
*/

    function vote(uint candidateIndex) external payable beforeDeadline {
        require(candidateIndex < candidates.length, "Invalid index");
        require(!hasVoted[msg.sender], "You have already voted");
        require(msg.value >= voteCost, "Insufficient payment for vote");
        candidates[candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }
}
