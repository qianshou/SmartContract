pragma solidity ^0.4.0;

import "./Entity.sol";
import "./EntityMap.sol";

contract  Controller{
    address emptyAddr = 0x0000000000000000000000000000000000000000;
    address[] authList;
    event authLog(string name,address addr);
    
    function authCheck() internal view{
        /*
        if(authListCheck() == false){
            authLog("Controller access deny",msg.sender);
        }
        */
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