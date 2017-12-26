pragma solidity ^0.4.0;

import "./LogicController.sol";
import "./FactoryController.sol";
import "./MapController.sol";

contract  IndexController is LogicController, FactoryController, MapController{
   event publicAnchor(uint blockHeight,bytes32 blockHash);
   event mapLimitNotice(uint len, address mapAddr);
   
   function IndexController() public{
       authList.push(msg.sender);
   }
   
   function addEntity(string _id) public returns(address){
        authCheck();
        address entityMapAddr = getContract("EntityMap");
        address entityAddr = _createEntity(_id);
        uint len = _addEntity(_id,entityAddr,entityMapAddr);
        if(len%protectStep == 0){
           publicAnchor(block.number,block.blockhash(block.number));
        }
        if(len >= mapLimit){
           mapLimitNotice(len,entityMapAddr);
           newEntityMap();
        }
        return entityAddr;
   }
   
   function getEntity(string _id) public view returns(address){
        authCheck();
        address entityMapAddr = getContract("EntityMap");
        address ret = _getEntity(_id,entityMapAddr);
        return ret;
   }
   
   function newEntityMap() public returns(address){
        authCheck();
        address curMapAddr = getContract("EntityMap");
        
        address newMapAddr = _createEntityMap();
        EntityMap mapContract = EntityMap(newMapAddr);
        mapContract.setPreMap(curMapAddr);
        
        setContract("EntityMap",newMapAddr);
    }
}