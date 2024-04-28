// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Transaction {
    address payable public sender;
    address payable public receiver;
    bool public senderConfirmed;
    bool public receiverConfirmed;

    constructor(address payable _receiver) payable {
        sender = payable(msg.sender);
        receiver = _receiver;
    }
    
    
    function confirmSender() public onlySender {
        senderConfirmed = true;
        if (receiverConfirmed == true) startTransaction();
    }
    function refuseSender() public onlySender {
        senderConfirmed = false;
        goToFirstSupportLevel();
    }
    

    function confirmReceiver() public onlyReciver {
        receiverConfirmed = true;
        if (senderConfirmed == true) startTransaction();
    }
    function refuseReceiver() public payable onlyReciver {
        sender.transfer(getBalance());
    }
    
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function startTransaction() private  {
        require(senderConfirmed == true && receiverConfirmed == true, "Both sender and receiver must confirm the transaction");
        receiver.transfer(getBalance());
    }


    modifier onlySender() {
        require(msg.sender == sender, "Only sender can confirm this");
        _;
    }

    modifier onlyReciver() {
        require(msg.sender == receiver, "Only reciver can confirm this");
        _;
    }

    function goToFirstSupportLevel()private {
       // here will be the go to AI method
    }
    
}
