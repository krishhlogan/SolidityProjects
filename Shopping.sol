/*
Contract Address in Ropsten Network is  0x852357cBF681fdFd0406c0c4806080459B24c4b8
*/

pragma solidity ^0.5.0;
contract Shopping{
    
    address admin;
    constructor() public{
        admin=msg.sender;
    }
    
    struct Product{
        bytes32 id;
        uint256 cost;
        Seller seller;
    }
    struct Seller{
        address payable  seller;
        bool isWhiteListed;
        // Product[] products;
        mapping(bytes32=>uint256) products;
    }
    struct Buyer{
        address payable buyer;
        mapping(bytes32=>bool) cart;
    }
    Product[] productList;
    uint256 numOfProducts;
    mapping(address=>Seller) sellers;
    mapping(bytes32=>address) sellersAndId;
    mapping(address=>Buyer) buyers;

    modifier onlyAdmin(){
        require(admin==msg.sender,"Only admin can access this content");
        _;
    }
    modifier onlySeller(){
        require(sellers[msg.sender].isWhiteListed,"You are not WhiteListed");
        _;
    }
    function whiteListAddress(address _address) public onlyAdmin {
    require(_address!=address(0),"address cant be empty");
        if(address(sellers[_address].seller)!=address(0)){
        sellers[_address].isWhiteListed=true;
        }
        else{
            sellers[_address].isWhiteListed=true;
        }
    }
    
    function addProduct(bytes32 id,uint256 price) public onlySeller{
        require(id!=0 || id!=0x0,"id should not be empty");
        require(price>0,"price should be greater than or equal to zero");   
        sellersAndId[id]=msg.sender;
        sellers[msg.sender].seller=msg.sender;
        sellers[msg.sender].products[id]=price;
        //productList.push(Product(id,price,sellers[msg.sender]));
        numOfProducts=numOfProducts+1;
        }
    
    function buyContent(bytes32 id) public payable{
        require(id!=0 || id!=0x0,"id should not be empty");
        require(sellers[sellersAndId[id]].isWhiteListed,"This item does not exist");
        require(buyers[msg.sender].cart[id]==false,"You already paid and have this item in your cart");
        require(sellers[sellersAndId[id]].products[id]==msg.value,"Please send correct amount of ethers");
        buyers[msg.sender].buyer=msg.sender;
        buyers[msg.sender].cart[id]=true;
    }
    
    function getContentCount() public view returns(uint256){
        
        return numOfProducts;
    }
    
    function buyCheck(address _from,bytes32 _id) public onlySeller view returns(bool){
        require(_from!=address(0),"address cant be empty");
        require(_id!=0 || _id!=0x0,"id should not be empty");
        require(sellersAndId[_id]==msg.sender,"You dont have permission to check for  this item");
        if(buyers[_from].cart[_id] ){
            return true;
        }
        else{
            return false;
        }

        

        
    }

    
    
    
}