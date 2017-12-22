pragma solidity ^0.4.0;

import "./LogicController.sol";
import "./FactoryController.sol";

contract  FacadeController is LogicController, FactoryController{
   address public entityMapAddr;
   address[] authList;
   
   event publicAnchor(uint blockHeight,bytes32 blockHash);

   function addEntity(string _id) public returns(address){
        require(entityMapAddr != emptyAddr);
        address entityAddr = _createEntity(_id);
        _addEntity(_id,entityAddr,entityMapAddr);
        return entityAddr;
   }
   
   function getEntity(string _id) public view returns(address){
        address ret = _getEntity(_id,entityMapAddr);
        return ret;
   }
   
   function setMapAddr(address _addr) public{
       entityMapAddr = _addr;
   }
   
   function newEntityMap() public returns(address){
       return  _createEntityMap();
   }
   
   function authCheck() constant private returns(bool){
       address vistor = msg.sender;
       for(uint i=0;i<authList.length;i++){
           if(authList[i] == vistor) return true;
       }
       return false;
   }
}
