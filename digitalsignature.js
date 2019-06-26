var Web3 = require('web3');
var web3 = new Web3('http://127.0.0.1:7545');
web3.eth.getAccounts().then(e=>web3.eth.defaultAccount=e[0])
console.log("signing with private key of default account");
console.log("default account is ",web3.eth.defaultAccount)
privatekey="0xf9e2fc2e8dc9372aeda51869b058085ba90abd3864d6c5b3505d682521bd514a"
x=web3.eth.accounts.sign("hello",privatekey)
console.log("Signature object is ",x)
y=web3.eth.accounts.privateKeyToAccount(privatekey)
console.log("account for signed private key is ",y);
rec=web3.eth.accounts.recover(x)
console.log("recovered account is ",rec)
if(rec===y.address){
console.log("signature is valid")
}
else{
console.log("signature is not valid")
}






