pragma solidity ^0.4.0;

contract  Entity{
    address admin;
    address controller;
    string id;
    mapping(string => string[]) hashMap;
    string[] keys;
    
    function Entity(string _id,address _admin, address _controller) public{
        id = _id;
        admin = _admin;
        controller = _controller;
    }
    
    function getId() public constant returns(string){
        authCheck();
        
        return id;
    }

    //values functions
    function getValue(string key) public constant returns(string){
        authCheck();
        
        return (isEmpty(key) == true)? "" :  hashMap[key][getValueLength(key)-1];
    }
    function getValueByIndex(string key,uint index) public constant returns(string){
        authCheck();
        
        return (index >= getValueLength(key) || index < 0)? "" : hashMap[key][index];
    }
    function setValue(string key,string value) public returns(uint){
        authCheck();
        
        if(isEmpty(key) == true){
            keys.push(key);
            return hashMap[key].push(value);
        }else{
            //avoid to repeat insert
            if(sha256(hashMap[key][getValueLength(key)-1]) != sha256(value)){
                return hashMap[key].push(value);
            }else{
                return 0;
            }
        }
    }
    function isEmpty(string key) public constant returns(bool){
        authCheck();
        
        return hashMap[key].length == 0;
    }
    function getValueLength(string key) public constant returns(uint){
        authCheck();
        
        return hashMap[key].length;
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
    
    function authCheck() public constant{
       require(admin == msg.sender || controller == msg.sender);
   }
}
