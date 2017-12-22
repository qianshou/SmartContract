pragma solidity ^0.4.0;

import "./FacadeController.sol";

contract  Agent{
    address public creatorAddr;
    address emptyAddr = 0x0000000000000000000000000000000000000000;
    mapping(string => address) map;
    function Agent() public {
        creatorAddr = msg.sender;
    }
    
    function setContractAddr(string _name,address _addr) public{
        map[_name] = _addr;
    }
    function getContractAddr(string _name) public view returns(address){
        return map[_name];
    }
    
    function newEntityMap() public returns(address){
        address facadeAddr = getContractAddr("FacadeController");
        require(facadeAddr != emptyAddr);
        
        FacadeController facadeContract = FacadeController(facadeAddr);
        address newMapAddr = facadeContract.newEntityMap();
        address curMapAddr = getContractAddr("EntityMap");
        EntityMap mapContract = EntityMap(newMapAddr);
        mapContract.setPreMap(curMapAddr);
        
        setContractAddr("EntityMap",newMapAddr);
        facadeContract.setMapAddr(newMapAddr);
    }
}