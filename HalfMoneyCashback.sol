/*
Contract Address in Ropsten Network is  0x3043b125ac23d62386Eb60fDE76374C4c457ac21
*/
pragma solidity ^0.5.0;

contract HalfMoneyCashback{
    
    address owner;
    uint balance;
    modifier ownerOnly(){
        require(msg.sender==owner);
        _;
    }
    //constructor used for finding owner of the contract
    constructor() public{
        owner=msg.sender;
        
    }
    //Function for paying to the smart contract
    function pay() public payable {
        require(msg.value>0,"Not enough funds were sent");
        msg.sender.transfer(msg.value/2);
        balance=balance+(msg.value/2);
        
    }
    //function that allows only the owner of contract to transfer all remaining funds to a specific address
    function withdraw(address payable _to) public payable  ownerOnly {
        require(balance>0,"No sufficient balance");
        _to.transfer(balance);
        balance=address(this).balance;
        return;
        
    }
    //function that allows owner of contract to get balance ethers of the contract
    function getBalance() public ownerOnly view returns(uint){
        return balance;
    }
}