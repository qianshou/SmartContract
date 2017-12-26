pragma solidity ^0.4.0;

import "./Controller.sol";

contract LogicController is Controller{
    
   uint protectStep = 2;
   uint mapLimit = 3;
   
   function _addEntity(string _id,address _entityAddr,address _mapAddr) internal returns(uint){
        EntityMap mapContract = EntityMap(_mapAddr);
        mapContract.setValue(_id,_entityAddr);
        uint len = mapContract.getKeyLength();
        return len;
   }
   
   function _getEntity(string _id,address _mapAddr) internal view returns(address){
        address addr = emptyAddr;
        address preMapAddr = emptyAddr;
        address mapAddr = _mapAddr;
        do{
            EntityMap entityMapContract = EntityMap(mapAddr);
            addr = entityMapContract.getValue(_id);
            if(addr != emptyAddr) return addr;
            preMapAddr = entityMapContract.getPreMap();
            mapAddr = preMapAddr;
        }
        while(preMapAddr != emptyAddr);
        return addr;
   }
   
   function _setProtectStep(uint _step) public{
        protectStep = _step;
   }
   
   function _setMapLimit(uint _limit) public{
       mapLimit = _limit;
   }
}