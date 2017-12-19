pragma solidity ^0.4.0;
import "./Controller.sol";
contract  Agent{
    address admin;
    address ControllerAddr;
    address FactoryAddr;
    address EntityMapAddr;
    address publicBlockMapAddr;    

    function Agent() public {
        admin = msg.sender;
    }

    function setController(address addr) public{
        controllerCheck();
        ControllerAddr = addr;
    }
    function getController() public constant returns(address){
        factoryCheck();
        return ControllerAddr;
    }
    
    function setBlockMap(address addr) public{
        adminCheck();
        publicBlockMapAddr = addr;
    }
    function getBlockMap() public constant returns(address){
        adminCheck();
        return publicBlockMapAddr;
    }
    
    function setFactory(address addr) public{
        controllerCheck();
        FactoryAddr = addr;
    }
    function getFactory() public constant returns(address){
        controllerCheck();
        return FactoryAddr;
    }
    
    function setEntityMap(address addr) public{
        controllerCheck();
        address oldAddr = EntityMapAddr;
        address newAddr = addr;
        EntityMap map = EntityMap(newAddr);
        map.setPreMap(oldAddr);
    }
    function getEntityMap() public constant returns(address){
        controllerCheck();
        return EntityMapAddr;
    }
    function initEntityMap() public{
        if(FactoryAddr == 0x0000000000000000000000000000000000000000) return;
        Factory factory = Factory(FactoryAddr);
        EntityMapAddr = factory.createEntityMap();
    }
    function adminCheck() public constant{
       require(admin == msg.sender);
    }
    function controllerCheck() public constant{
        require(admin == msg.sender || ControllerAddr == msg.sender);
    }
    function factoryCheck() public constant{
        require(admin == msg.sender || FactoryAddr == msg.sender);
    }
}