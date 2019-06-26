pragma solidity^0.5.0;
contract Signature{
    
    bytes32 mesg;
    address owner;
    uint8 v;
    bytes32 r;
    bytes32 s;
     constructor() public {
         owner=msg.sender;
     }

   
function recoverSigner(bytes32  message, uint8 _v, bytes32 _r, bytes32 _s) internal pure returns (address)
{
    return ecrecover(message, _v, _r, _s);
}    

function getData(bytes32  _mesg,uint8 _vv, bytes32 _rr, bytes32 _ss) public {
    mesg=_mesg;
    v=_vv;
    r=_rr;
    s=_ss;
    
}
function result() public view returns(address,bool){
    return (recoverSigner(mesg,v,r,s),recoverSigner(mesg,v,r,s)==owner);
}

}