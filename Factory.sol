pragma solidity ^0.4.0;

import "./Entity.sol";
import "./Agent.sol";
import "./EntityMap.sol";

contract Factory{
    address admin;
    address public agentAddr;
    address public controller;
    event logger(string name,address addr);
    
    function Factory(address _agent) public{
        admin = msg.sender;
        agentAddr = _agent;
    }
    
    function initController() public{
       authCheck();
       Agent agent = Agent(agentAddr);
       controller = agent.getController();
   }
    
    function createEntity(string key) public returns(address){
        authCheck();
        
        address addr = new Entity(key,admin,controller);
        logger("CreateEntity",addr);
        return addr;
    }
    
    function createEntityMap() public returns(address){
        authCheck();
        
        address addr = new EntityMap(admin,controller,agentAddr);
        logger("CreateEntityMap",addr);
        return addr;
    }
    
    function setController(address addr) public{
        authCheck();
        controller == addr;
    }
    
    function authCheck() private constant{
       require(admin == msg.sender || controller == msg.sender || agentAddr == msg.sender);
   }
}