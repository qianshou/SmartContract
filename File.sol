pragma solidity ^0.4.6;

contract File{
    mapping(string => string[]) hashMap;
    string[] keys;

    //values functions
    function getValue(string key) public constant returns(string){
        return (isEmpty(key) == true)? "" :  hashMap[key][getValueLength(key)-1];
    }
    function getAttributeValueByIndex(string key,uint index) public constant returns(string){
        return (index >= getValueLength(key) || index < 0)? "" : hashMap[key][index];
    }
    function setAttrubuteValue(string key,string memory value) public returns(uint){
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
    function isEmpty(string key) private constant returns(bool){
        return hashMap[key].length == 0;
    }
    function getValueLength(string key) public constant returns(uint){
        return hashMap[key].length;
    }

    //keys functions
    function getKeyLength() public constant returns(uint){
        return keys.length;
    }
    function getKeyByIndex(uint index) public constant returns(string){
        return (index >= getKeyLength() || index < 0)? "" :  keys[index];
    }
}