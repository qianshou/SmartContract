pragma solidity ^0.4.0;

contract  BlockMap{
    address admin;
    mapping(uint => address) hashMap;
    uint[] keys;
    address preMap;
    
    function BlockMap() public{
        admin = msg.sender;
    }
    
    //values functions
    function getValue(uint key) public constant returns(address){
        authCheck();
        return hashMap[key];
    }
    function setValue(uint key,address value) public{
        authCheck();
        require(value != 0x0000000000000000000000000000000000000000);
        if(hashMap[key] == 0x0000000000000000000000000000000000000000) keys.push(key);
        hashMap[key] = value;
    }

    //keys functions
    function getKeyLength() public constant returns(uint){
        authCheck();
        return keys.length;
    }
    function getKeyByIndex(uint index) public constant returns(uint){
        authCheck();
        return (index >= getKeyLength() || index < 0)? 0 :  keys[index];
    }
    
    //config preMap
    function setPreMap(address addr) public{
        authCheck();
        preMap = addr;
    }
    function getPreMap() public constant returns(address){
        authCheck();
        return preMap;
    }
    
    function authCheck() public constant{
       require(admin == msg.sender);
   }
}