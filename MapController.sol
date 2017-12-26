pragma solidity ^0.4.0;

import "./Controller.sol";

contract  MapController is Controller{
    mapping(string => address) hashMap;
    string[] keys;
    
    //values functions
    function getContract(string key) public view returns(address){
        return hashMap[key];
    }
    
    function setContract(string key,address value) public {
        require(value != emptyAddr);
        if(hashMap[key] == emptyAddr) keys.push(key);
        hashMap[key] = value;
    }

    //keys functions
    function _getContractKeyLength() internal view returns(uint){
        return keys.length;
    }
    
    function _getContractKeyByIndex(uint index) internal view returns(string){
        return (index >= _getContractKeyLength() || index < 0)? "" :  keys[index];
    }

}