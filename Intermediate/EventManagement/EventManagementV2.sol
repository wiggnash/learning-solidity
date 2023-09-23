// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {
    struct Event {
        address organizer;
        string nameOfEvent;
        string descriptionOfEvent;
        uint dateOfEvent;
        uint ticketPrice;
        uint ticketCount;
        uint ticketRemaining;
    }

    mapping(uint => Event) public eventsWithID;
    Event[] public events;
    mapping(address => mapping(uint => uint)) public tickets; // which address holds how many tickets for the specific events
    uint eventID;

    function createEvent(
        string memory nameOfEvent,
        string memory _descriptionOfEvent,
        uint _dateOfEvent,
        uint _price,
        uint _ticketCount
    ) external {
        require(
            _dateOfEvent > block.timestamp,
            "You can createEvent only for the future dates"
        );
        require(_ticketCount > 0, "Ticket count would have to be more than 0");
        eventsWithID[eventID] = Event(
            msg.sender,
            nameOfEvent,
            _descriptionOfEvent,
            _dateOfEvent,
            _price,
            _ticketCount,
            _ticketCount
        );
        events.push(
            Event(
                msg.sender,
                nameOfEvent,
                _descriptionOfEvent,
                _dateOfEvent,
                _price,
                _ticketCount,
                _ticketCount
            )
        );
        eventID++;
    }

    function buyTicket(uint _id, uint _noOfTickets) external payable {
        require(
            eventsWithID[_id].dateOfEvent != 0,
            "This event does not exist"
        );
        require(
            block.timestamp < eventsWithID[_id].dateOfEvent,
            "The event is over"
        );
        Event storage _event = eventsWithID[_id];
        require(_event.ticketRemaining >= _noOfTickets, "Not enough Tickets");
        require(
            msg.value == (_event.ticketPrice * _noOfTickets),
            "Not enough ethers to buy tickets"
        );
        _event.ticketRemaining -= _noOfTickets;
        tickets[msg.sender][_id] += _noOfTickets;
    }

    function transferTicket(
        uint _id,
        uint _noOfTickets,
        address receiverAddress
    ) external {
        require(
            eventsWithID[_id].dateOfEvent != 0,
            "This event does not exist"
        );
        require(
            block.timestamp < eventsWithID[_id].dateOfEvent,
            "The event is over"
        );
        require(tickets[msg.sender][_id] >= _noOfTickets);
        tickets[msg.sender][_id] -= _noOfTickets;
        tickets[receiverAddress][_id] += _noOfTickets;
    }

    function getAllEvents() public view returns (Event[] memory) {
        return events;
    }
}
