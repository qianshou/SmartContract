pragma solidity ^0.4.0;

import "./Entity.sol";
import "./EntityMap.sol";

contract FactoryController{
    event logger(string name,address addr);

    function _createEntity(string _id) internal returns(address){
        address addr = new Entity(_id);
        logger("CreateEntity",addr);
        return addr;
    }
    
    function _createEntityMap() internal returns(address){
        address addr = new EntityMap();
        logger("CreateEntityMap",addr);
        return addr;
    }
}