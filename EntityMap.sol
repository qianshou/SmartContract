pragma solidity ^0.4.0;

contract  EntityMap{
    address admin;
    address controller;
    address agentAddr;
    mapping(string => address) hashMap;
    string[] keys;
    address preMap;
    event logger(string name,address addr1,address addr2,address addr3);
    
    function EntityMap(address _admin,address _controller,address _agent) public{
        admin = _admin;
        controller = _controller;
        agentAddr = _agent;
        logger("map construct",admin,controller,agentAddr);
    }
    
    function setController(address addr) public{
        authCheck();
        controller = addr;
    }
    
    //values functions
    function getValue(string key) public constant returns(address){
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
    function getKeyLength() public constant returns(uint){
        authCheck();
        return keys.length;
    }
    function getKeyByIndex(uint index) public constant returns(string){
        authCheck();
        return (index >= getKeyLength() || index < 0)? "" :  keys[index];
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
       //require(admin == msg.sender || controller == msg.sender || agentAddr == msg.sender);
   }
}