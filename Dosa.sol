// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Dosa {
    struct Message {
        string name;
        string message;
        uint timestamp;
        address from;
    }

    Message[] messages;
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function buyMeDosa(
        string calldata _name,
        string calldata _message
    ) external payable {
        require(msg.value > 0, "Please add some amount of money");
        owner.transfer(msg.value);
        messages.push(Message(_name, _message, block.timestamp, msg.sender));
    }

    function getMessages() public view returns (Message[] memory) {
        return messages;
    }
}
