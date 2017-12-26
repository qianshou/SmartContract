pragma solidity ^0.4.0;

contract  EntityMap{
    mapping(string => address) hashMap;
    string[] keys;
    address preMap;
    address[] public authList;
    
    function EntityMap(address _web3Addr,address _controllerAddr) public{
        authList.push(_controllerAddr);
        authList.push(_web3Addr);
    }
    
    //values functions
    function getValue(string key) public view returns(address){
        authCheck();
        return hashMap[key];
    }
    function setValue(string key,address value) public{
        authCheck();
        require(value != 0x0000000000000000000000000000000000000000);
        if(hashMap[key] == 0x0000000000000000000000000000000000000000) keys.push(key);
        hashMap[key] = value;
    }

    //keys functions
    function getKeyLength() public view returns(uint){
        authCheck();
        return keys.length;
    }
    function getKeyByIndex(uint index) public view returns(string){
        authCheck();
        return (index >= getKeyLength() || index < 0)? "" :  keys[index];
    }
    
    //config preMap
    function setPreMap(address addr) public{
        authCheck();
        preMap = addr;
    }
    function getPreMap() public view returns(address){
        authCheck();
        return preMap;
    }
    
    function authCheck() private view {
        require(authListCheck()==true);
    }
    
    function authListCheck() constant private returns(bool){
       address vistor = msg.sender;
       for(uint i=0;i<authList.length;i++){
           if(authList[i] == vistor) return true;
       }
       return false;
   }
}