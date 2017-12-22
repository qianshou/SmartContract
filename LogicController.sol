pragma solidity ^0.4.0;

import "./Entity.sol";
import "./EntityMap.sol";

contract LogicController{
   uint protectStep = 2;
   uint mapLimit = 3;
   address emptyAddr = 0x0000000000000000000000000000000000000000;
   event publicAnchor(uint blockHeight, bytes32 blockHash);
   event mapLimitNotice(uint len, address mapAddr);
   
   function _addEntity(string _id,address _entityAddr,address _mapAddr) internal{
        EntityMap mapContract = EntityMap(_mapAddr);
        mapContract.setValue(_id,_entityAddr);
        uint len = mapContract.getKeyLength();
        if(len%protectStep == 0){
           publicAnchor(block.number,block.blockhash(block.number));
        }
        if(len >= mapLimit){
           mapLimitNotice(len,_mapAddr);
        }
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
}