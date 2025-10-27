// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;


// the idea of this contract is to
// 1. deposit money, from an address to the smart contract
// 2. withdraw money, from the smart contract to a caller of a function or to a specific address
contract SendWithdrawMoney {
    uint public balanceRecived; // this store the ether received history in the smart contract

    // this function recieve money from an account to smart contract
    // using the msg.value, it recieve money from an address 
    function deposit() public payable  {
        balanceRecived += msg.value;
    }

    // this get the balance in the smart contract
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    // this send ether from the smart contract to the person that call the function
    function withdrawAll() public {
        address payable to = payable(msg.sender); // the person that call on the function
        
        to.transfer(getContractBalance()); // the contract send ether to the to address of the person that clicked the button
    }

    // this send ether from the smart contract to the address indicated
    function withdrawToAddress(address payable to) public  {
        to.transfer(getContractBalance());
    }
}