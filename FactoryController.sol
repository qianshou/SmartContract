pragma solidity ^0.4.0;

import "./Controller.sol";

contract FactoryController is Controller{
    event logger(string name,address addr);

    function _createEntity(string _id) internal returns(address){
        address addr = new Entity(_id,authList[0],this);
        logger("CreateEntity",addr);
        return addr;
    }
    
    function _createEntityMap() internal returns(address){
        address addr = new EntityMap(authList[0],this);
        logger("CreateEntityMap",addr);
        return addr;
    }
}