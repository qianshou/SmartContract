pragma solidity ^0.4.0;

contract  Entity{
    string id;
    mapping(string => string[]) hashMap;
    string[] keys;
    address[] public authList;
    
    function Entity(string _id,address _web3Addr,address _controllerAddr) public{
        id = _id;
        authList.push(_controllerAddr);
        authList.push(_web3Addr);
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
