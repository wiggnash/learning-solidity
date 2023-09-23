// SPDX-License-Identifier: MIT

/*
========= TASK : To make a portal where people can come and 
register for an event ==============
IDEA : People have to fill a form and that form will exist on the blockchain

1. Only one event is what we are focused on 
Name and Description of the event is set
2. Informationa about the people => name , age , occupation , city , email
3. Total count of the people
4. Every event will be an smart contract
*/

/*


==== NOTES ====

1. Gas price will be in 18 decimel places, more work on the chain , more gas fees
    wei - 1,kwei - 1000,Mwei - 1000000,Gwei - 1000000000,Ether - 10^18
2. Access Modifier = Will tell us from where we can acess the
smart contract
    -> public , private , protected
3. POW and POS => consensus mechanism 
    merkel tree algorithm = node have to solve , take a data and put on chain
4. How are we able change the value of the variables ?
    Whenever we transact with new information , new block is created with different
    set of memeory locations etc
5. Remiv VM = These are the local blockchain that we are getting for testing purpose
6. view keyboard = only to show the data from the function

================ */

pragma solidity ^0.8.1;

contract Register {
    uint totalPeople;
    uint limitPeople; // always going to be less than or equal totalPeople

    string public nameOfEvent;
    string public eventDescription;

    //form to be filled in by the people when they are registering for an event
    struct Person {
        string name;
        uint age;
        string occupation;
        string city;
        string email;
    }

    // array for the poeple who are registering for the event
    Person[] Attendees;

    function setEventDetails(
        string memory _nameOfEvent,
        string memory _eventDescription
    ) public {
        nameOfEvent = _nameOfEvent;
        eventDescription = _eventDescription;
    }

    function setLimitPeople(uint _limitPeople) public {
        limitPeople = _limitPeople;
    }

    function getLimitPeople() public view returns (uint) {
        return limitPeople;
    }

    function setPersonDetails(
        string memory _name,
        uint _age,
        string memory _occupation,
        string memory _city,
        string memory _email
    ) public {
        totalPeople++;
        Attendees.push(Person(_name, _age, _occupation, _city, _email));
    }

    function getNumberOfPeople() public view returns (uint, uint) {
        return (totalPeople, limitPeople);
    }

    function getAttendeesList() public view returns (Person[] memory) {
        return Attendees;
    }
}
