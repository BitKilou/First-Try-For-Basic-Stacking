pragma solidity 0.8.0;
pragma abicoder v2;

 //@notice This is a Test of stacking, only for Training;

contract StackingExample {

    address[] private owners;

    //@notice we want to know who has stacked;
    address[] internal stakeHolders;

    //@dev for onlyOwner purpose;
     constructor (address[] memory _owners){
        owners = _owners;
    }

    //@notice Create a onlyOwner;
  modifier onlyOwners(){
    bool owner = false;
    for(uint i = 0; i < owners.length; i++){
        if(owners[i] == msg.sender){
            owner = true;
        }
    }
    require(owner = true);
        _;
    }

    //@dev To be able to easily query these infos;
    mapping(address => uint) internal stakes;
    mapping(address => uint) internal rewards;


    //@dev Deposit Funds on the S.C;
    function createStack(uint _stack) public {
        stakes[msg.sender] = stakes[msg.sender] + _stack;
    }

    //@dev withdraw funds from S.C;
    function withdraw(uint _stack) public {
        stakes[msg.sender] = stakes[msg.sender] - _stack;
    }

    //@dev to query the stake of a stakeholder;
    function stakeOf(address _stackHolder) public view returns(uint){
        return stakes[_stackHolder];
    }

    //@dev Query the total amount stacked in the Smart. C;
    function totalStacked() public view returns(uint){
        uint counter = 0;
        for(uint i = 0; i < stakeHolders.length; i++){
            counter = counter += stakes[stakeHolders[i]];
        }
        return counter;
    }

    //@notice adding a new stakeHolder;
    function addStackHolder(address _newStackHolder) public {
        stakeHolders.push(_newStackHolder);
    }

    //@dev Amount to distribute;
    function reward(address _stackHolder) public view returns(uint) {
        return rewards[_stackHolder];
    }

    //@notice Total amount of reward in the S.C to be distributed;
    function totalReward() public view returns(uint){
        uint counter = 0;
        for(uint i = 0; i < stakeHolders.length; i++){
            counter = counter += rewards[stakeHolders[i]];
        }
        return counter;
    }

    function rewardCalcul(address _stackHolder) public view returns(uint) {
        return stakes[_stackHolder] / 100;
    }

    //@notice send the token back + the reward;
    function giveReward() public onlyOwners {
        for(uint i = 0; i < stakeHolders.length; i++){
            address stakeHolder = stakeHolders[i];
            uint256 recompense = rewardCalcul(stakeHolder);
            rewards[stakeHolder] = rewards[stakeHolder] += recompense;
        }
    }

}
