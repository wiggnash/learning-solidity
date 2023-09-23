// SPDX-License-Identifier: MIT
/*

 TASK : Through the smart contract we need to raise the fund from the public 
SUPPOSE : A Company wants to raise funds through blockchain
1. Manager of the company will set the target and the time frame and 
the minimum contribution of the campaign
2. Target = amount must be received by the company from the contributors
3. Minimum contribution = Min amount Each contributors should be 
contributed

How the contribution will happen : Contributor will transfer the contribution
to the smart contract 

When the company can withdraw the funds = when the target amount is reached

There can be many campaigns : Manager can make various requests for different
crowd funding events

Manager can take the amount from the smart contract only when more than 50%
of the contributors vote for "YES" => amount will  be transfered to the 
recepient address once the target amount > than the total contribuition

Within the deadline if the target is not met , the contributors will be eligible
for the refund

*/
pragma solidity ^0.8.0;

contract Crowfunding {
    address public Manager;
    uint public minContribution;
    uint public targetAmount;
    uint public raisedAmount;
    uint public deadline;
    uint public noOfContributors;

    /* mapping the address of the contributors to the amount they are 
    contributing
    */
    mapping(address => uint) public ContributorsAmount;

    // manager can make various requests
    struct Requests {
        string description;
        address payable recepient;
        uint targetValue;
        uint noOfVoters;
        bool isRequestCompleted;
        // mapping to keep track of voting
        mapping(address => bool) isVoted;
    }

    uint public requestNumber;
    // will mapping the requestNumber will to the request struct
    mapping(uint => Requests) public requests;

    constructor(uint _targetAmount, uint _deadline) {
        targetAmount = _targetAmount;
        deadline = block.timestamp + _deadline;
        Manager = msg.sender;
        minContribution = 200 wei;
    }

    //============== seding the contribution ==================

    function sendContribution() public payable {
        // checks to be made before sending the amount
        require(block.timestamp < deadline, "The deadline is reached");
        require(
            msg.value >= minContribution,
            "Please contribute more than the minimum contributuion"
        );

        // keep tracking of number of unique contributors
        if (ContributorsAmount[msg.sender] == 0) {
            noOfContributors++;
        }

        ContributorsAmount[msg.sender] = msg.value;
        raisedAmount += msg.value;
    }

    modifier onlyManager() {
        require(msg.sender == Manager, "Only manager is allowed");
        _;
    }

    //============== Creating new requests =================

    function createRequest(
        string memory _description,
        address payable _recepient,
        uint _targetValue
    ) public onlyManager {
        //creating the object of the request struct
        Requests storage newRequest = requests[requestNumber];
        requestNumber++;
        newRequest.description = _description;
        newRequest.recepient = _recepient;
        newRequest.targetValue = _targetValue;
        newRequest.isRequestCompleted = false;
        newRequest.noOfVoters = 0;
    }

    // =============== Voting Part ============================

    function voteForRequest(uint _requestNumber) public {
        // can only vote for the request only if we contributed
        // can only vote once

        require(
            ContributorsAmount[msg.sender] > 0,
            "Only contribution is allowed to vote"
        );

        Requests storage thisRequest = requests[_requestNumber];
        require(thisRequest.isVoted[msg.sender] == false, "Already Voted");
        thisRequest.isVoted[msg.sender] == true;
        thisRequest.noOfVoters++;
    }

    // ================ Closing the Request =====================

    // ================ Refund to the contributors ==============
}
