pragma solidity ^0.4.0;

import "./Entity.sol";
import "./EntityMap.sol";
import "./Factory.sol";
import "./Agent.sol";

contract  Controller{
   address admin;
   address public factoryAddr;
   address public curEntityMapAddr;
   address agentAddr;
   uint protectStep;
   uint entityMapLimit;
   
   event publicAnchor(uint blockHeight,bytes32 blockHash);
   
   function Controller(address _agent) public{
        admin = msg.sender;
        protectStep = 2;
        entityMapLimit = 3;
        agentAddr = _agent;
   }
   
   function addEntity(string id) public returns(address){
       authCheck();
       Agent agent = Agent(agentAddr);
       curEntityMapAddr = agent.getEntityMap();
       factoryAddr = agent.getFactory();
       Factory factory = Factory(factoryAddr);
       address entityAddr = factory.createEntity(id);
       
       EntityMap entityMap = EntityMap(curEntityMapAddr);
       entityMap.setValue(id,entityAddr);
       
       uint len = entityMap.getKeyLength();
       if(len%protectStep == 0){
           publicAnchor(block.number,block.blockhash(block.number));
       }
       if(len >= entityMapLimit){
           curEntityMapAddr = factory.createEntityMap();
           agent.setEntityMap(curEntityMapAddr);
       }
       return entityAddr;
   }
   
   function getEntity(string id) public returns(address){
        authCheck();
        Agent agent = Agent(agentAddr);
        curEntityMapAddr = agent.getEntityMap();
        EntityMap entityMap = EntityMap(curEntityMapAddr);
        
        address addr = entityMap.getValue(id);
        if(addr != 0x0000000000000000000000000000000000000000){
            return addr;
        }
        address preAddr = entityMap.getPreMap();
        while(preAddr != 0x0000000000000000000000000000000000000000){
            entityMap = EntityMap(preAddr);
            addr = entityMap.getValue(id);
            if(addr != 0x0000000000000000000000000000000000000000){
                return addr;
            }else{
                preAddr = entityMap.getPreMap();
            }
        }
        return 0x0000000000000000000000000000000000000000;
   }
   
   function authCheck() constant private{
       require(admin == msg.sender);
   }
}
